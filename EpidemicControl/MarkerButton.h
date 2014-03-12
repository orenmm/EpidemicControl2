//
//  MarkerButton.h
//  EpidemicControl
//
//  Created by Asaf Interator on 12/03/14.
//  Copyright (c) 2014 EpidemicControl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Infection.h"

@interface MarkerButton : UIButton

@property (nonatomic,strong) Infection* infection;

@end
