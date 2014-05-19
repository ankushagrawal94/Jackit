
//
//  PracticeViewController.m
//  Jackit
//
//  Created by Ankush Agrawal on 4/12/14.
//  Copyright (c) 2014 JoshAnatalioLAHacks. All rights reserved.
//

#import "PracticeViewController.h"
#import "ViewController.h"
#import "CustomAlert.h"
#import  "scoreCalculator.h"
#import "FirstViewController.h"
#import <Parse/Parse.h>
#define SUBVIEW_TAG 333

@interface PracticeViewController ()
@property (weak, nonatomic) IBOutlet UILabel *stopWatchLabel;
@property (nonatomic,strong,getter = getNewView) UIImageView *endGameAlert;
@property (getter = isGameAlertShown)BOOL endGameAlertShown;
@property (nonatomic) NSTimeInterval *timer;
@property(nonatomic) float timerValue;
@property ( nonatomic) NSUInteger countdown;
@property (strong, nonatomic) NSTimer *stopWatchTimer; // Store the timer that fires after a certain time
@property (strong, nonatomic) NSDate *startDate; // Stores the date of the click on the start button
@property (strong, nonatomic) IBOutlet UIImageView *practiceImageBackground;
@property (strong, nonatomic) IBOutlet UILabel *bigCountdownLabel;
@property  int stop;
@property NSInteger score;
@property (strong, nonatomic) scoreCalculator *forScore;
@property FirstViewController* firstViewController;
@property (strong, nonatomic) IBOutlet UIButton *playButton;
@property (strong, nonatomic) IBOutlet UILabel *scoreLabel;
@property (strong, nonatomic) IBOutlet UIButton *homeBUtton;

@end
@implementation PracticeViewController
- (IBAction)goBackHome:(id)sender {
    NSString* postRequest;
    
    postRequest = [NSString stringWithFormat:@"%@/%@/%@", @"http://jacbaciatge.herokuapp.com", @"interrupt", [PFUser currentUser].username];
    NSLog(@"url: %@", postRequest);
    
    NSURL *url = [NSURL URLWithString:postRequest];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    [request setHTTPMethod:@"POST"];
    [request setValue:@"text/html" forHTTPHeaderField:@"Accept"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    
    NSURLResponse *response = nil;
    NSError *error = nil;
    NSData *result = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    
    NSString *responseString = [[NSString alloc]initWithData:result encoding:NSUTF8StringEncoding];
    
    NSLog(@"RESULT = %@", responseString);

    [self.navigationController popToRootViewControllerAnimated:YES];
    
}


- (void)getScore
{
    [self.forScore viewDidLoad];
    self.score = self.forScore.score;
}

- (IBAction)startPlaying:(id)sender {
    self.playButton.enabled = NO;
    self.forScore = [[scoreCalculator alloc]init];
    NSLog(@"trying to get score");
    NSInteger num = 15;
    [self.forScore accelaScore:&num];
    
    self.score = self.forScore.score;
    
    NSLog(@"%f", self.forScore.score);
    [self startCountdown:self];
    [self updateUI];
    

}

- (void)updateUI
{
    int hi = (int)self.forScore.score;
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", hi];
    [self.scoreLabel bringSubviewToFront: self.scoreLabel];
    NSLog(@"Score: %f", self.forScore.score);
    [self.scoreLabel bringSubviewToFront:self.scoreLabel];
    
    
    
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
        NSString *timeString = [dateFormatter stringFromDate:timerDate];
        self.stopWatchLabel.text = timeString;
        return;
    }
    //lol to didnt want to do to stop anything inifinite loop
    if(self.stop < 2)
    {
    [self updateUI];
    [self gameOver];
        self.stop++;
    }
    return;
    
}

