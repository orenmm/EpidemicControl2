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
        [Virus getViruses:^(NSArray* array){
            instance.viruses = array;
        }];
    }
    return instance;
}
-(id)init
{
    self =[super init];
    
    return self;
}

-(Virus*)getVirusFromVirusId:(int)virusId{
    
    for (Virus *virus in instance.viruses)
    {
        if (virusId==virus.virusid)
        {
            return virus;
        }
       
    }
    
    Virus *virus2 = [[Virus alloc]init];
    virus2.name=@"notGood";
    virus2.icon=@"virus01";
    return virus2;

}

@end
