//
//  Infection.m
//  EpidemicControl
//
//  Created by Dan Galila on 3/9/14.
//  Copyright (c) 2014 EpidemicControl. All rights reserved.
//

#import "Infection.h"

@implementation Infection

-(id)initWithUserName:(NSString*)userName VirusId:(NSString*)virusId latCord:(NSString*)latcord longCord:(NSString*)longCord locationName:(NSString*)locationName quantity:(NSString*)quantity date:(NSString*)date{
    

    self = [super init];
    self.userName = userName;
    self.virusID = virusId;
    self.latCord =latcord;
    self.longCord = longCord;
    self.locationName =locationName;
    self.quantity=quantity;
    self.date = date;
    
    return self;
}

-(void)addInfection:(APIReturnsDictionary)completionBlock{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", nil];
    NSDictionary *parameters = @{@"user_id": self.userName, @"virus_id":self.virusID, @"location_lat":self.latCord, @"location_lng":self.longCord,@"location_name":self.locationName, @"quantity":self.quantity,@"infection_date":self.date};
    [manager POST:@"http://70.32.106.118/doctors/rest/infection/addInfection.php" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        
        NSLog(@"JSON: %@", responseObject);
        
        completionBlock(responseObject);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"Error: %@", error);
        
        
        
    }];
    


}

@end
