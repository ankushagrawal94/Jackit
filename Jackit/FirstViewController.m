//
//  FirstViewController.m
//  FoodMapSearch
//
//  Created by Ankush Agrawal on 4/12/14.
//  Copyright (c) 2014 AnkushAgrawal. All rights reserved.
//

#import "FirstViewController.h"
#import <Parse/Parse.h>
@interface FirstViewController ()
@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic) CLLocationCoordinate2D userLocation;
@property CLLocationCoordinate2D currLoc;
@end

@implementation FirstViewController

- (void)viewDidLoad
{
    /*[super viewDidLoad];
	// Do any additional setup after loading the view.
    self.baseURL = @"http://jacbaciatge.herokuapp.com";
    [self searchPartnerPost];
    BOOL isPartnerFound =[self startRequest];
    if (isPartnerFound){
    NSLog(@"Begin of useless for loop");
    for(int j = 0; j < 1000000000; j++)
    {
        for(int i=0; i < 2000000000; i+=2){
            i--;
            i+=2;
            i-=2;
            i+=2;
            i-=2;
        }
    }
    NSLog(@"End of useless for loop");
    double madeUpScore = 2016;
    [self endGamePost:(double) madeUpScore];
    [self finalGet];
}*/
}

#pragma mark - CLLocationManagerDelegate


- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    NSLog(@"didUpdateToLocation: %@", newLocation);
    CLLocation *currentLocation = newLocation;
    
    self.currLoc = currentLocation.coordinate;
    
    if (currentLocation != nil) {

    }
}


- (void)viewDidAppear:(BOOL)animated {
    
}



-(void) searchPartnerPost{
    //NSMutableString* postRequest;
    //add user to the queue to play!!
    
    
    NSString *postRequest = [NSString stringWithFormat:@"%@/%@/%@", @"http://jacbaciatge.herokuapp.com", @"seek", [PFUser currentUser].username];
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
    NSLog(@"final url: %@", postRequest);
    NSLog(@"RESULT = %@", responseString);
}






