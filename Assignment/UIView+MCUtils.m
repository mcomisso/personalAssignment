//
//  UIView+MCUtils.m
//  Assignment
//
//  Created by Matteo Comisso on 09/01/16.
//  Copyright © 2016 mcomisso. All rights reserved.
//

#import "UIView+MCUtils.h"

@implementation UIView (MCUtils)

+(UIView *)viewOfSize:(CGSize)size withGradientFromColor:(UIColor *)initialColor toColor:(UIColor *)endColor {
    
    UIView *gradientView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    
    NSArray *gradientColors = [NSArray arrayWithObjects:(id)initialColor.CGColor, (id)endColor.CGColor, nil];
    NSArray *gradientLocations = [NSArray arrayWithObjects:[NSNumber numberWithInt:0.0], [NSNumber numberWithInt:1.0], nil];
    
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.colors = gradientColors;
    gradientLayer.locations = gradientLocations;
    
    gradientLayer.frame = gradientView.frame;
    [gradientView.layer insertSublayer:gradientLayer atIndex:0];
    
    return gradientView;
}

@end
