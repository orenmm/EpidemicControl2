//
//  AppData.h
//  EpidemicControl
//
//  Created by Dan Galila on 3/11/14.
//  Copyright (c) 2014 EpidemicControl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"
#import "Virus.h"
@interface AppData : NSObject

@property (nonatomic,strong) User* user;
@property (nonatomic,strong) NSArray* viruses;
+(AppData*)shareInstance;
-(Virus*)getVirusFromVirusId:(int)virusId;

@end
