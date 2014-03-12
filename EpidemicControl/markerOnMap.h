//
//  markerOnMap.h
//  EpidemicControl
//
//  Created by Oren Mor on 3/7/14.
//  Copyright (c) 2014 EpidemicControl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import "Infection.h"

@interface markerOnMap : NSObject<MKAnnotation>

@property (nonatomic,strong) Infection* infection;
@property (nonatomic, assign) CLLocationCoordinate2D coordinate;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *imageName;

//-(id)initWithcoordinates: (CLLocationCoordinate2D) coords name:(NSString*)nameparam;
-(id)initWithInfection:(Infection*)infection;

@end
