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
{
    
    AppData* appData;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
   
}

- (void)viewWillAppear:(BOOL)animated
{
    // initial appData object
    appData = [AppData shareInstance];
    //hide the navigation top bar
    self.navigationController.navigationBar.hidden = YES;
    self.loginButton.userInteractionEnabled = YES;
    self.LoadingIndicator.hidden = YES;
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
    self.errorLogin.hidden = YES;
    NSString * email = self.emailField.text;
    NSString * password = self.passwordField.text;
    if ((email.length>0) && (password.length>0))
    {
        self.loginButton.userInteractionEnabled = NO;
        self.LoadingIndicator.hidden = NO;
        [User userLoginWithEmail:email andPassword:password :^(NSDictionary* dictionary){
            if(dictionary[@"error"])
            {
                self.errorLogin.text = dictionary[@"error"];
                self.errorLogin.hidden = NO;
                self.loginButton.userInteractionEnabled = YES;
                self.LoadingIndicator.hidden = YES;
            }
            else
            {
                User *user = [[User alloc]initWithFirstName:dictionary[@"first_name"] lastName:dictionary[@"last_name"] email:dictionary[@"email"] pass:dictionary[@"password"]];
                user.userId=[dictionary[@"id"] integerValue];
                appData.user = user;
                [self performSegueWithIdentifier:@"Login" sender:user];
                self.LoadingIndicator.hidden = YES;
            }
        } ];
        
    }
    else
    {
        self.errorLogin.text = @"Please Fill All The Fields";
        self.errorLogin.hidden = NO;
    }
    
}
@end
