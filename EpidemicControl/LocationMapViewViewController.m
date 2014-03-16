//
//  LocationMapViewViewController.m
//  EpidemicControl
//
//  Created by Oren Mor on 3/6/14.
//  Copyright (c) 2014 EpidemicControl. All rights reserved.
//

#import "LocationMapViewViewController.h"
#import "markerOnMap.h"
#import "Infection.h"
#import "EpidemecInfoView.h"
#import "MarkerButton.h"
#import <AddressBookUI/AddressBookUI.h>
#import "AddInfectedViewController.h"

@interface LocationMapViewViewController ()

@end

@implementation LocationMapViewViewController
{
    NSMutableArray *markers;
    //to handle the adress we will use a GeoCoder
    CLGeocoder *geocoder;
    MKPlacemark *placemark;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    geocoder = [[CLGeocoder alloc] init];
    markers= [[NSMutableArray alloc]init];
    self.map.layer.cornerRadius = self.map.frame.size.height/2;
    self.map.clipsToBounds = YES;
}


-(void)viewWillAppear:(BOOL)animated{
    //SHOW the navigation top bar
    self.navigationController.navigationBar.hidden = NO;
    
    self.errorINlocation.hidden = YES;
    
    //everytime this controller is loaded or reloade the map should reload the infections from the database(on the server) every infection is an annotaion=markerOnMap
    [self refreshMapMarkers];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshMapMarkers) name:@"deleteInfection" object:nil];
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    //remove all observers from this viewcontroller
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)refreshMapMarkers
{
    //everytime this controller is loaded or reloade the map should reload the infections from the database(on the server) every infection is an annotaion=markerOnMap
    [self.map removeAnnotations:self.map.annotations];
    [markers removeAllObjects];
    [Infection getInfections:^(NSArray *infections){
        for (Infection *infection in infections) {
            markerOnMap *markerInfection = [[markerOnMap alloc]initWithInfection:infection];
            [markers addObject:markerInfection];
            
        }
        [self.map addAnnotations:markers];
        
    }];
}


-(MKAnnotationView*)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    MKAnnotationView *view = [mapView dequeueReusableAnnotationViewWithIdentifier:@"randomName"];
    if(view == nil)
    {
        view = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"randomName"];
    }
    if([annotation isKindOfClass:[markerOnMap class]])
    {
        NSLog(@"%f,%f", annotation.coordinate.latitude, annotation.coordinate.longitude);
        view.frame = CGRectMake(view.frame.origin.x, view.frame.origin.y, 40, 40);
        
        markerOnMap *marker = annotation;
        UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
        imageView.image = [UIImage imageNamed:marker.imageName];
        [view addSubview:imageView];
        
        /*  **** making a custom button ***** */
        MarkerButton *markerBtn = [[MarkerButton alloc] init];
        markerBtn.frame = CGRectMake(0, 0, 40, 40);
        [markerBtn addTarget:self action:@selector(markerSelected:) forControlEvents:UIControlEventTouchUpInside];
        markerBtn.infection = marker.infection;
        view.clipsToBounds = NO;
        [view addSubview:markerBtn];
        /*  **** *********************** ***** */
    }
    else
    {
        return nil;
        //user location
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
        imageView.image = [UIImage imageNamed:@"pin1"];
        [view addSubview:imageView];
    }
    return view;
}

//-(void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view
//{
//    //Restaurant *rest = view.annotation;
//    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"title"
//                                                    message:@"Clicked !" delegate:nil cancelButtonTitle:@"Eat" otherButtonTitles:nil];
//    [alert show];
//}


//user center location + zoom (1 kilo meters)


-(void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    [self.map setCenterCoordinate:userLocation.coordinate animated:YES];
    [self.map setRegion:MKCoordinateRegionMake(userLocation.coordinate, MKCoordinateSpanMake(0.1, 0.1))];
}

//when the user select a marker the nib with the info appears
- (void)markerSelected:(MarkerButton*)sender
{
    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"EpidemecInfoView" owner:self options:nil];
    EpidemecInfoView *epidemicView = nib[0];
    MarkerButton *markerBtn = sender;
    epidemicView.frame = CGRectMake(0, 65, 320, 500);
    epidemicView.reporterNameLabel.text = [NSString stringWithFormat:@"%@ %@",markerBtn.infection.firstName,markerBtn.infection.lastName];
    epidemicView.virusNameLabel.text = markerBtn.infection.virus.name;
    epidemicView.locationLabel.text = markerBtn.infection.locationName;
    epidemicView.dateLabel.text = markerBtn.infection.date;
    epidemicView.infectionId = markerBtn.infection.infectionId;
    epidemicView.quantityLabel.text = [NSString stringWithFormat:@"%d", markerBtn.infection.quantity];
    [epidemicView setAlpha:0];
    
    [self.view addSubview:epidemicView];
    [UIView animateWithDuration:0.5 animations:^{
        [epidemicView setAlpha:1];
    }];
    CLLocation *location = [[CLLocation alloc]initWithLatitude:markerBtn.infection.latCord longitude:markerBtn.infection.longCord];
    
    [self.map setCenterCoordinate:location.coordinate animated:YES];
    [self.map setRegion:MKCoordinateRegionMake(location.coordinate, MKCoordinateSpanMake(0.1, 0.1))];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)hideKeyboard:(id)sender {
    [self.mapTextField becomeFirstResponder];
    [self.mapTextField resignFirstResponder];
    
}


-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.mapTextField becomeFirstResponder];
    [self findLocation];
    [self.mapTextField resignFirstResponder];
    return YES;
}


- (IBAction)searchLocation:(id)sender
{
    [self findLocation];
}

-(void)findLocation {
    if (self.mapTextField.text.length) {
        [geocoder geocodeAddressString:self.mapTextField.text completionHandler:^(NSArray *placemarks, NSError *error) {
            NSLog(@"%@", placemarks);
            placemark = placemarks[0];
            NSMutableArray *array = [[NSMutableArray alloc] init];
            if(placemark.subThoroughfare) [array addObject:placemark.subThoroughfare];
            if(placemark.thoroughfare) [array addObject:placemark.thoroughfare];
            if(placemark.name) [array addObject:placemark.name];
            if(placemark.locality) [array addObject:placemark.locality];
            if(placemark.subLocality) [array addObject:placemark.subLocality];
            if(placemark.administrativeArea) [array addObject:placemark.administrativeArea];
            if(placemark.subAdministrativeArea) [array addObject:placemark.subAdministrativeArea];
            if(placemark.postalCode) [array addObject:placemark.postalCode];
            if(placemark.country) [array addObject:placemark.country];
            if(placemark.inlandWater) [array addObject:placemark.inlandWater];
            if(placemark.ocean) [array addObject:placemark.ocean];
            NSString *address = [array componentsJoinedByString:@", "];
            NSLog(@"addressIS: %@", address);
            self.mapTextField.text=address;
            [self.map setCenterCoordinate:placemark.location.coordinate animated:YES];
            [self.map setRegion:MKCoordinateRegionMake(placemark.location.coordinate, MKCoordinateSpanMake(0.1, 0.1))];
        }];
    }
    [self.mapTextField resignFirstResponder];
}

- (IBAction)goToAddInfection:(id)sender {
    if (placemark) {
        [self performSegueWithIdentifier:@"LocationMapToAddInfection" sender:self];
    }
    else{
        self.errorINlocation.text = @"Please enter location first!";
        self.errorINlocation.hidden = NO;
    }
    
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    AddInfectedViewController *dest = segue.destinationViewController;
    dest.placemark=placemark;
    dest.address =self.mapTextField.text;
    
}
@end
