//
//  SettingsViewController.m
//  tipCalculator
//
//  Created by Alberto Campos on 12/4/13.
//  Copyright (c) 2013 CampOS. All rights reserved.
//

#import "SettingsViewController.h"

@interface SettingsViewController ()
@property (weak, nonatomic) IBOutlet UITextField *guestsTextField;
@property (weak, nonatomic) IBOutlet UITextField *minTipTextField;
@property (weak, nonatomic) IBOutlet UITextField *avgTipTextField;
@property (weak, nonatomic) IBOutlet UITextField *maxTipTextField;
@property (weak, nonatomic) IBOutlet UILabel *resultsLabel;
- (IBAction)resetButton:(id)sender;


- (IBAction)onTap:(id)sender;
- (void) onUpdateDefaults;

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
    
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Reset" style:UIBarButtonItemStylePlain target:self action:@selector(onResetButton)];
    
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
        [self.view setFrame:CGRectMake(0,20,320,460)];
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)onResetButton {
    [self.navigationController pushViewController:[[SettingsViewController alloc] init] animated:YES];
}
- (IBAction)resetButton:(id)sender {
}

- (IBAction)onTap:(id)sender {
    [self.view endEditing:YES];
    [self onUpdateDefaults];
    
}

- (void) onUpdateDefaults
{
    int guestsAvg = [self.guestsTextField.text intValue];
    float minTip = [self.minTipTextField.text floatValue]/100;
    float avgTip = [self.avgTipTextField.text floatValue]/100;
    float maxTip = [self.maxTipTextField.text floatValue]/100;
    
    NSString *s = @"";
    
    s =[NSString stringWithFormat:@"%d", guestsAvg ];
    s = [s stringByAppendingString:@" guests. "];
    s = [s stringByAppendingString: [NSString stringWithFormat:@"%0.2f", minTip]];
    s = [s stringByAppendingString:@" percentage"];

    
    self.resultsLabel.text = s;
    
}


@end
