//
//  TimeIntervalFormatter.m
//  RealDudesWorkout
//
//  Created by Brian Clouser on 3/23/16.
//  Copyright © 2016 The Qwiz LLC. All rights reserved.
//

#import "TimeIntervalFormatter.h"

@implementation TimeIntervalFormatter


+(NSDateFormatter*)stockDateFormatter{
    NSDateFormatter *DF = [[NSDateFormatter alloc]init];
    DF.timeStyle = NSDateFormatterShortStyle;
    DF.dateStyle = NSDateFormatterShortStyle;
    return DF;
}


@end
