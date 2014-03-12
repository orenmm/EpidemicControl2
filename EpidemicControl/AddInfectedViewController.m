//
//  AddInfectedViewController.m
//  EpidemicControl
//
//  Created by Dan Galila on 3/11/14.
//  Copyright (c) 2014 EpidemicControl. All rights reserved.
//

#import "AddInfectedViewController.h"
#import "VirusCell.h"

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
    selectedIndexPath = 0 ;
    self.stepper.minimumValue=0;
    self.stepper.maximumValue=10000;
    self.stepper.stepValue=1;
    self.stepper.wraps=NO;
    self.stepperLabel.text=[NSString stringWithFormat:@"%d",(int)self.stepper.value];
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
    if (selectedIndexPath == indexPath)
    {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    else
    {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
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
        [tableView deselectRowAtIndexPath:selectedIndexPath animated:NO];
        
        UITableViewCell *newCell = [tableView cellForRowAtIndexPath:indexPath];
        newCell.accessoryType = UITableViewCellAccessoryCheckmark;
        UITableViewCell *oldCell = [tableView cellForRowAtIndexPath:selectedIndexPath];
        oldCell.accessoryType = UITableViewCellAccessoryNone;
        selectedIndexPath = indexPath;
    }
    
}







- (IBAction)addToServer:(id)sender {
}
- (IBAction)stepperValueChanged:(id)sender {
    
    self.stepperLabel.text=[NSString stringWithFormat:@"%d",(int)self.stepper.value];

}
@end
