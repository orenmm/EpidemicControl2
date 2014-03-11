//
//  ViewController.m
//  EpidemicControl
//
//  Created by Oren Mor on 3/6/14.
//  Copyright (c) 2014 EpidemicControl. All rights reserved.
//

#import "ViewController.h"
#import "User.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
   
}

- (void)viewWillAppear:(BOOL)animated
{
    //hide the navigation top bar
    self.navigationController.navigationBar.hidden = YES;
    self.loginButton.userInteractionEnabled = YES;
}





- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



//button that hide the keyboard
- (IBAction)hideKeyboard:(id)sender {
    [self.emailField becomeFirstResponder];
    [self.emailField resignFirstResponder];

}


//text delegate function - when pressing return button - either dismiss the keyboard or going to next field.
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if(textField == self.emailField)
    {
        [self.passwordField becomeFirstResponder];
    }
        else
    {
        [textField resignFirstResponder];
    }
    return YES;
}


- (IBAction)login:(id)sender {
    NSString * email = self.emailField.text;
    NSString * password = self.passwordField.text;
    if ((email.length>0) && (password.length>0))
    {
        self.loginButton.userInteractionEnabled = NO;
        [User userLoginWithEmail:email andPassword:password :^(NSDictionary* dictionary){
            if(dictionary[@"error"])
            {
                //self.errorTextField.text=dictionary[@"error"];
                //self.errorTextField.hidden = NO;
                self.loginButton.userInteractionEnabled = YES;
            }
            else
            {
                User *user = [[User alloc]initWithFirstName:dictionary[@"first_name"] lastName:dictionary[@"last_name"] email:dictionary[@"email"] pass:dictionary[@"password"]];
                [self performSegueWithIdentifier:@"Login" sender:user];
            }
        } ];
        
    }
    
}
@end
