//
//  ViewController.h
//  EpidemicControl
//
//  Created by Oren Mor on 3/6/14.
//  Copyright (c) 2014 EpidemicControl. All rights reserved.
//

#import <UIKit/UIKit.h>


//added external frameworks: coreLocation, Mapkit, Quartz



@interface ViewController : UIViewController<UITextFieldDelegate>

- (IBAction)hideKeyboard:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *emailField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
- (IBAction)login:(id)sender;

@end
