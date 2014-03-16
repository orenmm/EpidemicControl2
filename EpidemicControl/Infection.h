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

typedef void(^APIReturnsNothing)(void);
typedef void(^APIReturnsArray)(NSArray *data);
typedef void(^APIReturnsDictionary)(NSDictionary *data);
typedef void(^APIReturnsData)(NSData *data);



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
-(void)addInfection:(APIReturnsArray)success fail:(APIReturnsNothing)fail;
-(void)deleteInfection;

+(Infection*)fromDictionary:(NSDictionary*)dictionary;
+(NSArray*)fromArray:(NSArray*)array;
@end
