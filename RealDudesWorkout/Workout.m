//
//  Workout.m
//  RealDudesWorkout
//
//  Created by Brian Clouser on 3/9/16.
//  Copyright © 2016 The Qwiz LLC. All rights reserved.
//

#import "Workout.h"

@implementation Workout

// Insert code here to add functionality to your managed object subclass


-(NSMutableArray *)excercisesInOrder
{
   
    NSMutableArray *excerciseSetsInOrder = [[NSMutableArray alloc] init];
    
    for (Circuit *circuit in self.circuits)
    {
        NSArray *excerciseSetsInCircuitInOrder = [circuit excerciseSetsInOrder];
        
        for (ExcerciseSet *excerciseSet in excerciseSetsInCircuitInOrder)
        {
            NSLog(@"getting in here");
            [excerciseSetsInOrder addObject:excerciseSet];
        }
    }
    
    return excerciseSetsInOrder;

}

-(NSString *)excercisesCompletedString
{
    NSArray *excercises = [self excercisesInOrder];
    
    NSUInteger totalExcercises = excercises.count;
    
    NSUInteger counter = 0;
    
    for (ExcerciseSet *excerciseSet in excercises)
    {
        if (excerciseSet.isComplete)
        {
            counter ++;
        }
    }
    
    //BOOL workoutCompleted = (counter == totalExcercises);
    
    NSString *message = [NSString stringWithFormat:@"Completed %lu/%lu excercises",(unsigned long)counter,(unsigned long)totalExcercises];
    
    return message;
    
    
}

-(NSArray *)completedExcercisesInOrder
{
    NSArray *allExcercises = [self excercisesInOrder];
    
    NSPredicate *completedPredicate = [NSPredicate predicateWithFormat:@"isComplete = YES"];
    
    NSArray *onlyCompletedExcercises = [allExcercises filteredArrayUsingPredicate:completedPredicate];
    
    return onlyCompletedExcercises;
    
    
}

-(NSString *)excercisesCompletedStringForSummary
{
    NSArray *excercises = [self excercisesInOrder];
    
    NSUInteger totalExcercises = excercises.count;
    
    NSUInteger counter = 0;
    
    for (ExcerciseSet *excerciseSet in excercises)
    {
        if (excerciseSet.isComplete)
        {
            counter ++;
        }
    }
    
    BOOL workoutCompleted = (counter == totalExcercises);
    
    if (workoutCompleted)
    {
        NSString *message = [NSString stringWithFormat:@"Complete! You got through all %lu excercises",(unsigned long)totalExcercises];
        
        return message;
    }
    else
    {
        NSString *message = [NSString stringWithFormat:@"Incomplete - you got through %lu/%lu excercises",counter, totalExcercises];
        
        return message;
    }
    
}

-(NSString *)workoutStartDayOfWeek
{
    
    NSDate *workoutDate = [NSDate dateWithTimeIntervalSince1970:self.date];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateFormat:@"EEEE"];
    
    NSString *dayOfWeek = [dateFormatter stringFromDate:workoutDate];
    
    return dayOfWeek;
    
}

-(NSString *)workoutStartDayOfMonth
{
    
    NSDate *workoutDate = [NSDate dateWithTimeIntervalSince1970:self.date];

    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateFormat:@"d"];
    
    NSString *dayOfMonth = [dateFormatter stringFromDate:workoutDate];
    
    return dayOfMonth;
    
}

-(NSString *)workoutStartMonth
{
    NSDate *workoutDate = [NSDate dateWithTimeIntervalSince1970:self.date];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateFormat:@"MMMM"];
    
    NSString *dayOfMonth = [dateFormatter stringFromDate:workoutDate];
    
    return dayOfMonth;
}

-(NSString *)longDateString
{
    
    NSString *dateString = [NSString stringWithFormat:@"%@, %@ %@",[self workoutStartDayOfWeek], [self workoutStartMonth], [self workoutStartDayOfMonth]];
    
    return dateString;
    
}
-(NSString *)workoutStartTime
{
    NSDate *startDate = [NSDate dateWithTimeIntervalSince1970:self.date];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateFormat:@"h:mm a"];
    
    NSString *workoutStartTime = [dateFormatter stringFromDate:startDate];
    
    return workoutStartTime;

}

-(NSArray *)arrayOfInfo
{
    NSArray *arrayOfInfo = @[ self.name, [self longDateString], [self workoutTimeString] ];
    
    return arrayOfInfo;
}


-(NSString *)workoutTimeString
{
    NSDate *startDate = [NSDate dateWithTimeIntervalSince1970:self.date];
    NSDate *endDate = [NSDate dateWithTimeIntervalSince1970:(self.date + self.timeInSeconds)];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateFormat:@"h:mm a"];
    
    NSString *workoutStartTime = [dateFormatter stringFromDate:startDate];
    NSString *workoutEndTime = [dateFormatter stringFromDate:endDate];
    
    NSTimeInterval workoutLength = [endDate timeIntervalSinceDate:startDate];
    
    
    NSString *difference = [self stringFromTimeInterval:workoutLength];


    NSString *combined = [NSString stringWithFormat:@"%@ - %@ (%@)",workoutStartTime,workoutEndTime,difference];
    
    return combined;
    
}

-(NSString *)stringFromTimeInterval:(NSTimeInterval)interval
{
    

    
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








@end
