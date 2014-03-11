//
//  Virus.h
//  EpidemicControl
//
//  Created by Dan Galila on 3/11/14.
//  Copyright (c) 2014 EpidemicControl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"


typedef void(^APIReturnsArray)(NSArray *data);
typedef void(^APIReturnsDictionary)(NSDictionary *data);

@interface Virus : NSObject

@property int virusid;
@property (nonatomic,strong) NSString* name;
@property (nonatomic,strong) NSString* icon;

+(Virus*)fromDictionary:(NSDictionary*)dictionary;
+(NSArray*)fromArray:(NSArray*)array;

+(void)getViruses:(APIReturnsArray)completionBlock;
@end
