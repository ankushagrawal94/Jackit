//
//  JackWithSomeoneViewController.m
//  Jackit
//
//  Created by Josh Anatalio on 4/12/14.
//  Copyright (c) 2014 JoshAnatalioLAHacks. All rights reserved.
//

#import "JackWithSomeoneViewController.h"
#import "ViewController.h"
#import "CustomAlert.h"
#import "AppDelegate.h"
#import <CoreMotion/CoreMotion.h>
#import "scoreCalculator.h"
#import <AudioToolbox/AudioToolbox.h>
#import "FirstViewController.h"
#define SUBVIEW_TAG 333

@interface JackWithSomeoneViewController ()
@property (weak, nonatomic) IBOutlet UILabel *stopWatchLabel;
@property (nonatomic,strong,getter = getNewView) UIImageView *endGameAlert;
@property (getter = isGameAlertShown)BOOL endGameAlertShown;
@property (nonatomic) NSTimeInterval *timer;
@property(nonatomic) float timerValue;
@property ( nonatomic) NSUInteger countdown;
@property (strong, nonatomic) NSTimer *stopWatchTimer; // Store the timer that fires after a certain time
@property (strong, nonatomic) NSDate *startDate; // Stores the date of the click on the start button
@property int stop;
@property double score;
@property (strong, nonatomic) scoreCalculator *forScore;
@property (strong, nonatomic) IBOutlet UILabel *scoreLabel;
@property (strong, nonatomic) IBOutlet UIImageView *bgImage;
@property FirstViewController *firstViewController;
@property (strong, nonatomic) IBOutlet UILabel *PRLabel;
@property (strong, nonatomic) IBOutlet UILabel *PartnerScore;
@property (strong, nonatomic) IBOutlet UILabel *YourScore;
@property (strong, nonatomic) IBOutlet UIButton *playButton;
@property (strong, nonatomic) IBOutlet UIButton *backHomeButton;

@end

AVAudioPlayer* sexAudio;
NSString *soundPath;

@implementation JackWithSomeoneViewController
- (IBAction)goBackHome:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
    
}
- (IBAction)playGame:(id)sender {
    self.playButton.enabled = NO;
    self.firstViewController = [[FirstViewController alloc]init];
    [self.firstViewController searchPartnerPost];
	BOOL isPartnerFound =[self.firstViewController startRequest];
    if (isPartnerFound){
        NSLog(@"Begin of useless for loop");
        for(int i=0; i < 100000000; i+=2){
            i--;
            i+=2;
            i-=2;
        }
    }
    NSLog(@"End of useless for loop");
    self.forScore = [[scoreCalculator alloc]init];
    NSLog(@"trying to get score");
    NSInteger num = 19;
    [self.forScore accelaScore:&num];
    
    self.score = self.forScore.score;
    
    NSLog(@"%f", self.forScore.score);
    [self startCountdown:self];
    [self updateUI];
    
    //[self gameOver];
}

- (void)getScore
{
    
}

-(void) playMusic
{
    soundPath = @" hi";
    soundPath = [[NSBundle mainBundle]pathForResource:@"Noise" ofType:@"m4a"];
    
    sexAudio = [[AVAudioPlayer alloc]initWithContentsOfURL:[NSURL fileURLWithPath:soundPath] error:NULL];
    //sexAudio.delegate = self;
    sexAudio.numberOfLoops = 0;
    [sexAudio play];
}

- (void)updateTimer
{
    // Create date from the elapsed time
    NSDate *currentDate = [NSDate date];
    NSTimeInterval timeInterval = [currentDate timeIntervalSinceDate:self.startDate];
   
    NSTimeInterval minusTime = 10.00 - timeInterval;
    if(minusTime >= 0.0)
    {
        NSDate *timerDate = [NSDate dateWithTimeIntervalSince1970:minusTime];
        
        // Create a date formatter
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"HH:mm:ss.SS"];
        [dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0.0]];
        
        // Format the elapsed time and set it to the label
        [self updateUI];
        NSString *timeString = [dateFormatter stringFromDate:timerDate];
        self.stopWatchLabel.text = timeString;
        return;
    }
    if(self.stop < 2)
    {
        [self gameOver];
        self.stop++;
        [self.scoreLabel bringSubviewToFront:self.scoreLabel];
        
    }
}

