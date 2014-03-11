//
//  AppData.m
//  EpidemicControl
//
//  Created by Dan Galila on 3/11/14.
//  Copyright (c) 2014 EpidemicControl. All rights reserved.
//

#import "AppData.h"

@implementation AppData

static AppData* instance;


+(AppData*)shareInstance{
    if(instance == nil)
    {
        instance = [[AppData alloc] init];
    }
    return instance;
}
-(id)init
{
    self =[super init];
    
    return self;
}


@end
