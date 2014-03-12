//
//  AddInfectedViewController.h
//  EpidemicControl
//
//  Created by Dan Galila on 3/11/14.
//  Copyright (c) 2014 EpidemicControl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddInfectedViewController : UIViewController <UITableViewDataSource , UITableViewDelegate,UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *location;
@property (weak, nonatomic) IBOutlet UITextField *dateTextField;
@property (weak, nonatomic) IBOutlet UIStepper *stepper;
- (IBAction)addToServer:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *stepperLabel;
- (IBAction)stepperValueChanged:(id)sender;

@end
