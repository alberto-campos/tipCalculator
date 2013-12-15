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
- (void)updateGuestsLabel;


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
        [self updateValues];
    }
    else
    {
        // First time app launch.
        self.view.backgroundColor = [UIColor redColor];
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"TipCalcFirstLaunch"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        [self.billTextField becomeFirstResponder];
        [self setFactoryValues];
    }
    
    GlobalVariables *myBill = [GlobalVariables singleObj];
    myBill.globalStr = @"0.00";
    
    [self updateValues];
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)guestsSlider:(id)sender {
    [self updateGuestsLabel];
    [self.view endEditing:YES];
    [self updateValues];
}

- (void)updateGuestsLabel{
    int guestsAvg = self.guestsSlider.value;
    
    NSString *s = @"";
    
    s =[NSString stringWithFormat:@"%d", guestsAvg ];
    s = [s stringByAppendingString:@" guest"];
    
    if (guestsAvg != 1) {
        s = [s stringByAppendingString:@"s"];
    }
    
    guestsLabel.text = s;
}

- (IBAction)editingChanged:(id)sender {    
    [self updateValues];
}



- (IBAction)onTap:(id)sender {
    [self.view endEditing:YES];
    [self updateValues];
}

- (void)updateValues {
    
    // TODO: Read bill values from a global variable
    //GlobalVariables* myVar = [GlobalVariables singleObj];
   // NSString *billStr = myVar.globalStr;
    
    
    // local variables
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    float minTip = [defaults integerForKey:@"minTip"];
    float avgTip = [defaults integerForKey:@"avgTip"];
    float maxTip = [defaults integerForKey:@"maxTip"];
    int guestsAvg = guestsSlider.value;
    
    
    // Composite variables
    NSArray *tipValues = @[@(minTip/100), @(avgTip/100), @(maxTip/100) ];
    
    // Update control values
    //[self.tipControl setTitle:[defaults stringForKey:@"minTip"] forSegmentAtIndex:0];
    [self.tipControl setTitle: [NSString stringWithFormat:@"%1.0f%%", minTip] forSegmentAtIndex:0];
    [self.tipControl setTitle: [NSString stringWithFormat:@"%1.0f%%", avgTip] forSegmentAtIndex:1];
    [self.tipControl setTitle: [NSString stringWithFormat:@"%1.0f%%", maxTip] forSegmentAtIndex:2];
    //[self.tipControl setTitle:[defaults stringForKey:@"avgTip"] forSegmentAtIndex:1];
    //[self.tipControl setTitle:[defaults stringForKey:@"maxTip"] forSegmentAtIndex:2];
    
    
    
    float billAmount = [self.billTextField.text floatValue];
   // int nbrGuests = self.guestsSlider.value;
    
    float tipAmount = billAmount * [tipValues[self.tipControl.selectedSegmentIndex] floatValue];
    float tipPerGuest = billAmount / guestsAvg * [tipValues[self.tipControl.selectedSegmentIndex] floatValue];
    float totalPerGuest = (billAmount / guestsAvg) + tipPerGuest;
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
    // retrieve customer's bill amouunt
    GlobalVariables* myBill = [GlobalVariables singleObj];
    NSString *searchStr = myBill.globalStr;
    
    [self updateValues];
    self.billTextField.text = searchStr;
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    guestsSlider.value = [defaults integerForKey:@"guestsAvg"];
    [self updateGuestsLabel];
    
}

- (void)viewDidAppear:(BOOL)animated {
    NSLog(@"view did appear");
}

- (void)viewWillDisappear:(BOOL)animated {
    // preserve customer's bill amount
    GlobalVariables *myBill = [GlobalVariables singleObj];
    myBill.globalStr = self.billTextField.text;
}

- (void)viewDidDisappear:(BOOL)animated {
    NSLog(@"view will disappear");
}

- (void)readUserDefaults {
  

}

- (void)setFactoryValues
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setInteger:1 forKey:@"guestsAvg"];
    [defaults setInteger:10 forKey:@"minTip"];
    [defaults setInteger:15 forKey:@"avgTip"];
    [defaults setInteger:20 forKey:@"maxTip"];
    [defaults synchronize];
    NSLog(@"Values set to factory values.");
    
    
}
@end
