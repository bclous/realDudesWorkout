//
//  UIColor+BDC_Color.m
//  RealDudesWorkout
//
//  Created by Brian Clouser on 8/1/16.
//  Copyright © 2016 The Qwiz LLC. All rights reserved.
//

#import "UIColor+BDC_Color.h"

@implementation UIColor (BDC_Color)

+(UIColor *)bdc_blueMainColor
{
    return [UIColor colorWithRed:83.0/255.0 green:163.0/255.0 blue:1 alpha:1];
}
+(UIColor *)bdc_greenColor
{
    return [UIColor colorWithRed:0.0/255.0 green:255.0/255.0 blue:0.0/255.0 alpha:1];
}
+(UIColor *)bdc_redColor
{
    return [UIColor colorWithRed:255.0/255.0 green:0.0/255.0 blue:0/255.0 alpha:1];
}

@end
