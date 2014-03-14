//
//  LocationMapViewViewController.h
//  EpidemicControl
//
//  Created by Oren Mor on 3/6/14.
//  Copyright (c) 2014 EpidemicControl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "markerOnMap.h"
#import "User.h"

@interface LocationMapViewViewController : UIViewController<MKMapViewDelegate, UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet MKMapView *map;
- (IBAction)hideKeyboard:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *mapTextField;
- (IBAction)searchLocation:(id)sender;

@property (nonatomic,strong) User* user;
- (IBAction)goToAddInfection:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *errorINlocation;

-(void)refreshMapMarkers;
@end
