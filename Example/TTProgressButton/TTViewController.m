//
//  TTViewController.m
//  TTTwitterButton
//
//  Created by Valentin Kalchev on 05/06/2015.
//  Copyright (c) 2014 Triggertrap. All rights reserved.
//

#import "TTViewController.h"
#import <TTProgressButton/TTProgressButton.h>
#include <stdlib.h>

@interface TTViewController ()
{
    NSTimer *timer;
    float progress;
    BOOL isAnimating;
}
@property(nonatomic, weak) IBOutlet TTProgressButton *twitterButton;

@end

@implementation TTViewController

# pragma mark - Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    isAnimating = false;
    
    // Change images that will be animated
//         self.twitterButton.animationImages = [NSMutableArray arrayWithObjects:@"",@"",@"",@"", nil];
    
    // Change default image
//         self.twitterButton.defaultImage = [UIImage imageNamed: @""];
    
    // Change repeated animation duration
         self.twitterButton.animationDuration = 0.1f;
    
    // Change width of the track
         self.twitterButton.trackWidth = 3;
    
    // Change track fill color
         self.twitterButton.trackFillColor = [UIColor yellowColor];
    
    // Change track background color
         self.twitterButton.trackBackgroundColor = [UIColor blackColor];
    
    // Change track background color when selected
         self.twitterButton.trackBackgroundColorSelected = [UIColor redColor];
    
    // Change image content color
         self.twitterButton.contentColour = [UIColor redColor];
    
    // Change image content color when selected
         self.twitterButton.contentColourSelected = [UIColor redColor];
    
    // Change color of the space behind the image
         self.twitterButton.contentFillColour= [UIColor purpleColor];
    
    [self.twitterButton setButtonAppearance];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

# pragma mark - Actions

- (IBAction)twitterButtonTapped:(TTProgressButton *)button {
    
    if (isAnimating) {
        return;
    } else {
        isAnimating = true;
        
        [self.twitterButton startAnimating];
        progress = 0.0;
        
        timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(increaseProgress) userInfo:nil repeats:true];
        [timer fire];
    }
}

- (void)increaseProgress{
    progress += (25 + rand() % 10);
    [self.twitterButton setProgress:progress / 100.0];
    
    if (progress > 100.0) {
        progress = 100.0;
        [timer invalidate];
        
        [self.twitterButton stopAnimating];
        isAnimating = false;
        NSLog(@"Stop Animating");
    }
}

@end
