//
//  Virus.m
//  EpidemicControl
//
//  Created by Dan Galila on 3/11/14.
//  Copyright (c) 2014 EpidemicControl. All rights reserved.
//

#import "Virus.h"

@implementation Virus

+(Virus*)fromDictionary:(NSDictionary*)dictionary{
    Virus* virus = [[Virus alloc]init];
    virus.Virusid =[dictionary[@"id"] integerValue];
    virus.name =dictionary[@"name"];
    virus.icon =dictionary[@"icon"];

    return virus;
}

+(NSArray*)fromArray:(NSArray*)array {
    NSMutableArray* result =[[NSMutableArray alloc]init];
    for (NSDictionary* dict in array) {
        Virus *virus = [Virus fromDictionary:dict];
        [result addObject:virus];
    }
    return result;
    
}
@end
