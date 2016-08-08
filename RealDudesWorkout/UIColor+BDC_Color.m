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
    return [UIColor colorWithRed:36.0/255.0 green:191.0/255.0 blue:0.0/255.0 alpha:1];
}
+(UIColor *)bdc_redColor
{
    return [UIColor colorWithRed:255.0/255.0 green:0.0/255.0 blue:0/255.0 alpha:1];
}
+(UIColor *)bdc_lightText1
{
    return [[UIColor whiteColor] colorWithAlphaComponent:.9];
}
+(UIColor *)bdc_lightText2
{
    return [[UIColor whiteColor] colorWithAlphaComponent:.7];
}
+(UIColor *)bdc_lightText3
{
    return [[UIColor whiteColor] colorWithAlphaComponent:.5];
}
+(UIColor *)bdc_darkText1
{
    return [[UIColor blackColor] colorWithAlphaComponent:.9];
}
+(UIColor *)bdc_darkText2
{
    return [[UIColor blackColor] colorWithAlphaComponent:.7];
}
+(UIColor *)bdc_darkText3
{
    return [[UIColor blackColor] colorWithAlphaComponent:.5];
}
+(UIColor *)bdc_offblackbackgroundColor
{
    return [UIColor colorWithRed:31.0/255.0 green:33.0/255.0 blue:36.0/255.0 alpha:1];
}


@end
