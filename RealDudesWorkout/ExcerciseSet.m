//
//  ExcerciseSet.m
//  RealDudesWorkout
//
//  Created by Brian Clouser on 3/18/16.
//  Copyright © 2016 The Qwiz LLC. All rights reserved.
//

#import "ExcerciseSet.h"
#import "Circuit.h"
#import "Excercise.h"

@implementation ExcerciseSet

// Insert code here to add functionality to your managed object subclass


-(NSString *)timeStringFromActualExcerciseSetTime
{
    
    NSTimeInterval interval = self.timeInSecondsActual;
    
    NSInteger hours = interval/3600;
    NSInteger minutes = ((NSUInteger)interval % 3600)/60;
    
    NSLog(@"%lu hours nad %lu minutes", hours, minutes);
    
    
    BOOL hasHours = hours > 0;
    BOOL hasMinutes = minutes > 0;
    
    BOOL oneHour = hours == 1;
    BOOL oneMinute = minutes == 1;
    
    
    
    if (hasHours && !oneHour && hasMinutes && !oneMinute)
    {
        return [NSString stringWithFormat:@"%lu hrs and %lu min",hours, minutes];
    }
    else if (hasHours && oneHour && hasMinutes && !oneMinute)
    {
        return [NSString stringWithFormat:@"%lu hr and 1 min",hours];
    }
    else if (hasHours && !oneHour && !hasMinutes)
    {
        return [NSString stringWithFormat:@"%lu hrs",hours];
    }
    else if(hasHours && oneHour && !hasMinutes)
    {
        return [NSString stringWithFormat:@"1 hr"];
    }
    else if (!hasHours && hasMinutes && !oneMinute)
    {
        return [NSString stringWithFormat:@"%lu min",minutes];
    }
    else if (!hasHours && hasMinutes && oneMinute)
    {
        return [NSString stringWithFormat:@"1 min"];
    }
    else
    {
        return @"< 1 minute";
    }
    
}

-(NSString *)generateExcerciseDurationTimeString
{
    NSTimeInterval time = self.timeInSecondsActual;
    
    NSInteger hours = time/3600;
    NSInteger minutes = (((NSInteger)time)%3600)/60;
    NSInteger seconds = (((NSInteger)time)%3600)%60;
    
    BOOL hasHours = hours > 0;
    BOOL hasMinutes = minutes > 0;
    
    
    if (!hasHours && !hasMinutes)
    {
        NSString *stringNoMinutesOrHours = [NSString stringWithFormat:@"0:%@",[self timeStringFromTime:seconds]];
        
        return stringNoMinutesOrHours;
    }
    
    else if (!hasHours)
    {
        NSString *stringNoHours = [NSString stringWithFormat:@"%@:%@",[self timeStringFromTime:minutes],[self timeStringFromTime:seconds]];
        
        return stringNoHours;
    }
    
    else if (hasHours)
    {
        NSString *stringWithHours = [NSString stringWithFormat:@"%@:%@:%@",[self timeStringFromTime:hours],[self timeStringFromTime:minutes],[self timeStringFromTime:seconds]];
        
        return stringWithHours;
    }
    else
    {
        return @"0:00";
    }
    
    
    
}

-(NSString *)timeStringFromTime:(NSInteger)time
{
    BOOL singleDigit = time < 10;
    
    if (singleDigit)
    {
        NSString *timeString = [NSString stringWithFormat:@"0%li",time];
        
        return timeString;
        
    }
    else
    {
        NSString *timeString = [NSString stringWithFormat:@"%li",time];
        
        return timeString;
    }
}

@end