- (void)gameOver {
    
    NSLog(@"Game over");
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Jackit_ChampagneWin.png"]];
    
    //[self playMusic];
    AudioServicesPlayAlertSound(kSystemSoundID_Vibrate);
    self.endGameAlert = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Scoreboard.png"]];
    self.endGameAlert.frame = CGRectMake(35, 90, 250, 280);
    
    UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeRoundedRect]; //first button
    
    UIButton *reTryButton = [UIButton buttonWithType:UIButtonTypeRoundedRect]; //second button
    UIButton *scoreButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [self updateUI];
    
    self.endGameAlert.layer.borderWidth = 0.1f;
    self.endGameAlert.layer.cornerRadius = 5;
    
    
    /* creates the body of the two buttons in the main view */
    [cancelButton setFrame:CGRectMake(10, 220, 110, 40)];
    [reTryButton setFrame:CGRectMake(130, 220, 110, 40)];
    [ scoreButton setFrame:CGRectMake(60, 68, 110, 40)];
    
    /* customizes the first option button */
    
    [cancelButton setBackgroundImage:[UIImage imageNamed:@"Shakeit_ScoreboardLose_ReturnButton.png"] forState:UIControlStateNormal];
    
    cancelButton.layer.borderWidth = 0.1f;
    cancelButton.layer.cornerRadius = 5;
    
    [scoreButton setBackgroundColor:[UIColor clearColor]];
    [scoreButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    int newscore = (int)self.score;
    NSString* scoreString = [NSString stringWithFormat:@" %d", newscore];
    [scoreButton setTitle:scoreString forState:UIControlStateNormal];
    
    /* customizes the second option button */
    
    [reTryButton setBackgroundImage:[UIImage imageNamed:@"Shakeit_ScoreboardLose_ShakeAgainButton.png"] forState:UIControlStateNormal];
    
    reTryButton.layer.borderWidth = 0.1f;
    reTryButton.layer.cornerRadius = 5;
    
    
    /* Adds the subView(buttons) to the view */
    
    [cancelButton setEnabled:YES];
    [reTryButton setEnabled:YES];
    
    [cancelButton addTarget:self action:@selector(closeEndGameAlertButton) forControlEvents:UIControlEventTouchUpInside];
    [reTryButton addTarget:self action:@selector(closeEndGameAlert) forControlEvents:UIControlEventTouchUpInside];
    
    [self.endGameAlert addSubview:cancelButton];
    [self.endGameAlert bringSubviewToFront:cancelButton];
    [self.endGameAlert addSubview:reTryButton];
    [self.endGameAlert bringSubviewToFront:reTryButton];
    [self.endGameAlert addSubview:cancelButton];
    [self.endGameAlert addSubview:reTryButton];
    //[self.endGameAlert addSubview:scoreButton];
    //[self.endGameAlert bringSubviewToFront:scoreButton];
    
    
    [self.endGameAlert setTag:SUBVIEW_TAG]; //unique tag
    
    [self.view addSubview:self.endGameAlert]; //adds the main subview
    self.endGameAlert.userInteractionEnabled = YES;
    /*Checks to see if the menu is up already */
    
    [self.firstViewController endGamePost: self.forScore.score];
    [self.firstViewController finalGet];
    _YourScore.text = self.firstViewController.myFinalScore;
    _PartnerScore.text = self.firstViewController.partnerFinalScore;
    
    
    if(self.isGameAlertShown)
    {
        
        
        [self.endGameAlert removeFromSuperview];
        NSLog(@"Tried to hide");
        self.endGameAlertShown = NO;
        [self.scoreLabel bringSubviewToFront:self.scoreLabel];
        
        return;
    }
    
    
    // sets the background color/border of the main alert
    self.endGameAlert.backgroundColor = [UIColor grayColor];
    self.endGameAlert.layer.borderColor = [UIColor blackColor].CGColor;
    self.endGameAlert.layer.borderWidth = 0.1f;
    self.endGameAlert.layer.cornerRadius = 2;
    
    // add the new view as a subview to an existing one (e.g. self.view)
    [self.view addSubview:self.endGameAlert];
    
    [self updateUI];
    self.endGameAlertShown = YES; //the pop up is showing
    
    
    
    [self.scoreLabel bringSubviewToFront:self.scoreLabel];
    
    
}
- (void)updateUI
{
    int hi = (int)self.forScore.score;
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", hi];
    [self.scoreLabel bringSubviewToFront: self.scoreLabel];
    NSLog(@"Score: %d", hi);
    [self.scoreLabel bringSubviewToFront:self.scoreLabel];
    
    
    
}

-(void) closeEndGameAlert {
    [self.endGameAlert removeFromSuperview];
    self.endGameAlert.hidden = YES;
    NSLog(@"Tried to hide");
    self.endGameAlertShown = NO;
    self.playButton.enabled = YES;
}
- (void)closeEndGameAlertButton {
    if(self.endGameAlert){
        [self.endGameAlert removeFromSuperview];
        NSLog(@"Tried to hide");
        self.endGameAlertShown = NO;
    }
    
    
    [self.navigationController popToRootViewControllerAnimated:YES];
    //This lets you call a segue
}

- (IBAction)startCountdown:(id)sender
{
    self.startDate = [NSDate date];
    // Create the stop watch timer that fires every 100 ms
    
    self.stopWatchTimer = [NSTimer scheduledTimerWithTimeInterval:1.0/1000.0
                                                           target:self
                                                         selector:@selector(updateTimer)
                                                         userInfo:nil
                                                          repeats:YES];
}



- (void) calculateScore
{
    
}





@end