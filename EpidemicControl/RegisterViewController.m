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


- (void)viewWillAppear:(BOOL)animated
{
    //hide the navigation top bar
    self.navigationController.navigationBar.hidden = NO;
}

- (IBAction)register:(id)sender {
    NSString * firstName = self.firstNameTextField.text;
    NSString * lastName = self.lastNameTextDField.text;
    NSString * email = self.emailTextField.text;
    NSString * password = self.passwordTextField.text;

    if (firstName.length>0 && lastName.length>0 && email.length>0 && password.length>0)
    {
        if([self NSStringIsValidEmail:email])
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
        else
        {
            self.errorTextField.text=@"The Email Address Is Not Valid";
            self.errorTextField.hidden = NO;
        }
        
    }
}

//checking if the email is in the right format
- (BOOL)NSStringIsValidEmail:(NSString *)checkString{
    BOOL stricterFilter = YES; // Discussion http://blog.logichigh.com/2010/09/02/validating-an-e-mail-address/
    NSString *stricterFilterString = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSString *laxString = @".+@.+\\.[A-Za-z]{2}[A-Za-z]*";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:checkString];
}
@end