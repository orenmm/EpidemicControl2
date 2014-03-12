//
//  LocationMapViewViewController.m
//  EpidemicControl
//
//  Created by Oren Mor on 3/6/14.
//  Copyright (c) 2014 EpidemicControl. All rights reserved.
//

#import "LocationMapViewViewController.h"
#import "markerOnMap.h"

@interface LocationMapViewViewController ()

@end

@implementation LocationMapViewViewController

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
	// Do any additional setup after loading the view.
    markerOnMap *marker1 = [[markerOnMap alloc]initWithcoordinates:CLLocationCoordinate2DMake(0.2, 0) name:@"first place"];
    marker1.imageName = @"pin1";
    markerOnMap *marker2 = [[markerOnMap alloc]initWithcoordinates:CLLocationCoordinate2DMake(0.4, 0) name:@"second place"];
    marker2.imageName = @"pin2";
    [self.map addAnnotations:@[marker1, marker2]];
    self.map.layer.cornerRadius = 150;
    self.map.clipsToBounds = YES;

}
-(void)viewWillAppear:(BOOL)animated{
    
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















- (void)viewWillAppear:(BOOL)animated
{
    //SHOW the navigation top bar
    self.navigationController.navigationBar.hidden = NO;
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
