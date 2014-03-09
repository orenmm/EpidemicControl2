//
//  RegisterViewController.m
//  EpidemicControl
//
//  Created by Dan Galila on 3/9/14.
//  Copyright (c) 2014 EpidemicControl. All rights reserved.
//

#import "RegisterViewController.h"

@interface RegisterViewController ()

@end

@implementation RegisterViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)register:(id)sender {
    NSString * firstName = self.firstNameTextField.text;
    NSString * lastName = self.lastNameTextDField.text;
    NSString * email = self.emailTextField.text;
    NSString * password = self.passwordTextField.text;

    
    
    
    if (firstName.length>0 && lastName.length>0 && email.length>0 && password.length>0)
    {
        User *user = [[User alloc]initWithFirstName:firstName lastName:lastName email:email pass:password];
        [user registerUser:^(NSDictionary* dictionary){
            if(dictionary[@"error"])
            {
                self.errorTextField.text=dictionary[@"error"];
                self.errorTextField.hidden = NO;
            }
            else
            {
            [self performSegueWithIdentifier:@"RegisterToMap" sender:user];
            }
        }];
    }
}
@end
