//
//  AddInfectedViewController.m
//  EpidemicControl
//
//  Created by Dan Galila on 3/11/14.
//  Copyright (c) 2014 EpidemicControl. All rights reserved.
//

#import "AddInfectedViewController.h"
#import "VirusCell.h"
#import "Infection.h"

@interface AddInfectedViewController ()

@end

@implementation AddInfectedViewController
{
    AppData* appData;
    //index that wil indicate the virus cell last selected
    NSIndexPath *selectedIndexPath;

}

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
    
    appData = [AppData shareInstance];
    selectedIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    //definitions for stepper
    self.stepper.minimumValue=0;
    self.stepper.maximumValue=10000;
    self.stepper.stepValue=1;
    self.stepper.wraps=NO;
    self.stepperLabel.text=[NSString stringWithFormat:@"%d",(int)self.stepper.value];
    
    self.dateTextField.delegate = self;
    //the address is drown from segue
    self.location.text=self.address;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return appData.viruses.count;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    VirusCell *cell = [tableView dequeueReusableCellWithIdentifier:@"virusCell"];
    Virus* virus =appData.viruses[indexPath.row];
    cell.textLabel.text =virus.name;
    cell.imageView.image=[UIImage imageNamed:virus.icon];
    if (selectedIndexPath.row == indexPath.row)
    {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    else
    {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
    
}



-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 30.0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath ==selectedIndexPath)
    {
        return;
    }
    else
    {
       // [tableView deselectRowAtIndexPath:selectedIndexPath animated:NO];
        
        UITableViewCell *newCell = [tableView cellForRowAtIndexPath:indexPath];
        newCell.accessoryType = UITableViewCellAccessoryCheckmark;
        UITableViewCell *oldCell = [tableView cellForRowAtIndexPath:selectedIndexPath];
        oldCell.accessoryType = UITableViewCellAccessoryNone;
        selectedIndexPath = indexPath;
    }
    
}







- (IBAction)addToServer:(id)sender {
    //alloc init to infection object and then add it to server-DB using the releventfunction
    Infection *infection = [[Infection alloc]init];
    infection.userId=appData.user.userId;
    Virus* virus =appData.viruses[selectedIndexPath.row];
    infection.virusID=virus.virusid;
    
    //change this location tomorow- take it from the locationMapVC...
    infection.latCord=self.placemark.location.coordinate.latitude;
    infection.longCord=self.placemark.location.coordinate.longitude;
    infection.locationName = self.location.text;
    
    infection.quantity=(int)self.stepper.value;
    infection.date=self.dateTextField.text;
    
    [infection addInfection];
    [self.navigationController popViewControllerAnimated:YES];

    

}
- (IBAction)stepperValueChanged:(id)sender {
    
    self.stepperLabel.text=[NSString stringWithFormat:@"%d",(int)self.stepper.value];

}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self.dateTextField resignFirstResponder];
    return YES;
}
@end
