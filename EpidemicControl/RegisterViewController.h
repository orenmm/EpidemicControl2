//
//  RegisterViewController.h
//  EpidemicControl
//
//  Created by Dan Galila on 3/9/14.
//  Copyright (c) 2014 EpidemicControl. All rights reserved.
//

#import "ViewController.h"
#import "User.h"

@interface RegisterViewController : ViewController <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *firstNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *lastNameTextDField;
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;

@property (weak, nonatomic) IBOutlet UILabel *firstnameERROR;
@property (weak, nonatomic) IBOutlet UILabel *lastnameERROR;
@property (weak, nonatomic) IBOutlet UILabel *errorTextField;
@property (weak, nonatomic) IBOutlet UILabel *passERROR;







- (IBAction)registerDoctor:(id)sender;

@end
