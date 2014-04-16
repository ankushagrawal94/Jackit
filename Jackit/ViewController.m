//
//  ViewController.m
//  Jackit
//
//  Created by Josh Anatalio on 4/12/14.
//  Copyright (c) 2014 JoshAnatalioLAHacks. All rights reserved.
//

#import "ViewController.h"
#import "CustomAlert.h"
#import "AppDelegate.h"
#import "JackWithSomeoneViewController.h"
#define SUBVIEW_TAG 999

@interface ViewController ()
@property (nonatomic,strong) CustomAlert *alert;
@property (getter = isGameAlertShown)BOOL endGameAlertShown;
@property (nonatomic,strong,getter = getNewView) UIImageView *endGameAlert;
@property (nonatomic, strong)IBOutlet UIButton* closeGameButton;
@property (nonatomic, weak) UILabel* stopWatchLabel;
@property (weak, nonatomic) IBOutlet UIButton *soloButton;
@property (weak, nonatomic) IBOutlet UIButton *shakeItButton;
@property (weak, nonatomic) IBOutlet UIButton *jackItButton;
@property (getter = isJackButtonPushed) BOOL jackButtonPushed;
@property (getter = isShakeButtonPushed) BOOL shakeButtonPushed;
@property (weak, nonatomic) IBOutlet UIButton *playButton;
@property (strong, nonatomic) NSString *filePic;
@end

@implementation ViewController

- (IBAction)practiceButton:(id)sender {
    
    
}

- (IBAction)pushShakeButton:(id)sender {
    self.shakeButtonPushed = YES;
    self.jackButtonPushed = NO;
    _filePic = @"VendingMachine.png";
    [self updateUI];
}

- (IBAction)pushJackButton:(id)sender {
    self.shakeButtonPushed = NO;
    self.jackButtonPushed = YES;
    _filePic = @"Jackit_Champagne.png";
    [self updateUI];
}

- (void) updateUI {
    if(!self.isJackButtonPushed && !self.isShakeButtonPushed)
    {
        self.playButton.enabled = NO;
        self.soloButton.enabled = NO;
        
        [self.shakeItButton setBackgroundImage:[UIImage imageNamed:@"SI.png"] forState:UIControlStateNormal];
        [self.jackItButton setBackgroundImage:[UIImage imageNamed:@"JI.png"] forState:UIControlStateNormal];
        return;
    }
    if(self.jackButtonPushed)
    {
        NSLog(@"Jack it pushed");
        [self.jackItButton setBackgroundImage:[UIImage imageNamed:@"JackIt_Button.png"] forState:UIControlStateNormal];
        [self.shakeItButton setBackgroundImage:[UIImage imageNamed:@"SI.png"] forState:UIControlStateNormal];
        
    }
    else if(self.shakeButtonPushed)
    {
        [self.shakeItButton setBackgroundImage:[UIImage imageNamed:@"ShakeIt_Button.png"] forState:UIControlStateNormal];
        [self.jackItButton setBackgroundImage:[UIImage imageNamed:@"JI.png"] forState:UIControlStateNormal];
    }
    
    self.soloButton.enabled = YES;
    self.playButton.enabled = YES;
}




- (void)viewWillAppear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear {
    [self.navigationController setNavigationBarHidden:NO];
    //[super viewWillDisappear:animated];
}

- (IBAction)optionsButton:(id)sender {
    UIView *slider=[[CustomAlert alloc]initWithFrame:CGRectMake(100, 100, 100, 100)];
    self.alert = [[CustomAlert alloc] initWithFrame:CGRectMake(50, 50, 200, 200)];
    [self.view addSubview:slider];
    
}
- (void)closeEndGameAlertButton {
    if(self.endGameAlert){
        [self.endGameAlert removeFromSuperview];
        NSLog(@"Tried to hide");
        self.endGameAlertShown = NO;
    }
    self.soloButton.enabled = YES;
    
  [self performSegueWithIdentifier:@"playSegue" sender:self];
    //This lets you call a segue
}



-(IBAction) buttonTapped:(id)sender {
   
    
    // This is the code to make an alert
    if(!self.isGameAlertShown)
    {
        /* This is creates the main alert box */
       
       // self.endGameAlert = [[UIView alloc] initWithFrame:CGRectMake(37,90,250,240)];
        self.endGameAlert = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Shakeit_ScoreboardWin.png"]];
        self.endGameAlert.frame = CGRectMake(35, 90, 250, 240);
        UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeRoundedRect]; //first button
        UIButton *reTryButton = [UIButton buttonWithType:UIButtonTypeRoundedRect]; //second button
        
        self.endGameAlert.layer.borderWidth = 0.1f;
        self.endGameAlert.layer.cornerRadius = 5;
        [cancelButton addTarget:self action:@selector(closeEndGameAlertButton) forControlEvents:UIControlEventTouchUpInside];
         [cancelButton addTarget:self action:@selector(playButton) forControlEvents:UIControlEventTouchUpInside];
        /* creates the body of the two buttons in the main view */
        [cancelButton setFrame:CGRectMake(10, 180, 110, 40)];
        [reTryButton setFrame:CGRectMake(130, 180, 110, 40)];
        
        /* customizes the first option button */
     
        [cancelButton setBackgroundImage:[UIImage imageNamed:@"Shakeit_ScoreboardLose_ReturnButton.png"] forState:UIControlStateNormal];
        
        cancelButton.layer.borderWidth = 0.1f;
        cancelButton.layer.cornerRadius = 5;
        
        
        /* customizes the second option button */
        
        [reTryButton setBackgroundImage:[UIImage imageNamed:@"Shakeit_ScoreboardLose_ShakeAgainButton.png"] forState:UIControlStateNormal];
       
        reTryButton.layer.borderWidth = 0.1f;
        reTryButton.layer.cornerRadius = 5;
        
        
        /* Adds the subView(buttons) to the view */
        self.endGameAlert.userInteractionEnabled = YES;
        [self.endGameAlert addSubview:cancelButton];
        [self.endGameAlert addSubview:reTryButton];
        
        [self.endGameAlert setTag:SUBVIEW_TAG]; //unique tag
        
        [self.view addSubview:self.endGameAlert]; //adds the main subview
        self.soloButton.enabled = NO;
    }
    /*Checks to see if the menu is up already */
    if(self.isGameAlertShown)
    {
       
        self.closeGameButton.enabled = NO;
        self.closeGameButton.hidden = YES;
        [self.endGameAlert removeFromSuperview];
        NSLog(@"Tried to hide");
        self.endGameAlertShown = NO;
        self.soloButton.enabled = YES;
        return;
    }
    
  
    // sets the background color/border of the main alert
    self.endGameAlert.backgroundColor = [UIColor grayColor];
    self.endGameAlert.layer.borderColor = [UIColor blackColor].CGColor;
    self.endGameAlert.layer.borderWidth = 0.5f;
    self.endGameAlert.layer.cornerRadius = 5;
    
    // add the new view as a subview to an existing one (e.g. self.view)
    [self.view addSubview:self.endGameAlert];
    self.closeGameButton.enabled = YES;
    self.closeGameButton.hidden = NO;
    
    
    self.endGameAlertShown = YES; //the pop up is showing
    

}

- (void)viewDidLoad
{
    [super viewDidLoad];
     self.navigationController.navigationBarHidden=YES;
    self.endGameAlert.hidden = YES;
    self.playButton.enabled = NO;
    self.soloButton.enabled = NO;
    self.shakeItButton.enabled = NO;
    [self updateUI];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
