//
//  EpidemecInfoView.h
//  EpidemicControl
//
//  Created by Asaf Interator on 12/03/14.
//  Copyright (c) 2014 EpidemicControl. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface EpidemecInfoView : UIView

@property (weak, nonatomic) IBOutlet UILabel *reporterNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *virusNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *quantityLabel;
@property int infectionId;
- (IBAction)exitNib:(id)sender;

- (IBAction)removeItemfromMap:(id)sender;

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *LoadingIndicator;


@end
