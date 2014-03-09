//
//  markerOnMap.m
//  EpidemicControl
//
//  Created by Oren Mor on 3/7/14.
//  Copyright (c) 2014 EpidemicControl. All rights reserved.
//

#import "markerOnMap.h"

@implementation markerOnMap


-(id)initWithcoordinates:(CLLocationCoordinate2D)coords name:(NSString *)nameparam{
    self = [super init];
    self.coordinate = coords;
    self.name = nameparam;
    
    return self;
}



@end
