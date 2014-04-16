//
//  PracticeViewController.h
//  Jackit
//
//  Created by Ankush Agrawal on 4/12/14.
//  Copyright (c) 2014 JoshAnatalioLAHacks. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
@interface PracticeViewController : UIViewController

@end

@interface AppDelegate : UIResponder <UIApplicationDelegate, AVAudioPlayerDelegate>
{
    AVAudioPlayer *sexSounds;
}

@end
