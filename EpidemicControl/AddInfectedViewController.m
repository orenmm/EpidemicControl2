//
//  AddInfectedViewController.m
//  EpidemicControl
//
//  Created by Dan Galila on 3/11/14.
//  Copyright (c) 2014 EpidemicControl. All rights reserved.
//

#import "AddInfectedViewController.h"

@interface AddInfectedViewController ()

@end

@implementation AddInfectedViewController
{
    AppData* appData;
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
	// Do any additional setup after loading the view.
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
    
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"disease"];
    return cell;
    
}



-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 30.0;
}








- (IBAction)addToServer:(id)sender {
}
- (IBAction)stepperValueChanged:(id)sender {
}
@end
