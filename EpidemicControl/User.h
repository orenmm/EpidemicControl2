//
//  User.h
//  EpidemicControl
//
//  Created by Dan Galila on 3/9/14.
//  Copyright (c) 2014 EpidemicControl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
typedef void(^APIReturnsArray)(NSArray *data);
typedef void(^APIReturnsDictionary)(NSDictionary *data);
@interface User : NSObject
@property (nonatomic,strong) NSString* firstName;
@property (nonatomic,strong) NSString* lastName;
@property (nonatomic,strong) NSString * email;
@property (nonatomic,strong) NSString * password;

-(id)initWithFirstName:(NSString*)name lastName:(NSString*)lastName email:(NSString*)email pass:(NSString*)pass;

-(void)registerUser:(APIReturnsDictionary)completionBlock;

+(void)userLoginWithEmail:(NSString*)email andPassword:(NSString *)pass :(APIReturnsDictionary)completionBlock;

@end
