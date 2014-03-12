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

@interface LocationMapViewViewController ()

@end

@implementation LocationMapViewViewController
{
    NSMutableArray *markers;
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
	
    markers= [[NSMutableArray alloc]init];
    self.map.layer.cornerRadius = self.map.frame.size.width/2;
    self.map.clipsToBounds = YES;

}


-(void)viewWillAppear:(BOOL)animated{
    //SHOW the navigation top bar
    self.navigationController.navigationBar.hidden = NO;
    
    //everytime this controller is loaded or reloade the map should reload the infections from the database(on the server) every infection is an annotaion=markerOnMap
    [self.map removeAnnotations:markers];
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
        markerOnMap *marker = annotation;
        UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 80, 80)];
        imageView.image = [UIImage imageNamed:marker.imageName];
        [view addSubview:imageView];
        //MarkerButton *markerBtn = [[MarkerButton alloc] initWithFrame:imageView.frame];
        MarkerButton *markerBtn = [MarkerButton buttonWithType:UIButtonTypeRoundedRect];
        markerBtn.frame = imageView.frame;
        markerBtn.backgroundColor = [UIColor redColor];
        [markerBtn addTarget:self action:@selector(markerSelected:) forControlEvents:UIControlEventTouchUpInside];
       // markerBtn.infection = marker.infection;
        [view addSubview:markerBtn];
    }
    else
    {
        //user location
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 64, 64)];
        imageView.image = [UIImage imageNamed:@"pin1"];
        [view addSubview:imageView];
    }
    return view;
}




//user center location + zoom (1 kilo meters)


-(void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    [self.map setCenterCoordinate:userLocation.coordinate animated:YES];
    [self.map setRegion:MKCoordinateRegionMake(userLocation.coordinate, MKCoordinateSpanMake(0.1, 0.1))];
}


- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view
{
    EpidemecInfoView *epidemicView = [[EpidemecInfoView alloc]initWithFrame:CGRectMake(0, 200, 320, 230)];
    
    /*markerOnMap *marker = view;
    epidemicView.reporterNameLabel.text = [NSString stringWithFormat:@"%@ %@",marker.infection.firstName, marker.infection.lastName];*/
    [self.view addSubview:epidemicView];
}

- (IBAction)markerSelected:(id)sender
{
    EpidemecInfoView *epidemicView = [[EpidemecInfoView alloc]initWithFrame:CGRectMake(0, 200, 320, 230)];
    MarkerButton *markerBtn = [[MarkerButton alloc]init];
    markerBtn = sender;
    epidemicView.reporterNameLabel.text = [NSString stringWithFormat:@"%@ %@",markerBtn.infection.firstName,markerBtn.infection.lastName];
    epidemicView.virusNameLabel.text = markerBtn.infection.virus.name;
    epidemicView.locationLabel.text = markerBtn.infection.locationName;
    epidemicView.dateLabel.text = markerBtn.infection.date;
    epidemicView.quantityLabel.text = [NSString stringWithFormat:@"%d", markerBtn.infection.quantity];
    
    [self.view addSubview:epidemicView];
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
    [self.mapTextField resignFirstResponder];
    return YES;
}







@end
