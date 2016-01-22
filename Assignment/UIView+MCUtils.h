//
//  UIView+MCUtils.h
//  Assignment
//
//  Created by Matteo Comisso on 09/01/16.
//  Copyright © 2016 mcomisso. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (MCUtils)

+(UIView *)viewOfSize:(CGSize)size withGradientFromColor:(UIColor *)initialColor toColor:(UIColor *)endColor;

@end
