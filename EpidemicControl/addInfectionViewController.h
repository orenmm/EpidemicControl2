//
//  addInfectionViewController.h
//  EpidemicControl
//
//  Created by Oren Mor on 3/11/14.
//  Copyright (c) 2014 EpidemicControl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface addInfectionViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableViewCell *cellforInfection;
@property (weak, nonatomic) IBOutlet UITableView *table;
@property (weak, nonatomic) IBOutlet UIStepper *stepper;
@property (weak, nonatomic) IBOutlet UILabel *locationField;




@end
