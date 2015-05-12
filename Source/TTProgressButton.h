//
//  TTProgressButton.h
//
//  Created by Valentin Kalchev on 05/06/2015.
//  Copyright (c) 2014 Triggertrap. All rights reserved.
//

@interface TTProgressButton : UIButton

@property (strong, nonatomic) NSMutableArray *animationImages;
@property (strong, nonatomic) UIImage *defaultImage;

@property (assign, nonatomic) float animationDuration;
@property (assign, nonatomic) float trackWidth;

@property (strong, nonatomic) UIColor *trackFillColor;
@property (strong, nonatomic) UIColor *trackBackgroundColor;
@property (strong, nonatomic) UIColor *trackBackgroundColorSelected;
@property (strong, nonatomic) UIColor *contentColourSelected;
@property (strong, nonatomic) UIColor *contentColour;
@property (strong, nonatomic) UIColor *contentFillColour;

#pragma mark - Public

- (void)startAnimating;
- (void)stopAnimating;

#pragma mark - Setters

- (void)setProgress:(float)value;
- (void)setButtonAppearance;

@end
