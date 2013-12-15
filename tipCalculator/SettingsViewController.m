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
@property (weak, nonatomic) IBOutlet UITextField *guestsTextField;
@property (weak, nonatomic) IBOutlet UITextField *minTipTextField;
@property (weak, nonatomic) IBOutlet UITextField *avgTipTextField;
@property (weak, nonatomic) IBOutlet UITextField *maxTipTextField;
@property (weak, nonatomic) IBOutlet UILabel *resultsLabel;
- (IBAction)resetButton:(id)sender;

- (IBAction)resetToFactory:(id)sender;

- (IBAction)onTap:(id)sender;
- (void) onUpdateDefaults;
- (void) resetToFactory;

@end

@implementation SettingsViewController
@synthesize scrollView;
@synthesize guestsTextField;
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
- (void)onResetButton {
    [self.navigationController pushViewController:[[SettingsViewController alloc] init] animated:YES];
    [self resetToFactory];
}
- (IBAction)resetButton:(id)sender {
    [self resetToFactory];
}

- (IBAction)resetToFactory:(id)sender {
    
    [self resetToFactory];
}

- (IBAction)onTap:(id)sender {
    [self.view endEditing:YES];
    [self onUpdateDefaults];
    
}

- (void) onUpdateDefaults
{
    
    // read values from screen
    int guestsAvg = [self.guestsTextField.text intValue];
    int minTip = [self.minTipTextField.text intValue];
    int avgTip = [self.avgTipTextField.text intValue];
    int maxTip = [self.maxTipTextField.text intValue];
    
    NSString *s = @"";
    
    s =[NSString stringWithFormat:@"%d", guestsAvg ];
    s = [s stringByAppendingString:@" guests. "];
    s = [s stringByAppendingString: [NSString stringWithFormat:@"%0.2f", minTip]];
    s = [s stringByAppendingString:@" percentage"];
    
    self.resultsLabel.text = s;
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setInteger:guestsAvg forKey:@"guestsAvg"];
    [defaults setInteger:minTip forKey:@"minTip"];
    [defaults setInteger:avgTip forKey:@"avgTip"];
    [defaults setInteger:maxTip forKey:@"maxTip"];
    [defaults synchronize];
    
    NSLog(@"Defaults saved correctly.");
    
    
    //TODO: Read default values from a global array (1, 10%, 15%, 20%)
    GlobalVariables *myVar = [GlobalVariables singleObj];
    myVar.globalStr = self.guestsTextField.text;
    NSLog(@"guests text field: ");
    NSLog(guestsTextField.text);
    
    
}

- (void) resetToFactory
{
    
    // read values from screen
    self.guestsTextField.text = @"1";
    self.minTipTextField.text = @"10999";
    self.avgTipTextField.text = @"15";
    self.maxTipTextField.text = @"20";
    
    
   
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setInteger:1 forKey:@"guestsAvg"];
    [defaults setInteger:10 forKey:@"minTip"];
    [defaults setInteger:15 forKey:@"avgTip"];
    [defaults setInteger:20 forKey:@"maxTip"];
    [defaults synchronize];
    
    NSLog(@"Values reset to factory.");
    
    
    
    
}


@end
