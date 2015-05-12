//
//  UIImage+Alpha.m 
//
//  Created by Valentin Kalchev on 05/06/2015.
//  Copyright (c) 2014 Triggertrap. All rights reserved.
//

#import "UIImage+Alpha.h"

@implementation UIImage (Alpha)

- (UIImage *)changeImageToColor:(UIColor *)color {
    
    UIImage *image = self;
    
    CGRect rect = CGRectMake(0, 0, image.size.width * [[UIScreen mainScreen] scale], image.size.height * [[UIScreen mainScreen] scale]);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextClipToMask(context, rect, image.CGImage);
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    UIImage *flippedImage = [UIImage imageWithCGImage:img.CGImage scale:1.0 orientation: UIImageOrientationDownMirrored];
    return flippedImage;
}
@end
