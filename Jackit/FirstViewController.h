//
//  FirstViewController.h
//  FoodMapSearch
//
//  Created by Ankush Agrawal on 4/12/14.
//  Copyright (c) 2014 AnkushAgrawal. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FirstViewController : UIViewController
@property NSString *baseURL;
@property NSString *partnerName;
@property NSString *myFinalScore;
@property NSString *partnerFinalScore;
@property NSString *gameID;

- (void)applicationDidEnterBackground:(UIApplication *)application;
-(void) searchPartnerPost;
- (BOOL) startRequest;
-(void) endGamePost: (double) includeScore;
- (void) finalGet;
@end
