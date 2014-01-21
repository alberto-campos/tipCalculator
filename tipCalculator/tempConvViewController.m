//
//  tipViewController.m
//  tipCalculator
//
//  Created by Alberto Campos on 12/4/13.
//  Copyright (c) 2013 CampOS. All rights reserved.
//

#import "tempConvViewController.h"
#import "SettingsViewController.h"
#import "GlobalVariables.h"

@interface tempConvViewController ()
@property (strong, nonatomic) IBOutlet UIButton *minusSign;
@property (strong, nonatomic) IBOutlet UIButton *plusSign;
@property (weak, nonatomic) IBOutlet UITextField *billTextField;
@property (weak, nonatomic) IBOutlet UILabel *tipLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalLabel;
@property (strong, nonatomic) IBOutlet UILabel *totalPerGuestLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *tipControl;
@property (strong, nonatomic) IBOutlet UILabel *guestsLabel;
@property (strong, nonatomic) IBOutlet UISlider *guestsSlider;

- (IBAction)guestsSlider:(id)sender;
- (IBAction)minusSign:(id)sender;
- (IBAction)plusSign:(id)sender;
- (IBAction)editingChanged:(id)sender;
- (IBAction)onTap:(id)sender;

- (void)updateGuestsLabel;
- (void)updateValues;
- (void)readUserDefaults;
- (void)setFactoryValues;
- (void)checkDisableSigns;
- (void)changeCelcius;
- (void)changeFahrenheit;

@end

@implementation tempConvViewController
@synthesize firstRun = _firstRun;
@synthesize guestsLabel;
@synthesize guestsSlider;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    
    
    if (self) {
        // Custom initialization
        self.title = @"Temperature Converter";
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
        
    //self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Settings" style:UIBarButtonItemStylePlain target:self action:@selector(onSettingsButton)];
    
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
    
    // preserve the user's input bill duiring session
//    GlobalVariables *myBill = [GlobalVariables singleObj];
//    myBill.globalStr = @"32.00";
    
    [self updateValues];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)guestsSlider:(id)sender {
//    [self updateGuestsLabel];
//    [self.view endEditing:YES];
//    [self updateValues];
//    
//    // TODO: there is an issue when sliding the bar 'almost' to zero, the minus button does not get disabled until reaching zero.
//    [self checkDisableSigns];
    
}

//TODO: Move to UTILS.h
- (void)checkDisableSigns
{
    //TODO: do not use global variables
//    int minGuests = 1;
//    int maxGuests = 12;
//    
//    if (self.guestsSlider.value == minGuests)
//    {
//        self.minusSign.enabled = FALSE;
//    }
//    
//    if (self.guestsSlider.value == maxGuests)
//    {
//        self.plusSign.enabled = FALSE;
//    }
//    
//    // enable valid buttons
//    if (self.minusSign.enabled == FALSE && self.guestsSlider.value > minGuests)
//    {
//        self.minusSign.enabled = TRUE;
//    }
//    
//    if (self.plusSign.enabled == FALSE && self.guestsSlider.value < maxGuests)
//    {
//        self.plusSign.enabled = TRUE;
//    }
//    
}

- (void)updateGuestsLabel{
//    int guestsAvg = self.guestsSlider.value;
//    
//    NSString *s = @"";
//    
//    s =[NSString stringWithFormat:@"%d", guestsAvg ];
//    s = [s stringByAppendingString:@" guest"];
//    
//    if (guestsAvg != 1) {
//        s = [s stringByAppendingString:@"s"];
//    }
//    
//    guestsLabel.text = s;
    
    // self.guestsSlider.value;
    
    
}

- (IBAction)minusSign:(id)sender {
    //TODO: read MIN from global variables
//    int minGuests = 1;
//    
//    if (self.guestsSlider.value > minGuests)
//    {
//        self.guestsSlider.value = self.guestsSlider.value - 1;
//        [self updateGuestsLabel];
//        [self checkDisableSigns];
//        [self updateValues];
//    }
//    
    
}

