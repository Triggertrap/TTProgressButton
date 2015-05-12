//
//  TTProgressButton.m
//
//  Created by Valentin Kalchev on 05/06/2015.
//  Copyright (c) 2014 Triggertrap. All rights reserved.
//

#import "TTProgressButton.h"
#import "UIImage+Alpha.h"

#define degreesToRadians(degrees) ((degrees) / 180.0 * M_PI)

@interface TTProgressButton () {
    float previousProgress;
    
    CAShapeLayer *progressLayer;
    CAShapeLayer *backgroundCircleLayer;
    UIImageView *innerImageView;
}

@end

@implementation TTProgressButton

#pragma mark - Lifecycle

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
        // Init code here
    }
    return self;
}

#pragma mark - Public

- (void)startAnimating {
    
    innerImageView.animationDuration = [self animationDuration];
    [innerImageView startAnimating];
    
    progressLayer = [CAShapeLayer layer];
    progressLayer.path = [[self path] CGPath];
    progressLayer.strokeColor = [[self trackFillColor] CGColor];
    progressLayer.lineWidth = [self trackWidth];
    progressLayer.fillColor = [[UIColor clearColor] CGColor];
    
    // Hide the layer before adding it
    progressLayer.hidden = YES;
    
    [self.layer addSublayer:progressLayer];
}

- (void)stopAnimating {
    [progressLayer removeFromSuperlayer];
    [innerImageView stopAnimating];
    
    innerImageView.image = [[self defaultImage] changeImageToColor:[self contentColour]];
    
    previousProgress = 0.0f;
}

#pragma mark - Private

- (UIBezierPath *)path {
    // Degrees start from -90 and end a full circle at 270 because layer coordinate system is different than the UI coordinate system
    // and circle gets drawn from the right hand side of its layer center
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.frame.size.width / 2, self.frame.size.height / 2)
                                                        radius:(self.frame.size.height - [self trackWidth]) / 2
                                                    startAngle:degreesToRadians(-90)
                                                      endAngle:degreesToRadians(270)
                                                     clockwise:YES];
    path.lineWidth = [self trackWidth];
    return path;
}

#pragma mark - Setters

- (void)setProgress:(float)progress {
    // Show the layer before animating it
    progressLayer.hidden = NO;
    
    CGFloat pinnedProgress = MIN(MAX(progress, 0.0f), 1.0f);
    
    // Animate path
    CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    pathAnimation.duration = fabs(previousProgress - pinnedProgress);
    pathAnimation.fromValue = [NSNumber numberWithFloat:previousProgress];
    pathAnimation.toValue = [NSNumber numberWithFloat:pinnedProgress];
    pathAnimation.fillMode = kCAFillModeForwards;
    pathAnimation.removedOnCompletion = NO;
    [progressLayer addAnimation:pathAnimation forKey:@"strokeEnd"];
    
    previousProgress = progress;
}

- (void)setButtonAppearance {
    backgroundCircleLayer = [CAShapeLayer layer];
    backgroundCircleLayer.path = [[self path] CGPath];
    backgroundCircleLayer.strokeColor = [[self trackBackgroundColor] CGColor];
    backgroundCircleLayer.lineWidth = [self trackWidth];
    backgroundCircleLayer.fillColor = [[self contentFillColour] CGColor];
    
    [self.layer addSublayer:backgroundCircleLayer];
    
    NSMutableArray *animationImagesWithNewColor = [NSMutableArray new];
    
    // Change the colour of the images with desired one
    for (NSString *string in [self animationImages]) {
        [animationImagesWithNewColor addObject:[[UIImage imageNamed:string] changeImageToColor:[self contentColourSelected]]];
    }
    
    innerImageView = [[UIImageView alloc] initWithImage:[[self defaultImage] changeImageToColor:[self contentColour]]];
    
    // Offset is x - Diagonal of the UIButton minus diagonal of the square inside the circle devided by 2 / sqrt(2)
    //  ________
    // | _____  |
    // |x|    | |
    // | |    | |
    // | |____| |
    // |________|
    
    float offset = ((self.frame.size.width * sqrt(2) - self.frame.size.width) / 2) / sqrt(2);
    
    // Inner square
    innerImageView.frame = CGRectMake(offset, offset, self.frame.size.width - 2 * offset, self.frame.size.height - 2 * offset);
    innerImageView.animationImages = animationImagesWithNewColor;
    
    [self addSubview:innerImageView];
}

#pragma mark - Getters 

- (UIImage *)defaultImage {
    return _defaultImage ? _defaultImage : [UIImage imageNamed:@"TwitterBird_1"];
}

- (NSMutableArray *)animationImages {
    return _animationImages ? _animationImages : [NSMutableArray arrayWithObjects:@"TwitterBird_2", @"TwitterBird_3", @"TwitterBird_4", @"TwitterBird_5", @"TwitterBird_6", nil];
}

- (UIColor *)trackFillColor {
    return _trackFillColor ? _trackFillColor : [UIColor redColor];
}

- (UIColor *)trackBackgroundColorSelected {
    return _trackBackgroundColorSelected ? _trackBackgroundColorSelected : [UIColor colorWithRed:0.290 green:0.565 blue:0.886 alpha:1];
}

- (UIColor *)trackBackgroundColor {
    return _trackBackgroundColor ? _trackBackgroundColor : [UIColor colorWithRed:0.290 green:0.565 blue:0.886 alpha:1];
}

- (UIColor *)contentColour {
    return _contentColour ? _contentColour : [UIColor colorWithRed:0.290 green:0.565 blue:0.886 alpha:1];
}

- (UIColor *)contentColourSelected {
    return _contentColourSelected ? _contentColourSelected : [UIColor redColor];
}

- (UIColor *)contentFillColour {
    return _contentFillColour ? _contentFillColour : [UIColor clearColor];
}

- (float)animationDuration {
    return _animationDuration ? _animationDuration : 0.5f;
}

- (float)trackWidth {
    return _trackWidth ? _trackWidth : 1.0f;
}

@end
