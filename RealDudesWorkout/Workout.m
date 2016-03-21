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
    
    [dateFormatter setDateFormat:@"dd"];
    
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

//-(NSArray *)arrayOfCompletedExcercises
//{
//    
//    NSArray *excercices = [self.excercises allObjects];
//    
//    NSMutableArray *completedExcercises = [[NSMutableArray alloc] init];
//    
//    for (Excercise *excercise in excercices)
//    {
//        if (excercise.isComplete)
//        {
//            [completedExcercises addObject:excercise];
//        }
//    }
//    
//    return completedExcercises;
//}
//
//-(NSString *)stringCompletedExcercies
//{
//    NSArray *excercises = [self.excercises allObjects];
//    
//    NSUInteger totalExcercies = excercises.count;
//    
//    NSUInteger completedExcercises = 0;
//    
//    for (Excercise *excercise in excercises)
//    {
//        if (excercise.isComplete)
//        {
//            completedExcercises ++;
//        }
//    }
//    
//    BOOL workoutComplete = (totalExcercies == completedExcercises);
//    
//    if (workoutComplete)
//    {
//        return [NSString stringWithFormat:@"Completed all %lu excercices",totalExcercies];
//    }
//    else
//    {
//        return [NSString stringWithFormat:@"Completed %lu/%lu excercices",completedExcercises,totalExcercies];
//    }
//}

-(Workout *)generateWorkout
{
    NSLog(@"in the create new workout standard method");
    
    dataStore *store = [dataStore sharedDataStore];
    
    User *user = store.user;
    
    // create workout
    
    Workout *workout = [NSEntityDescription insertNewObjectForEntityForName:@"Workout" inManagedObjectContext:store.managedObjectContext];
    
    NSUInteger workoutNumber = store.user.workouts.count +1;
    
    NSString *workoutName = [NSString stringWithFormat:@"Workout #%li",(unsigned long)workoutNumber];
    
    workout.date = [[NSDate date] timeIntervalSince1970];
    
    workout.isFinished = NO;
    workout.isFinishedSuccessfully = NO;
    workout.timeInSeconds = 0;
    
    // create circuits
    
    Circuit *circuit1 = [NSEntityDescription insertNewObjectForEntityForName:@"Cicuit" inManagedObjectContext:store.managedObjectContext];
    
    circuit1.name = @"Circuit 1";
    circuit1.circuitIndexNumberInWorkout = 0;
    
    // create excercise sets
    
    ExcerciseSet *excerciseSet1 =  [NSEntityDescription insertNewObjectForEntityForName:@"Excercise Set" inManagedObjectContext:store.managedObjectContext];
    
    excerciseSet1.excerciseSetIndexNumberInCicuit = 0;
    excerciseSet1.isComplete = NO;
    excerciseSet1.name = @"Excercise 1";
    excerciseSet1.numberofRepsActual = 0;
    excerciseSet1.numberOfRepsSuggested = 8;
    excerciseSet1.restTimeAfterInSecondsActual = 0;
    excerciseSet1.restTimeAfterInSecondsSuggested = 59;
    excerciseSet1.timeInSecondsActual = 0;
    excerciseSet1.timeInSecondsSuggested = 60;
    excerciseSet1.excerciseSetDescription = @"This is your first excercise, let's get after it";
    
    // add excercise to excercise set
    excerciseSet1.excercise = store.availableExcercises[0];
    
    // add excercise set to circuit
    [circuit1 addExcerciseSetsObject:excerciseSet1];
    
    // add circuit to workout
    [workout addCircuitsObject:circuit1];
    
    // add workout to user
    [user addWorkoutsObject:workout];
    
    [store fetchData];
    
    return workout;
    
    
    

}






@end
