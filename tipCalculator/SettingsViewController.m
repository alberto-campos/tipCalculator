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

- (IBAction)guestsSlider:(id)sender;
- (IBAction)onResetToFactory:(id)sender;
- (IBAction)onTap:(id)sender;
- (void)updateSliderValues;
- (void) onUpdateDefaults;
- (void) resetToFactory;
- (void)loadUserValues;

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
    // Do any additional setup after loading the view from its nib.
    
    
    // setting up the keyboard
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHide:) name:UIKeyboardDidHideNotification object:nil];
    
    [self loadUserValues];
    
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
    
    NSLog(@"Defaults saved correctly.");
        
}

- (void) resetToFactory
{
    
    // Set values to text fields
    self.minTipTextField.text = @"10";
    self.avgTipTextField.text = @"15";
    self.maxTipTextField.text = @"20";
    guestsSlider.value = 1;
    guestsLabel.text = [NSString stringWithFormat:@"%1.0f guests", self.guestsSlider.value];
    
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setInteger:1 forKey:@"guestsAvg"];
    [defaults setInteger:10 forKey:@"minTip"];
    [defaults setInteger:15 forKey:@"avgTip"];
    [defaults setInteger:20 forKey:@"maxTip"];
    [defaults synchronize];
    
    NSLog(@"Values reset to factory.");
    
    
    
    
}

- (IBAction)guestsSlider:(id)sender {
    
    [self updateSliderValues];
    [self.view endEditing:YES];
    
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


- (void)viewWillDisappear:(BOOL)animated {
    [self onUpdateDefaults];
}

@end
