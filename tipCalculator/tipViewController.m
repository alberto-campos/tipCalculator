//
//  tipViewController.m
//  tipCalculator
//
//  Created by Alberto Campos on 12/4/13.
//  Copyright (c) 2013 CampOS. All rights reserved.
//

#import "tipViewController.h"
#import "SettingsViewController.h"
#import "GlobalVariables.h"

@interface tipViewController ()
@property (weak, nonatomic) IBOutlet UITextField *billTextField;
@property (weak, nonatomic) IBOutlet UILabel *tipLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalLabel;
@property (strong, nonatomic) IBOutlet UILabel *totalPerGuestLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *tipControl;
@property (strong, nonatomic) IBOutlet UILabel *guestsLabel;
@property (strong, nonatomic) IBOutlet UISlider *guestsSlider;

- (IBAction)guestsSlider:(id)sender;



- (IBAction)editingChanged:(id)sender;

- (IBAction)onTap:(id)sender;
- (void)updateValues;
- (void)readUserDefaults;
- (void)setFactoryValues;

@end

@implementation tipViewController
@synthesize firstRun = _firstRun;
@synthesize guestsLabel;
@synthesize guestsSlider;

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
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Settings" style:UIBarButtonItemStylePlain target:self action:@selector(onSettingsButton)];
    
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"TipCalcFirstLaunch"])
    {
        // Welcome back.
        self.view.backgroundColor = [UIColor whiteColor];
        [self readUserDefaults];
    }
    else
    {
        // First time app launch.
        self.view.backgroundColor = [UIColor redColor];
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"TipCalcFirstLaunch"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        [self setFactoryValues];
    }
    
    [self updateValues];
    
    [self.billTextField becomeFirstResponder];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)guestsSlider:(id)sender {
    int guestsAvg = self.guestsSlider.value;
    // float minTip = [self.minTipTextField.text floatValue];
    
    NSString *s = @"";
    
    s =[NSString stringWithFormat:@"%d", guestsAvg ];
    s = [s stringByAppendingString:@" guest"];
    
    if (guestsAvg != 1) {
        s = [s stringByAppendingString:@"s"];
    }
    
    // s = [s stringByAppendingString: [NSString stringWithFormat:@"%0.2f", minTip]];
    // s = [s stringByAppendingString:@" percentage"];
    
    guestsLabel.text = s;
    [self.view endEditing:YES];
    [self updateValues];
}

- (IBAction)editingChanged:(id)sender {    
    [self updateValues];
}



- (IBAction)onTap:(id)sender {
    [self.view endEditing:YES];
    [self updateValues];
}

- (void)updateValues {
    
    NSArray *tipValues = @[@(0.1), @(0.15), @(0.2)];
    
    float billAmount = [self.billTextField.text floatValue];
    int nbrGuests = self.guestsSlider.value;
    
    float tipAmount = billAmount * [tipValues[self.tipControl.selectedSegmentIndex] floatValue];
    float tipPerGuest = billAmount / nbrGuests * [tipValues[self.tipControl.selectedSegmentIndex] floatValue];
    float totalPerGuest = (billAmount / nbrGuests) + tipPerGuest;
    float totalAmount = billAmount + tipAmount;
    
    // Populate labels
    self.tipLabel.text = [NSString stringWithFormat:@"$%0.2f per guest", tipPerGuest ];
    self.totalPerGuestLabel.text = [NSString stringWithFormat:@"$%0.2f per guest", totalPerGuest ];
    self.totalLabel.text = [NSString stringWithFormat:@"$%0.2f", totalAmount ];
    
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

- (void)readUserDefaults {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    int guestsAvg = [defaults integerForKey:@"guestsAvg"];
    float minTip = [defaults floatForKey:@"minTip"];
    float avgTip = [defaults floatForKey:@"avgTip"];
    float maxTip = [defaults floatForKey:@"maxTip"];
    NSLog(@"Defaults retrieved correctly.");
    
   //tipValues = @[@(minTip),@(avgTip),@(maxTip)];
    
    
    GlobalVariables* myVar = [GlobalVariables singleObj];
    NSString *searchStr = myVar.globalStr;
    NSLog(searchStr);

}

- (void)setFactoryValues
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setInteger:1 forKey:@"guestsAvg"];
    [defaults setFloat:0.10 forKey:@"minTip"];
    [defaults setFloat:0.15 forKey:@"avgTip"];
    [defaults setFloat:0.20 forKey:@"maxTip"];
    [defaults synchronize];
    NSLog(@"Values set to factory values.");
    
   // tipValues = @[@(0.1), @(0.15), @(0.2)];
    
}
@end