- (BOOL) startRequest{
    NSLog(@"TEST");
    //loop until a partner is found else no partners
    NSString* getRequest;
    NSString *responseString;
    int currentTime = 1;
    
    NSDate *currentDateTime = [NSDate date];
    NSDate *finalDateTime = [currentDateTime dateByAddingTimeInterval:20];
    NSTimeInterval distanceBetweenDates = [finalDateTime timeIntervalSinceDate:currentDateTime];
do{
    
    /*for(int i=0; i < 10000000; i+=2)
    {
        i--;
        i+=2;
        i-=2;
    }
    */
    NSDate *innerDateTime = [NSDate date];
    NSDate *innerFinalDateTime = [currentDateTime dateByAddingTimeInterval:1.5];
    NSTimeInterval innerDistanceBetweenDates = [innerFinalDateTime timeIntervalSinceDate:innerDateTime];
    
    while (innerDistanceBetweenDates > 0)
    {
        NSLog(@"Killing time");
        innerDateTime = [NSDate date];
        innerDistanceBetweenDates = [innerFinalDateTime timeIntervalSinceDate:innerDateTime];
    }
    
    
    getRequest = [NSString stringWithFormat:@"%@/%@/%@", @"http://jacbaciatge.herokuapp.com", @"check", [PFUser currentUser].username];
    NSLog(@"sent check to url: %@", getRequest);
        
    NSURL *url = [NSURL URLWithString:getRequest];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
        
    [request setHTTPMethod:@"GET"];
    [request setValue:@"text/html" forHTTPHeaderField:@"Accept"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    
    NSHTTPURLResponse *response = nil;
    NSError *error = nil;
    // this will perform a synchronous GET operation passing the values you specified in the header (typically you want asynchrounous, but for simplicity of answering the question it works)
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    responseString = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
    NSLog(@"final url: %@", getRequest);
    NSLog(@"Response: %@", responseString);
    NSLog(@"Current Time: %@", currentDateTime);
    NSLog(@"Final Date Time: %@", finalDateTime);
    NSLog(@"time interval since date: %f", distanceBetweenDates);

    currentTime++;
    currentDateTime = [NSDate date];
    distanceBetweenDates = [finalDateTime timeIntervalSinceDate:currentDateTime];

} while([responseString isEqual: @"no"] && distanceBetweenDates > 0/*( currentDateTime < finalDateTime)*/);
    NSLog(@"time interval since date: %f", distanceBetweenDates);
    if (/*currentDateTime > finalDateTime*/ distanceBetweenDates < 0 && [responseString isEqual: @"no"]) {
        // QUIT GET THE FUCK OUT
        //NSLog(@"Current Time: %@", currentDateTime);
        //NSLog(@"Final Date Time: %@", finalDateTime);
        NSLog(@"QUITTING THE FUCK OUT \n \n \n \n");
        [self applicationDidEnterBackground:nil]; //should send the iterrupt signal
        return false;
        
    }
    
    if([responseString isEqual:@"none"]){
        [self applicationDidEnterBackground:nil];
        return false;
    }
    
    NSLog(@"Response FOR CHECK: %@", responseString);
    
    //process usernames passed in
    NSString *results = responseString;
    NSArray *playerNames = [results componentsSeparatedByString:@" "];
    if([playerNames[0] isEqualToString:([PFUser currentUser].username)]){
        self.partnerName = playerNames[1];
    }
    else{
        self.partnerName = playerNames[0];
    }
    
    
    return true;
    
}

-(void) endGamePost: (double) includeScore {
    //one person has completed the game and has a score
    NSString *postRequest = [NSString stringWithFormat:@"%@/%@/%@/%d", @"http://jacbaciatge.herokuapp.com", @"finished", [PFUser currentUser].username, (int)includeScore];
    NSLog(@"url: %@", postRequest);
    
    NSURL *url = [NSURL URLWithString:postRequest];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    [request setHTTPMethod:@"POST"];
    [request setValue:@"text/html" forHTTPHeaderField:@"Accept"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    //[request setHTTPBody:data];
    
    self.myFinalScore = [NSString stringWithFormat:@"%f", includeScore];
    
    NSURLResponse *response = nil;
    NSError *error = nil;
    NSData *result = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    NSString *responseString = [[NSString alloc]initWithData:result encoding:NSUTF8StringEncoding];
    NSLog(@"final url: %@", postRequest);
    NSLog(@"RESULT = %@", responseString);
    
    
}
- (void) finalGet{
    //loop until a partner is found else no partners
    NSString* getRequest;
    NSString *responseString;
    
    NSDate *currentDateTime = [NSDate date];
    NSDate *finalDateTime = [currentDateTime dateByAddingTimeInterval:10];
    NSTimeInterval distanceBetweenDates = [finalDateTime timeIntervalSinceDate:currentDateTime];
    
    do{
        
        for(int i=0; i < 10000000; i+=2)
         {
         i--;
         i+=2;
         i-=2;
         }
        
        
        
        
        
        NSDate *innerDateTime = [NSDate date];
        NSDate *innerFinalDateTime = [currentDateTime dateByAddingTimeInterval:3];
        NSTimeInterval innerDistanceBetweenDates = [innerFinalDateTime timeIntervalSinceDate:innerDateTime];
        
        while (innerDistanceBetweenDates > 0)
        {
            NSLog(@"Killing time");
            innerDateTime = [NSDate date];
            innerDistanceBetweenDates = [innerFinalDateTime timeIntervalSinceDate:innerDateTime];
        }
        
        getRequest = [NSString stringWithFormat:@"%@/%@/%@", @"http://jacbaciatge.herokuapp.com", @"postgame", [PFUser currentUser].username];
        NSLog(@"url: %@", getRequest);
        
        NSURL *url = [NSURL URLWithString:getRequest];
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
        
        [request setHTTPMethod:@"GET"];
        [request setValue:@"text/html" forHTTPHeaderField:@"Accept"];
        [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
        
        NSHTTPURLResponse *response = nil;
        NSError *error = nil;
    
    
        // this will perform a synchronous GET operation passing the values you specified in the header (typically you want asynchrounous, but for simplicity of answering the question it works)
        NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
        responseString = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
        NSLog(@"final url: %@", getRequest);
        NSLog(@"Response: %@", responseString);
        
        //NSLog(@"REACHED");

    }
    while([responseString isEqual: @"wait"] && distanceBetweenDates > 0);
    NSLog(@"DON'T FUCKING GET TO HERE");
    if([responseString isEqual:@"cancel"] || [responseString isEqual:@"exit"]){
            [self applicationDidEnterBackground:nil];
            return;
    }
    
    
    //start game view. Don't forget at the end of game view to send a call to the endgamepost
    
}


- (void)applicationDidEnterBackground:(UIApplication *)application
{
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
    
}


@end