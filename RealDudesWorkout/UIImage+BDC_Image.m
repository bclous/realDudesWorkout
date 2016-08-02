//
//  UIImage+BDC_Image.m
//  RealDudesWorkout
//
//  Created by Brian Clouser on 8/1/16.
//  Copyright © 2016 The Qwiz LLC. All rights reserved.
//

#import "UIImage+BDC_Image.h"

@implementation UIImage (BDC_Image)

- (UIImage *)bdc_tintImageWithColor:(UIColor *)color {
    
    CGRect contextRect;
    contextRect.origin.x = 0.0f;
    contextRect.origin.y = 0.0f;
    contextRect.size = [self size];
    
    // Retrieve source image and begin image context
    
    CGSize itemImageSize = [self size];
    CGPoint itemImagePosition;
    
    itemImagePosition.x = ceilf((contextRect.size.width - itemImageSize.width) / 2);
    itemImagePosition.y = ceilf((contextRect.size.height - itemImageSize.height));
    
    if ([[UIScreen mainScreen] respondsToSelector:@selector(scale)]) {
        
        UIGraphicsBeginImageContextWithOptions(contextRect.size, NO, [[UIScreen mainScreen] scale]); // Retina support
    } else {
        UIGraphicsBeginImageContext(contextRect.size);
    }
    
    CGContextRef c = UIGraphicsGetCurrentContext();
    
    // Setup shadow
    
    // Setup transparency layer and clip to mask
    
    CGContextBeginTransparencyLayer(c, NULL);
    CGContextScaleCTM(c, 1.0, -1.0);
    CGContextClipToMask(c, CGRectMake(itemImagePosition.x, -itemImagePosition.y, itemImageSize.width, -itemImageSize.height), [self CGImage]);
    
    CGContextSetFillColorWithColor(c, color.CGColor);
    
    contextRect.size.height = -contextRect.size.height;
    CGContextFillRect(c, contextRect);
    CGContextEndTransparencyLayer(c);
    
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    return img;
}



@end
