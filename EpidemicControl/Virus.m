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
    virus.virusid =[dictionary[@"id"] integerValue];
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

+(void)getViruses:(APIReturnsArray)completionBlock{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", nil];
    NSDictionary *parameters = @{};
    [manager POST:@"http://70.32.106.118/doctors/rest/infection/getInfections.php" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        
        NSLog(@"JSON: %@", responseObject);
        
        NSArray *viruses = [Virus fromArray:responseObject];
        completionBlock(viruses);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"Error: %@", error);
        
        
        
    }];
    
    
    

    
}

@end
