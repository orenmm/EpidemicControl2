//
//  EpidemecInfoView.m
//  EpidemicControl
//
//  Created by Asaf Interator on 12/03/14.
//  Copyright (c) 2014 EpidemicControl. All rights reserved.
//

#import "EpidemecInfoView.h"
#import "Infection.h"
#import "LocationMapViewViewController.h"

@implementation EpidemecInfoView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        //self.backgroundColor = [UIColor colorWithRed:220/255.0 green:113/225.0 blue:105/255.0 alpha:1];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

/* asaf
 - (IBAction)exitNib:(id)sender
 {
 [UIView animateWithDuration:0.5 animations:^{
 [self setAlpha:0];
 }];
 [self removeFromSuperview];
 }

*/




- (IBAction)exitNib:(id)sender
{
    [UIView animateWithDuration:0.600
                     animations:^{  
                         self.alpha = 0;
                     }
                     completion:^(BOOL finished) {
                         
                     }];
    self.hidden = YES;

}

- (IBAction)removeItemfromMap:(id)sender
{
    Infection *infection = [[Infection alloc]init];
    infection.infectionId = self.infectionId;
    [infection deleteInfection];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"deleteInfection" object:nil];
    
    [UIView animateWithDuration:0.5 animations:^{
        [self setAlpha:0];
    }];
    [self removeFromSuperview];
    
    
    
    
}
@end
