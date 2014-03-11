//
//  Infection.h
//  EpidemicControl
//
//  Created by Dan Galila on 3/9/14.
//  Copyright (c) 2014 EpidemicControl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
#import "Virus.h"


typedef void(^APIReturnsArray)(NSArray *data);
typedef void(^APIReturnsDictionary)(NSDictionary *data);
typedef void(^APIReturnsint)(int infection_id);



@interface Infection : NSObject

@property int infectionId;
@property int userId;
@property (nonatomic) int virusID;
@property CGFloat latCord;
@property CGFloat longCord;
@property (nonatomic,strong) NSString* locationName;
@property int quantity;
@property (nonatomic,strong) NSString* date;
@property (nonatomic,strong) NSString* firstName;
@property (nonatomic,strong) NSString* lastName;

@property (nonatomic,strong) Virus* virus;

+(void)getInfections:(APIReturnsArray)completionBlock;
-(void)addInfection;

+(Infection*)fromDictionary:(NSDictionary*)dictionary;
+(NSArray*)fromArray:(NSArray*)array;
@end
