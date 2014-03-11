//
//  Infection.m
//  EpidemicControl
//
//  Created by Dan Galila on 3/9/14.
//  Copyright (c) 2014 EpidemicControl. All rights reserved.
//

#import "Infection.h"

@implementation Infection

//add infection to the server(DataBase) - we don't need a block for that but we are using the AFNetworking.
// When using this we need to first init an infection object, give it all the properties needed here (from  the controller) and then use this function.
-(void)addInfection{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", nil];
    NSDictionary *parameters = @{@"user_id": @(self.userId), @"virus_id":@(self.virusID), @"location_lat":@(self.latCord), @"location_lng":@(self.longCord),@"location_name":self.locationName, @"quantity":@(self.quantity),@"infection_date":self.date};
    [manager POST:@"http://70.32.106.118/doctors/rest/infection/addInfection.php" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        
        NSLog(@"JSON: %@", responseObject);
        
            
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"Error: %@", error);
        
        
        
    }];
    


}

//we will use this in the LoctionMapViewController , ATTTENTIOIN- the block returns array of infections :)
+(void)getInfections:(APIReturnsArray)completionBlock {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", nil];
    NSDictionary *parameters = @{};
    [manager POST:@"http://70.32.106.118/doctors/rest/infection/getInfections.php" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        
        NSLog(@"JSON: %@", responseObject);
        
        NSArray *infections = [Infection fromArray:responseObject];
        completionBlock(infections);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"Error: %@", error);
        
        
        
    }];
    
    
    
}


//for easier life  we added this  2 functions
+(Infection*)fromDictionary:(NSDictionary*)dictionary{
    Infection* infection = [[Infection alloc]init];
    infection.infectionId = [dictionary[@"id"] integerValue];
    infection.userId = [dictionary[@"user_id"] integerValue];
    infection.virusID = [dictionary[@"virus_id"] integerValue];
    infection.latCord = [dictionary[@"location_lat"] floatValue];
    infection.longCord = [dictionary[@"location_lng"] floatValue];
    infection.locationName = dictionary[@"location_name"] ;
    infection.quantity = [dictionary[@"quantity"] integerValue];
    infection.date = dictionary[@"infection_date"];
    infection.firstName = dictionary[@"first_name"];
    infection.lastName = dictionary[@"last_name"];


    return infection;
}

+(NSArray*)fromArray:(NSArray*)array {
    NSMutableArray* result =[[NSMutableArray alloc]init];
    for (NSDictionary* dict in array) {
        Infection *infection = [Infection fromDictionary:dict];
        [result addObject:infection];
    }
    return result;
    
}

@end