- (IBAction)plusSign:(id)sender {
    //TODO: read MAX from global variables
//    int maxGuests = 200;
//
//    
//    if (self.guestsSlider.value < maxGuests)
//    {
//        self.guestsSlider.value++;
//        [self updateGuestsLabel];
//        [self checkDisableSigns];
//        [self updateValues];
//    }
}

- (IBAction)editingChanged:(id)sender {
    [self updateValues];
}



- (IBAction)onTap:(id)sender {
    [self.view endEditing:YES];
    [self updateValues];
}

- (void)updateValues {
    // local variables
  //  NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
  //  float minTip = [defaults integerForKey:@"minTip"];
  //  float avgTip = [defaults integerForKey:@"avgTip"];
   // float maxTip = [defaults integerForKey:@"maxTip"];
   // int guestsAvg = guestsSlider.value;
    
    // Composite variables
   // NSArray *tipValues = @[@(minTip/100), @(avgTip/100), @(maxTip/100) ];
   // NSArray *tipValues = @[@(minTip/100), @(avgTip/100) ];
    


    
    // if 0, then convert to Celcius else to Fahrenheit
    int tempType = self.tipControl.selectedSegmentIndex;

    
    //float tempConverted;
    //= tempEntered * [tipValues[self.tipControl.selectedSegmentIndex] floatValue];
  
    if (tempType == 1) {
        [self changeCelcius];
    }
    else
    {
        [self changeFahrenheit];
    }
    
    
    
}

- (void)onSettingsButton {
    [self.navigationController pushViewController:[[SettingsViewController alloc] init] animated:YES];
}

- (void)viewWillAppear:(BOOL)animated {
    // retrieve entered temperature
    GlobalVariables* myBill = [GlobalVariables singleObj];
    NSString *billStrValue = myBill.globalStr;
    
    [self updateValues];
    self.billTextField.text = billStrValue;
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    guestsSlider.value = [defaults integerForKey:@"guestsAvg"];
    [self updateGuestsLabel];
    
}

- (void)viewDidAppear:(BOOL)animated {
    NSLog(@"view did appear");
}

- (void)viewWillDisappear:(BOOL)animated {
    // preserve customer's bill amount
//    GlobalVariables *myBill = [GlobalVariables singleObj];
//    myBill.globalStr = self.billTextField.text;
}

- (void)viewDidDisappear:(BOOL)animated {
    NSLog(@"view will disappear");
}

- (void)readUserDefaults {
}

- (void)setFactoryValues
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setInteger:32 forKey:@"guestsAvg"];
    [defaults setInteger:-200 forKey:@"minTip"];
    [defaults setInteger:200 forKey:@"avgTip"];
   // [defaults setInteger:20 forKey:@"maxTip"];
    [defaults synchronize];
    NSLog(@"Values reset to factory defaults.");
}

- (void)changeCelcius
{
    // (°F  -  32)  x  5/9 = °C
    // User requested Celcius
    
    float tempEntered = [self.billTextField.text floatValue];
    
    float tempConverted = (tempEntered - 32) * 5 / 9;
    self.tipLabel.text = [NSString stringWithFormat:@"%g fahrenheit.",  tempEntered];
    self.totalPerGuestLabel.text = [NSString stringWithFormat:@"%g celcius.", tempConverted ];
    
    // Set to Celcius value
    self.guestsSlider.value = tempEntered;
}
-(void)changeFahrenheit
{
    // °C  x  9/5 + 32 = °F
    // User requested Fahrenheit
    
    float tempEntered = [self.billTextField.text floatValue];
    float tempConverted = (tempEntered * 9 / 5 ) + 32;
    
    self.tipLabel.text = [NSString stringWithFormat:@"%g fahrenheit.", tempConverted ];
    self.totalPerGuestLabel.text = [NSString stringWithFormat:@"%g celcius.", tempEntered ];
    
    self.guestsSlider.value = tempConverted;
}

@end
