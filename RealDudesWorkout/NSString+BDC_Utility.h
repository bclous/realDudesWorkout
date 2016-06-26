//
//  NSString+BDC_Utility.h
//  RealDudesWorkout
//
//  Created by Brian Clouser on 6/25/16.
//  Copyright © 2016 The Qwiz LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (BDC_Utility)

+(NSString *)timeInSentenceForm:(NSTimeInterval)timeInSeconds includSecondsAlways:(BOOL)includeSecondsAlways includeSecondsWhenUnderOneHour:(BOOL)includeSecondsWhenUnderOneHour abbreviate:(BOOL)abbreviate;

+(NSString *)timeInClockForm:(NSTimeInterval)timeInSeconds;

@end
