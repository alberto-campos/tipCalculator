//
//  tipViewController.m
//  tipCalculator
//
//  Created by Alberto Campos on 12/4/13.
//  Copyright (c) 2013 CampOS. All rights reserved.
//

#import "tipViewController.h"
#import "SettingsViewController.h"

@interface tipViewController ()
@property (weak, nonatomic) IBOutlet UITextField *billTextField;
@property (weak, nonatomic) IBOutlet UILabel *tipLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *tipControl;
- (IBAction)editingChanged:(id)sender;

- (IBAction)onTap:(id)sender;
- (void)updateValues;
- (void)readDefaults;
- (void)checkFirstRun;
- (void)setFactoryValues;

@end

@implementation tipViewController
@synthesize firstRun = _firstRun;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    
    
    if (self) {
        // Custom initialization
        self.title = @"Tip calculator";
    }
    
    return self;
}

- (void)viewDidLoad
{
    
    
    [super viewDidLoad];
    
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"TipCalcFirstLaunch"])
    {
        // Welcome back.
        self.view.backgroundColor = [UIColor blueColor];
    }
    else
    {
        // First time.
        self.view.backgroundColor = [UIColor redColor];
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"TipCalcFirstLaunch"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    
    
    [self checkFirstRun];
    [self updateValues];
    [self.billTextField becomeFirstResponder];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Settings" style:UIBarButtonItemStylePlain target:self action:@selector(onSettingsButton)];
    
    [self readDefaults];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)editingChanged:(id)sender {    
    [self updateValues];
}

- (void)checkFirstRun {
    

}

- (IBAction)onTap:(id)sender {
    [self.view endEditing:YES];
    [self updateValues];
}

- (void)updateValues {
    float billAmount = [self.billTextField.text floatValue];
    
    
    
    NSArray *tipValues = @[@(0.1), @(0.15), @(0.2)];
    float tipAmount = billAmount * [tipValues[self.tipControl.selectedSegmentIndex] floatValue];
    
    float totalAmount = tipAmount + billAmount;
    
    self.tipLabel.text = [NSString stringWithFormat:@"$%0.2f", tipAmount ];
    //self.totalLabel.text = [NSString stringWithFormat:@"$%0.2f", totalAmount];
}

- (void)onSettingsButton {
    [self.navigationController pushViewController:[[SettingsViewController alloc] init] animated:YES];
}

- (void)viewWillAppear:(BOOL)animated {
    NSLog(@"view will appear");
}

- (void)viewDidAppear:(BOOL)animated {
    NSLog(@"view did appear");
}

- (void)viewWillDisappear:(BOOL)animated {
    NSLog(@"view will disappear");
}

- (void)viewDidDisappear:(BOOL)animated {
    NSLog(@"view will disappear");
}

- (void)readDefaults {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    int guestsAvg = [defaults integerForKey:@"guestsAvg"];
    float minTip = [defaults floatForKey:@"minTip"];
    float avgTip = [defaults floatForKey:@"avgTip"];
    float maxTip = [defaults floatForKey:@"maxTip"];
    NSLog(@"Defaults read correctly.");

}

- (void)setFactoryValues
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setInteger:1 forKey:@"guestsAvg"];
    [defaults setFloat:10 forKey:@"minTip"];
    [defaults setFloat:15 forKey:@"avgTip"];
    [defaults setFloat:18 forKey:@"maxTip"];
    [defaults synchronize];
    NSLog(@"Defaults saved correctly.");
    
}
@end
