//
//  SettingsViewController.m
//  tipCalculator
//
//  Created by Alberto Campos on 12/4/13.
//  Copyright (c) 2013 CampOS. All rights reserved.
//

#import "SettingsViewController.h"
#import "GlobalVariables.h"

@interface SettingsViewController ()

@property (strong, nonatomic) IBOutlet UILabel *guestsLabel;
@property (strong, nonatomic) IBOutlet UISlider *guestsSlider;
@property (strong, nonatomic) IBOutlet UITextField *minTipTextField;
@property (strong, nonatomic) IBOutlet UITextField *avgTipTextField;
@property (strong, nonatomic) IBOutlet UITextField *maxTipTextField;
@property (strong, nonatomic) IBOutlet UIButton *onResetToFactory;
@property (strong, nonatomic) IBOutlet UIButton *plusSign;
@property (strong, nonatomic) IBOutlet UIButton *minusSign;

- (IBAction)guestsSlider:(id)sender;
- (IBAction)onResetToFactory:(id)sender;
- (IBAction)onTap:(id)sender;
- (void)updateSliderValues;
- (void) onUpdateDefaults;
- (void) resetToFactory;
- (void)loadUserValues;
- (IBAction)plusSign:(id)sender;
- (IBAction)minusSign:(id)sender;

@end

@implementation SettingsViewController
@synthesize scrollView;
@synthesize guestsSlider;
@synthesize guestsLabel;
@synthesize minTipTextField;
@synthesize avgTipTextField;
@synthesize maxTipTextField;

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
    
    // UIScroll View settings
    scrollView.scrollEnabled = YES;
    scrollView.contentSize = CGSizeMake(320, 800);
    [super viewDidLoad];
    
    // setting up the keyboard
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHide:) name:UIKeyboardDidHideNotification object:nil];
    
    [self loadUserValues];
    [self updateSliderValues];
    
}

- (void)keyboardDidShow:(NSNotification *)notification
{
    if ([[UIScreen mainScreen] bounds].size.height == 568)
    {
        // iPhone 5 height = 560
        [self.view setFrame:CGRectMake(0, -80, 320, 560)];
    }
    else
    {
        [self.view setFrame:CGRectMake(0, -80, 320, 460)];
    }
}

- (void)keyboardDidHide:(NSNotification *)notification
{
    [self onUpdateDefaults];
    if ([[UIScreen mainScreen] bounds].size.height == 568)
    {
        [self.view setFrame:CGRectMake(0, 20, 320, 560)];
    }
    else
    {
        [self.view setFrame:CGRectMake(0, 20,320,460)];
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)onResetToFactory:(id)sender {
    [self resetToFactory];
}


- (IBAction)onTap:(id)sender {
    [self.view endEditing:YES];
    [self onUpdateDefaults];
    
}

- (void) onUpdateDefaults
{
    // read values from screen
    int guestsAvg = guestsSlider.value;
    int minTip = [self.minTipTextField.text intValue];
    int avgTip = [self.avgTipTextField.text intValue];
    int maxTip = [self.maxTipTextField.text intValue];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setInteger:guestsAvg forKey:@"guestsAvg"];
    [defaults setInteger:minTip forKey:@"minTip"];
    [defaults setInteger:avgTip forKey:@"avgTip"];
    [defaults setInteger:maxTip forKey:@"maxTip"];
    [defaults synchronize];
    
    [self checkDisableSigns];
    NSLog(@"Defaults saved correctly.");
        
}

- (void) resetToFactory
{
    // Update values in text fields
    self.minTipTextField.text = @"10";
    self.avgTipTextField.text = @"15";
    self.maxTipTextField.text = @"20";
    guestsSlider.value = 1;
    guestsLabel.text = [NSString stringWithFormat:@"%1.0f guests", self.guestsSlider.value];
    
    // Store values internally
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setInteger:1 forKey:@"guestsAvg"];
    [defaults setInteger:10 forKey:@"minTip"];
    [defaults setInteger:15 forKey:@"avgTip"];
    [defaults setInteger:20 forKey:@"maxTip"];
    [defaults synchronize];
    
    [self checkDisableSigns];
    NSLog(@"Values reset to factory.");
}

- (IBAction)guestsSlider:(id)sender {
    [self updateSliderValues];
    [self.view endEditing:YES];
    [self checkDisableSigns];
}

- (void)updateSliderValues
{
    int guestsAvg = guestsSlider.value;
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setInteger:guestsAvg forKey:@"guestsAvg"];
    
    NSString *s = @"";
    
    s =[NSString stringWithFormat:@"%d", guestsAvg ];
    s = [s stringByAppendingString:@" guest"];
    
    if (guestsAvg != 1) {
        s = [s stringByAppendingString:@"s"];
    }
    
    guestsLabel.text = s;
}

- (void)loadUserValues
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    // Populate boxes
    minTipTextField.text = [defaults stringForKey:@"minTip"];
    avgTipTextField.text = [defaults stringForKey:@"avgTip"];
    maxTipTextField.text = [defaults stringForKey:@"maxTip"];
    guestsSlider.value = [defaults integerForKey:@"guestsAvg"];

}

- (IBAction)plusSign:(id)sender {
    //TODO: read MAX from global variables
    int maxGuests = 12;
    
    if (self.guestsSlider.value < maxGuests)
    {
        self.guestsSlider.value++;
        [self updateSliderValues];
        [self checkDisableSigns];
    }
}

- (IBAction)minusSign:(id)sender {
    //TODO: read MIN from global variables
    int minGuests = 1;
    
    if (self.guestsSlider.value > minGuests)
    {
        self.guestsSlider.value = self.guestsSlider.value - 1;
        [self updateSliderValues];
        [self checkDisableSigns];
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [self onUpdateDefaults];
}

- (void)checkDisableSigns
{
    //TODO: read MIN and MAX from global variables
    int minGuests = 1;
    int maxGuests = 12;
    
    if (self.guestsSlider.value == minGuests)
    {
        self.minusSign.enabled = FALSE;
    }
    
    if (self.guestsSlider.value == maxGuests)
    {
        self.plusSign.enabled = FALSE;
    }
    
    // enable valid buttons
    if (self.minusSign.enabled == FALSE && self.guestsSlider.value > minGuests)
    {
        self.minusSign.enabled = TRUE;
    }
    
    if (self.plusSign.enabled == FALSE && self.guestsSlider.value < maxGuests)
    {
        self.plusSign.enabled = TRUE;
    }
}


@end
