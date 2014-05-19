//
//  CustomAlert.m
//  Jackit
//
//  Created by Josh Anatalio on 4/12/14.
//  Copyright (c) 2014 JoshAnatalioLAHacks. All rights reserved.
//

#import "CustomAlert.h"
#import <QuartzCore/QuartzCore.h>

@implementation CustomAlert



@synthesize toggleButton;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        toggleButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [toggleButton setTitle:@"" forState:UIControlStateNormal];
        toggleButton.userInteractionEnabled=YES;
        
        // add drag listener
        [toggleButton addTarget:self action:@selector(wasDragged:withEvent:)
               forControlEvents:UIControlEventTouchDragInside];
        
        // center and size
        toggleButton.frame = CGRectMake(frame.origin.x, frame.origin.y, 150, frame.size.height);
        
        toggleButton.backgroundColor=[UIColor colorWithRed:0.1 green:0.1 blue:0.0 alpha:0.1];
        [toggleButton.layer setBorderWidth:4.0];
        [toggleButton.layer setBorderColor:[[UIColor lightGrayColor] CGColor]];
        toggleButton.layer.cornerRadius=4.0;
        [toggleButton setTitleColor:[UIColor colorWithRed:0.3 green:0.1 blue:0.4 alpha:1.0] forState:UIControlStateNormal];
        
        // add it, centered
        [self addSubview:toggleButton];
    }
    return self;
}

- (void)wasDragged:(UIButton *)button withEvent:(UIEvent *)event
{
    NSLog(@"inside drag");
}
@end
