//
//  User.m
//  EpidemicControl
//
//  Created by Dan Galila on 3/9/14.
//  Copyright (c) 2014 EpidemicControl. All rights reserved.
//

#import "User.h"

@implementation User

//our own initial user 
-(id)initWithFirstName:(NSString*)name lastName:(NSString*)lastName email:(NSString*)email pass:(NSString*)pass
{
    self = [super init];
    self.firstName =name;
    self.lastName = lastName;
    self.email = email;
    self.password = pass;
    return self;
}

//connecting server and register new users
-(void)registerUser:(APIReturnsDictionary)completionBlock
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", nil];
    NSDictionary *parameters = @{@"email": self.email, @"password":self.password, @"first_name":self.firstName, @"last_name":self.lastName};
    [manager POST:@"http://70.32.106.118/doctors/rest/user/register.php" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
    

        NSLog(@"JSON: %@", responseObject);
        self.userId=[responseObject[@"id"] integerValue];
        completionBlock(responseObject);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"Error: %@", error);
        
        
        
    }];
    
    
    
}

+(void)userLoginWithEmail:(NSString*)email andPassword:(NSString *)pass :(APIReturnsDictionary)completionBlock
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", nil];
    NSDictionary *parameters = @{@"email": email, @"password":pass};
    [manager POST:@"http://70.32.106.118/doctors/rest/user/login.php" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
                
        NSLog(@"JSON: %@", responseObject);
        completionBlock(responseObject);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"Error: %@", error);

    }];
}
@end
