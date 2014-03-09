//
//  Infection.h
//  EpidemicControl
//
//  Created by Dan Galila on 3/9/14.
//  Copyright (c) 2014 EpidemicControl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"


typedef void(^APIReturnsArray)(NSArray *data);
typedef void(^APIReturnsDictionary)(NSDictionary *data);
typedef void(^APIReturnsint)(int infection_id);



@interface Infection : NSObject

@property (nonatomic,strong) NSString* userName;
@property (nonatomic,strong) NSString* virusID;
@property (nonatomic,strong) NSString* latCord;
@property (nonatomic,strong) NSString* longCord;
@property (nonatomic,strong) NSString* locationName;
@property (nonatomic,strong) NSString* quantity;
@property (nonatomic,strong) NSString* date;

-(id)initWithUserName:(NSString*)userName VirusId:(NSString*)virusId latCord:(NSString*)latcord longCord:(NSString*)longCord locationName:(NSString*)locationName quantity:(NSString*)quantity date:(NSString*)date;
-(void)addInfection:(APIReturnsDictionary)completionBlock;

@end