- (void)gameOver {
    self.endGameAlert = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Scoreboard.png"]];
    self.endGameAlert.frame = CGRectMake(35, 90, 250, 280);
    
    UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeRoundedRect]; //first button
    UIButton *reTryButton = [UIButton buttonWithType:UIButtonTypeRoundedRect]; //second button
    
    self.endGameAlert.layer.borderWidth = 0.1f;
    self.endGameAlert.layer.cornerRadius = 5;
    
    
    /* creates the body of the two buttons in the main view */
    [cancelButton setFrame:CGRectMake(10, 220, 110, 40)];
    [reTryButton setFrame:CGRectMake(130, 220, 110, 40)];
    
    /* customizes the first option button */
    
    [cancelButton setBackgroundImage:[UIImage imageNamed:@"Shakeit_ScoreboardLose_ReturnButton.png"] forState:UIControlStateNormal];
    
    cancelButton.layer.borderWidth = 0.1f;
    cancelButton.layer.cornerRadius = 5;
    
    [self updateUI];
    /* customizes the second option button */
    
    [reTryButton setBackgroundImage:[UIImage imageNamed:@"Shakeit_ScoreboardLose_ShakeAgainButton.png"] forState:UIControlStateNormal];
    
    reTryButton.layer.borderWidth = 0.1f;
    reTryButton.layer.cornerRadius = 5;
    
    
    /* Adds the subView(buttons) to the view */
    
    [cancelButton setEnabled:YES];
    [reTryButton setEnabled:YES];
    
    [cancelButton addTarget:self action:@selector(closeEndGameAlertButton) forControlEvents:UIControlEventTouchUpInside];
    
    [self.endGameAlert addSubview:cancelButton];
    [self.endGameAlert bringSubviewToFront:cancelButton];
    [self.endGameAlert addSubview:reTryButton];
    [self.endGameAlert bringSubviewToFront:reTryButton];
    [self.endGameAlert addSubview:cancelButton];
    [self.endGameAlert addSubview:reTryButton];
    [self updateUI];
    [self.endGameAlert setTag:SUBVIEW_TAG]; //unique tag
    
    [self.view addSubview:self.endGameAlert]; //adds the main subview
    self.endGameAlert.userInteractionEnabled = YES;
    /*Checks to see if the menu is up already */
    if(self.isGameAlertShown)
    {
        
        
        [self.endGameAlert removeFromSuperview];
        //NSLog(@"Tried to hide");
        self.endGameAlertShown = NO;
        return;
    }
    
    [self updateUI];
    // sets the background color/border of the main alert
    self.endGameAlert.backgroundColor = [UIColor grayColor];
    self.endGameAlert.layer.borderColor = [UIColor blackColor].CGColor;
    self.endGameAlert.layer.borderWidth = 0.1f;
    self.endGameAlert.layer.cornerRadius = 2;
    
    // add the new view as a subview to an existing one (e.g. self.view)
    [self.view addSubview:self.endGameAlert];
    
    NSLog(@"hi");
    
    /*//called end game post
    [self.firstViewController endGamePost: self.forScore.score];
    //call finalGet
    [self.firstViewController finalGet];
    */
    
    
    
    self.endGameAlertShown = YES; //the pop up is showing
    [self updateUI];
    
}


- (void)closeEndGameAlertButton {
    if(self.endGameAlert){
        [self.endGameAlert removeFromSuperview];
        NSLog(@"Tried to hide");
        self.endGameAlertShown = NO;
        self.playButton.enabled = NO;

    }
    
    [self.navigationController popToRootViewControllerAnimated:YES];
    //This lets you call a segue
}

- (IBAction)startCountdown
{
    self.startDate = [NSDate date];
    // Create the stop watch timer that fires every 100 ms
    
    self.stopWatchTimer = [NSTimer scheduledTimerWithTimeInterval:1.0/1000.0
                                                           target:self
                                                         selector:@selector(updateTimer)
                                                         userInfo:nil
                                                          repeats:YES];
}




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
    [super viewDidLoad];
    /*
    [self.firstViewController searchPartnerPost];
	BOOL isPartnerFound =[self.firstViewController startRequest];
    */
    //[self startCountdown];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end

