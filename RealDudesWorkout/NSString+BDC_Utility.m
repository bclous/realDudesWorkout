//
//  NSString+BDC_Utility.m
//  RealDudesWorkout
//
//  Created by Brian Clouser on 6/25/16.
//  Copyright © 2016 The Qwiz LLC. All rights reserved.
//

#import "NSString+BDC_Utility.h"

@implementation NSString (BDC_Utility)

+(NSString *)timeInSentenceForm:(NSTimeInterval)timeInSeconds includSecondsAlways:(BOOL)includeSecondsAlways includeSecondsWhenUnderOneHour:(BOOL)includeSecondsWhenUnderOneHour abbreviate:(BOOL)abbreviate
{
    if (!includeSecondsWhenUnderOneHour)
    {
        includeSecondsAlways = NO;
    }
    
    NSUInteger hours = timeInSeconds / 3600;
    NSUInteger minutes = ((NSUInteger)timeInSeconds % 3600) / 60;
    NSUInteger seconds = (((NSUInteger)timeInSeconds % 3600) % 60) / 60;
    
    if (seconds == 0)
    {
        includeSecondsWhenUnderOneHour = NO;
        includeSecondsAlways = NO;
    }
    
    BOOL hasHours = hours > 0;
    BOOL hasMinutes = minutes > 0;
    BOOL hourPlural = hours != 1;
    BOOL minutePlural = minutes !=1;
    BOOL secondPlural = seconds !=1;
    
    if (timeInSeconds == 0 || !(hasHours && hasMinutes))
    {
        return [NSString stringWithFormat:@"< 1 %@", [@"minutes" abbreviateTimeUnit:abbreviate plural:NO]];
    }
    
    else if (!hasHours)
    {
      
        if (includeSecondsWhenUnderOneHour)
        {
            return [NSString stringWithFormat:@"%lu %@ %lu %@", minutes, [@"minutes" abbreviateTimeUnit:abbreviate plural:minutePlural], seconds, [@"seconds" abbreviateTimeUnit:abbreviate plural:secondPlural]];
        }
        else
        {
            return [NSString stringWithFormat:@"%lu %@", minutes, [@"minutes" abbreviateTimeUnit:abbreviate plural:minutePlural]];
        }
        
    }
    
    else
    {
        if (!hasMinutes && !includeSecondsAlways)
        {
            return [NSString stringWithFormat:@"%lu %@", hours, [@"hours" abbreviateTimeUnit:abbreviate plural:hourPlural]];
        }
        else if (!hasMinutes)
        {
             return [NSString stringWithFormat:@"%lu %@ %lu %@", hours, [@"hours" abbreviateTimeUnit:abbreviate plural:hourPlural], seconds, [@"seconds" abbreviateTimeUnit:abbreviate plural:secondPlural]];
        }
        else if (hasMinutes && !includeSecondsAlways)
        {
            return [NSString stringWithFormat:@"%lu %@ %lu %@", hours, [@"hours" abbreviateTimeUnit:abbreviate plural:hourPlural], minutes, [@"minutes" abbreviateTimeUnit:abbreviate plural:minutePlural]];
        }
        else
        {
            return [NSString stringWithFormat:@"%lu %@ %lu %@ %lu %@", hours, [@"hours" abbreviateTimeUnit:abbreviate plural:hourPlural], minutes, [@"minutes" abbreviateTimeUnit:abbreviate plural:minutePlural], seconds, [@"seconds" abbreviateTimeUnit:abbreviate plural:secondPlural]];
        }
    }
    
}

+(NSString *)timeInClockForm:(NSTimeInterval)timeInSeconds
{
    
    NSUInteger hours = timeInSeconds / 3600;
    NSUInteger minutes = ((NSUInteger)timeInSeconds % 3600) / 60;
    NSUInteger seconds = (((NSUInteger)timeInSeconds % 3600) % 60) / 60;
    
    return [NSString stringWithFormat:@"%@%@%@", [NSString hoursFormatted:hours], [NSString minutesFormatted:minutes hasHours:hours > 0], [NSString secondsFormatted:seconds]];
    
}

- (NSString *)abbreviateTimeUnit:(BOOL)abbreviate plural:(BOOL)plural
{
    NSString *timeString;
    
    if ([self isEqualToString:@"hours"])
    {
        timeString =  abbreviate ? @"hrs" : @"hours";
    }
    else if ([self isEqualToString:@"minutes"])
    {
        timeString =  abbreviate ? @"mins" : @"minutes";
    }
    else
    {
        timeString =  abbreviate ? @"secs" : @"seconds";
    }
    
    if (plural)
    {
        return timeString;
    }
    else
    {
        return [timeString substringToIndex:[timeString length]-1];
    }
}

+(NSString *)hoursFormatted:(NSUInteger)hours
{
    if (hours == 0)
    {
        return @"";
    }
    else
    {
        return [NSString stringWithFormat:@"%lu:", hours];
    }
}

+(NSString *)minutesFormatted:(NSUInteger)minutes hasHours:(BOOL)hasHours
{
    if (hasHours && minutes < 10)
    {
        return [NSString stringWithFormat:@"0%lu:", minutes];
    }
    else
    {
        return [NSString stringWithFormat:@"%lu:", minutes];
    }
}

+(NSString *)secondsFormatted:(NSUInteger)seconds
{
    if (seconds < 10)
    {
        return [NSString stringWithFormat:@"0%lu", seconds];
    }
    else
    {
        return [NSString stringWithFormat:@"%lu", seconds];
    }
}



@end
