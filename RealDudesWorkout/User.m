//
//  User.m
//  RealDudesWorkout
//
//  Created by Brian Clouser on 3/19/16.
//  Copyright © 2016 The Qwiz LLC. All rights reserved.
//

#import "User.h"


@implementation User

// Insert code here to add functionality to your managed object subclass

-(NSArray *)orderedWorkoutsLIFO
{
    
    NSArray *workoutsNotInOrder = [self.workouts allObjects];
    
    NSSortDescriptor *dateSortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"date"
                                                                        ascending:NO];
    
    NSArray *workoutsInOrderLIFO = [workoutsNotInOrder sortedArrayUsingDescriptors:@[dateSortDescriptor]];
    
    return workoutsInOrderLIFO;
    
}

-(NSArray *)orderedWorkoutsFIFO
{
    
    NSArray *workoutsNotInOrder = [self.workouts allObjects];
    
    NSSortDescriptor *dateSortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"date"
                                                                         ascending:YES];
    NSArray *workoutsInOrderFIFO = [workoutsNotInOrder sortedArrayUsingDescriptors:@[dateSortDescriptor]];
    
    return workoutsInOrderFIFO;
    
}

-(NSArray *)workoutsSinceMonday
{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateFormat:@"eeee"];

    NSString *dayOfWeek = [dateFormatter stringFromDate:[NSDate date]];
    
    NSUInteger numberOfDaysSinceMonday = [self numberOfDaysSinceMonday:dayOfWeek];
    
    NSUInteger secondsSinceMonday = [self numberOfSecondsInTodayPlusDays:numberOfDaysSinceMonday];
    
    NSArray *workoutsSinceMondayArray = [self workoutsSinceTimeInterval:secondsSinceMonday];
    
    return workoutsSinceMondayArray;
    
}

-(NSArray *)workoutsSinceFirstOfMonth
{
    
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateFormat:@"dd"];
    
    NSString *dayOfMonth = [dateFormatter stringFromDate:[NSDate date]];
    
    NSUInteger dayOfMonthInt = [dayOfMonth integerValue];
    
    NSUInteger secondsSinceFirstOfMonth = [self numberOfSecondsInTodayPlusDays:dayOfMonthInt - 1];
    
    NSArray *workoutsSinceTheFirstOfMonth = [self workoutsSinceTimeInterval:secondsSinceFirstOfMonth];
    
    return workoutsSinceTheFirstOfMonth;
    
}

-(NSArray *)workoutsSinceFirstOfYear
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateFormat:@"DD"];
    
    NSString *dayOfYear = [dateFormatter stringFromDate:[NSDate date]];
    
    NSUInteger dayOfYearInt = [dayOfYear integerValue];
    
    NSUInteger secondsSinceFirstOfYear = [self numberOfSecondsInTodayPlusDays:dayOfYearInt - 1];
    
    NSArray *workoutsSinceTheFirstOfYear = [self workoutsSinceTimeInterval:secondsSinceFirstOfYear];
    
    return workoutsSinceTheFirstOfYear;
    
}

-(NSArray *)workoutsLastSevenDays
{
    
    NSUInteger secondsTodayPlusLastSixDays = [self numberOfSecondsInTodayPlusDays:6];
    
    NSArray *workoutsLastSevenDays = [self workoutsSinceTimeInterval:secondsTodayPlusLastSixDays];
    
    return workoutsLastSevenDays;
}

-(NSArray *)workoutsLastThirtyDays
{
    
    NSUInteger secondsTodayPlusLast29Days = [self numberOfSecondsInTodayPlusDays:29];
    
    NSArray *workoutsLastThirtyDays = [self workoutsSinceTimeInterval:secondsTodayPlusLast29Days];
    
    return workoutsLastThirtyDays;
}

-(NSArray *)workoutsLast365Days
{
    
    NSUInteger secondsTodayPlusLast364Days = [self numberOfSecondsInTodayPlusDays:364];
    
    NSArray *workoutsLast365Days = [self workoutsSinceTimeInterval:secondsTodayPlusLast364Days];
    
    return workoutsLast365Days;
}

-(NSArray *)excerciseNameAndQuantitySortedGivenWorkouts:(NSArray *)workouts
{
    NSDictionary *dictionary = [self dictionaryOfExcercisesWithQuantityGivenWorkouts:workouts];
    
    NSArray *excerciseNamesInOrder = [self sortedArrayOfExcerciseNamesFromGivenQuantity:dictionary];
    
    NSArray *excerciseNamesAndQuantity = [self arrayOfExcercisePlusQuantityStringsFromDictionary:dictionary arrayOfNames:excerciseNamesInOrder];
    
    return excerciseNamesAndQuantity;
}

-(NSArray *)excercisePictureNamesSortedGivenWorkouts:(NSArray *)workouts
{
    
    NSDictionary *dictionary = [self dictionaryOfExcercisesWithPictureNameGivenWorkouts:workouts];
    
    NSArray *excerciseNamesInOrder = [self sortedArrayOfExcerciseNamesFromGivenQuantity:dictionary];
    
    NSArray *excercisePictureNames = [self arrayOfPictureNamesGivenDictionary:dictionary arrayOfNames:excerciseNamesInOrder];
    
    return excercisePictureNames;
    
    
}



// helper methods for workout totals

-(NSUInteger)numberOfSecondsInTodayPlusDays:(NSUInteger)days
{
    
    NSDate *rightNow = [NSDate date];
    NSTimeInterval now =  [rightNow timeIntervalSince1970];
    
    // get day of week
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateFormat:@"hh"];
    
    NSString *hours = [dateFormatter stringFromDate:[NSDate date]];
    
    [dateFormatter setDateFormat:@"mm"];
    
    NSString *minutes = [dateFormatter stringFromDate:[NSDate date]];
    
    [dateFormatter setDateFormat:@"ss"];
    
    NSString *seconds = [dateFormatter stringFromDate:[NSDate date]];
    
    NSUInteger secondsToSubtractFromTodayTime = [self secondsToSubtractGivenHour:hours minutes:minutes seconds:seconds];
    
    NSUInteger secondsFromDays = days * 60 * 60 * 24;
    
    NSUInteger secondsTotal = secondsFromDays + secondsToSubtractFromTodayTime;
    
    return secondsTotal;

}

-(NSArray *)workoutsSinceTimeInterval:(NSTimeInterval)timeInterval
{
    NSDate *rightNow = [NSDate date];
    
    NSTimeInterval now =  [rightNow timeIntervalSince1970];
    
    NSTimeInterval window = now - timeInterval;
    
    NSLog(@"%f",window);
    
    NSArray *allWorkouts = [self orderedWorkoutsLIFO];
    
    NSMutableArray *workoutsSinceInterval = [[NSMutableArray alloc] init];
    
    for (Workout *workout in allWorkouts)
    {
        if (workout.date > window)
        {
            [workoutsSinceInterval addObject:workout];
        }
    }
    
    return workoutsSinceInterval;

}


-(NSOrderedSet *)orderedSetOfWorkoutDates
{
    NSMutableOrderedSet *workoutDates = [[NSMutableOrderedSet alloc] init];
    
    NSArray *allWorkouts = [self orderedWorkoutsFIFO];
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    for (Workout *workout in allWorkouts)
    {
        NSDate *workoutDate = [NSDate dateWithTimeIntervalSince1970:workout.date];
        NSDateComponents *components = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:workoutDate];
        NSString *dateString = [NSString stringWithFormat:@"%lu%lu%lu", components.month, components.day, components.year];
        
        [workoutDates addObject:dateString];
    }
    
    return workoutDates;
}

-(NSArray *)workoutsInMonthFromDate:(NSDate *)date
{
    NSMutableArray *workoutsInMonth = [[NSMutableArray alloc] init];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *newComponents = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:date];
    
    for (Workout *workout in [self orderedWorkoutsLIFO])
    {
        NSDate *workoutDate = [NSDate dateWithTimeIntervalSince1970:workout.date];
        NSDateComponents *compareComponents = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:workoutDate];
        
        if (newComponents.year == compareComponents.year && newComponents.month == compareComponents.month)
        {
            [workoutsInMonth addObject:workout];
        }
    }
    
    return workoutsInMonth;
}

-(NSUInteger)numberOfDaysSinceMonday:(NSString *)dayOfWeek
{
    if ([dayOfWeek isEqualToString:@"Monday"])
    {
        return 0;
    }
    else if ([dayOfWeek isEqualToString:@"Tuesday"])
    {
        return 1;
    }
    else if ([dayOfWeek isEqualToString:@"Wednesday"])
    {
        return 2;
    }
    else if ([dayOfWeek isEqualToString:@"Thursday"])
    {
        return 3;
    }
    else if ([dayOfWeek isEqualToString:@"Friday"])
    {
        return 4;
    }
    else if ([dayOfWeek isEqualToString:@"Saturday"])
    {
        return 5;
    }
    else if ([dayOfWeek isEqualToString:@"Sunday"])
    {
        return 6;
    }
    else
    {
        return 0;
    }
}

-(NSTimeInterval)secondsToSubtractGivenHour:(NSString *)hour minutes:(NSString *)minutes seconds:(NSString *)seconds
{
    NSUInteger hoursInSeconds = [hour integerValue]*60*60;
    NSUInteger minutesInSeconds = [minutes integerValue]*60;
    NSUInteger secondsInSeconds = [seconds integerValue];
    
    return hoursInSeconds + minutesInSeconds + secondsInSeconds;
    
}


-(NSDictionary *)dictionaryOfExcercisesWithQuantityGivenWorkouts:(NSArray *)workouts
{
    
    NSMutableDictionary *excercisesWithQuantities = [[NSMutableDictionary alloc] init];
    
    
    for (Workout *individualWorkout in workouts)
    {
        NSArray *excercisesInOrder = [individualWorkout excercisesInOrder];
                                      
        for (ExcerciseSet *excerciseSet in excercisesInOrder)
        {
            NSString *excerciseName = excerciseSet.excercise.name;
            
            BOOL dictionaryHasExcercise = [[excercisesWithQuantities allKeys] containsObject:excerciseName];
            
            if (dictionaryHasExcercise)
            {
                NSInteger oldQuantity = [excercisesWithQuantities[excerciseName] integerValue];
                
                NSInteger newValue = oldQuantity + excerciseSet.numberofRepsActual;
                
                excercisesWithQuantities[excerciseName] = [NSNumber numberWithInt:newValue];
            }
            else
            {
                NSNumber *quantity = [NSNumber numberWithInt:excerciseSet.numberofRepsActual];
                
                [excercisesWithQuantities setObject:quantity forKey:excerciseName];
                
    
            }
        }
    }
    
    return excercisesWithQuantities;

}

-(NSDictionary *)dictionaryOfExcercisesWithPictureNameGivenWorkouts:(NSArray *)workouts
{
    
    NSMutableDictionary *excercisesWithQuantities = [[NSMutableDictionary alloc] init];
    
    
    for (Workout *individualWorkout in workouts)
    {
        NSArray *excercisesInOrder = [individualWorkout excercisesInOrder];
        
        for (ExcerciseSet *excerciseSet in excercisesInOrder)
        {
            NSString *excerciseName = excerciseSet.excercise.name;
            
            BOOL dictionaryHasExcercise = [[excercisesWithQuantities allKeys] containsObject:excerciseName];
            
            if (!dictionaryHasExcercise)
            {
                
                [excercisesWithQuantities setObject:excerciseSet.excercise.pictureName forKey:excerciseName];
            }

        }
    }
    
    return excercisesWithQuantities;
    
}

-(NSArray *)sortedArrayOfExcerciseNamesFromGivenQuantity:(NSDictionary *)dictionary
{
    
    NSArray *sortedArray  = [dictionary keysSortedByValueUsingComparator:^NSComparisonResult(id obj1, id  _Nonnull obj2) {
        
    return [[dictionary objectForKey:obj1] compare:[dictionary objectForKey:obj2]];
        
    }];
    
    
    return sortedArray;
    
    
}

-(NSArray *)arrayOfPictureNamesGivenDictionary:(NSDictionary *)dictionary arrayOfNames:(NSArray *)arrayOfNames
{
    
    NSMutableArray *arrayOfPicNames = [[NSMutableArray alloc] init];
    
    for (NSString *excerciseName in arrayOfNames)
    {
        [arrayOfPicNames addObject:dictionary[excerciseName]];
    }
    
    return arrayOfPicNames;
    
}

-(NSArray *)arrayOfExcercisePlusQuantityStringsFromDictionary:(NSDictionary *)dictionary arrayOfNames:(NSArray *)arrayOfNames
{
    
    NSMutableArray *arrayOfQuantityAndNames = [[NSMutableArray alloc] init];
    
    for (NSString *excerciseName in arrayOfNames)
    {
        NSString *quantityAndName = [NSString stringWithFormat:@"%@ %@",dictionary[excerciseName], excerciseName];
        
        [arrayOfQuantityAndNames addObject:quantityAndName];
    }
    
    return arrayOfQuantityAndNames;
    
}

-(Workout *)generateWorkoutWithTime:(NSInteger)time level:(NSInteger)level availableAccessories:(NSArray *)accessories
{
    
    return nil;
}

-(Circuit *)generateCircuitWithTime:(NSInteger)time level:(NSInteger)level availableExercises:(NSArray *)exercises availableAccessories:(NSArray *)accessories
{
    return nil;
}

-(ExcerciseSet *)generateExcerciseSetWithExcercise:(Excercise *)excercise level:(NSInteger)level isLast:(BOOL)isLast;
{
    DataStore *store = [DataStore sharedDataStore];
    
    ExcerciseSet *excerciseSet1 =  [NSEntityDescription insertNewObjectForEntityForName:@"ExcerciseSet" inManagedObjectContext:store.managedObjectContext];
    
    excerciseSet1.excerciseSetIndexNumberInCicuit = 0;
    excerciseSet1.isComplete = NO;
    excerciseSet1.name = @"Excercise 1";
    excerciseSet1.numberofRepsActual = 0;
    
    if(excercise.isReps)
    {
        excerciseSet1.timeInSecondsSuggested = 0;
        if (level == 1)
        {
            excerciseSet1.numberOfRepsSuggested = excercise.repsLevel1;
        }
        else if (level == 2)
        {
            excerciseSet1.numberOfRepsSuggested = excercise.repsLevel2;
        }
        else
        {
             excerciseSet1.numberOfRepsSuggested = excercise.repsLevel3;
        }
    }
    else
    {
        excerciseSet1.numberOfRepsSuggested = 0;
        
        if (level == 1)
        {
            excerciseSet1.timeInSecondsSuggested = excercise.timeLevel1;
        }
        else if (level == 2)
        {
            excerciseSet1.timeInSecondsSuggested = excercise.timeLevel2;
        }
        else
        {
            excerciseSet1.timeInSecondsSuggested = excercise.timeLevel3;
        }
    }
    
    excerciseSet1.restTimeAfterInSecondsActual = 0;
    excerciseSet1.restTimeAfterInSecondsSuggested = isLast ? 90 : 30;
    excerciseSet1.timeInSecondsActual = 0;
  
    return excerciseSet1;
}



-(NSArray *)availableExercisesFromCategory:(NSString *)category availableAccessories:(NSArray *)accessories
{
    DataStore *dataStore = [DataStore sharedDataStore];
    
    NSPredicate *exercisesInCategory = [NSPredicate predicateWithFormat:@"category = %@",category];
    
    NSArray *excerciseArray = [dataStore.availableExcercises filteredArrayUsingPredicate:exercisesInCategory];
    NSMutableArray *excerciseMutable = [excerciseArray mutableCopy];
    
    for (Excercise *excercise in excerciseMutable)
    {
        for (Accessory *accessory in excercise.accessories)
        {
            if (![accessories containsObject:accessory])
            {
                [excerciseMutable removeObject:excercise];
                break;
            }
        }
    }
    
    return excerciseMutable;
}


#pragma generating workouts space

-(Workout *)generateNewWorkout
{
   
    DataStore *store = [DataStore sharedDataStore];
    
    // create workout
    
    BOOL firstWorkout = self.workouts.count == 0;
    
    Workout *workout = [NSEntityDescription insertNewObjectForEntityForName:@"Workout" inManagedObjectContext:store.managedObjectContext];
    
    
    if (firstWorkout)
    {
        workout.workoutNumber = 1;
    }
    else
    {
        Workout *lastworkout = [[self orderedWorkoutsLIFO] firstObject];
        
        workout.workoutNumber = lastworkout.workoutNumber + 1;
    }

    
    NSString *workoutName = [NSString stringWithFormat:@"Workout #%li",(unsigned long)workout.workoutNumber];
    
    workout.name = workoutName;
    
    workout.date = [[NSDate date] timeIntervalSince1970];
    
    workout.isFinished = NO;
    workout.isFinishedSuccessfully = NO;
    workout.timeInSeconds = 0;
    
    Circuit *circuit0 = [self clouserCircuitWithIndexNumber:0];
    Circuit *circuit1 = [self clouserCircuitWithIndexNumber:1];
    Circuit *circuit2 = [self clouserCircuitWithIndexNumber:2];
    
    
    
    // add circuit to workout
    [workout addCircuitsObject:circuit0];
    [workout addCircuitsObject:circuit1];
    [workout addCircuitsObject:circuit2];
    
    // add workout to user
    [self addWorkoutsObject:workout];
    
    [store fetchData];
    
    return workout;
    

}

-(Circuit *)clouserCircuitWithIndexNumber:(NSUInteger)indexNumber
{
        DataStore *store = [DataStore sharedDataStore];
    
        // create circuits
    
        Circuit *circuit1 = [NSEntityDescription insertNewObjectForEntityForName:@"Circuit" inManagedObjectContext:store.managedObjectContext];
    
        circuit1.name = @"Circuit 1";
        circuit1.circuitIndexNumberInWorkout = indexNumber;
    
        // create excercise sets
    
        ExcerciseSet *excerciseSet1 =  [NSEntityDescription insertNewObjectForEntityForName:@"ExcerciseSet" inManagedObjectContext:store.managedObjectContext];
        ExcerciseSet *excerciseSet2 = [NSEntityDescription insertNewObjectForEntityForName:@"ExcerciseSet" inManagedObjectContext:store.managedObjectContext];
        ExcerciseSet *excerciseSet3 = [NSEntityDescription insertNewObjectForEntityForName:@"ExcerciseSet" inManagedObjectContext:store.managedObjectContext];
        ExcerciseSet *excerciseSet4 =  [NSEntityDescription insertNewObjectForEntityForName:@"ExcerciseSet" inManagedObjectContext:store.managedObjectContext];
        ExcerciseSet *excerciseSet5 = [NSEntityDescription insertNewObjectForEntityForName:@"ExcerciseSet" inManagedObjectContext:store.managedObjectContext];
        ExcerciseSet *excerciseSet6 = [NSEntityDescription insertNewObjectForEntityForName:@"ExcerciseSet" inManagedObjectContext:store.managedObjectContext];
        ExcerciseSet *excerciseSet7 =  [NSEntityDescription insertNewObjectForEntityForName:@"ExcerciseSet" inManagedObjectContext:store.managedObjectContext];
        ExcerciseSet *excerciseSet8 = [NSEntityDescription insertNewObjectForEntityForName:@"ExcerciseSet" inManagedObjectContext:store.managedObjectContext];
    
    
        excerciseSet1.excerciseSetIndexNumberInCicuit = 0;
        excerciseSet1.isComplete = NO;
        excerciseSet1.name = @"Excercise 1";
        excerciseSet1.numberofRepsActual = 0;
        excerciseSet1.numberOfRepsSuggested = 8;
        excerciseSet1.restTimeAfterInSecondsActual = 0;
        excerciseSet1.restTimeAfterInSecondsSuggested = 30;
        excerciseSet1.timeInSecondsActual = 0;
        excerciseSet1.timeInSecondsSuggested = 60;
        excerciseSet1.excerciseSetDescription = @"This is your first excercise, let's get after it";
    
        excerciseSet2.excerciseSetIndexNumberInCicuit = 1;
        excerciseSet2.isComplete = NO;
        excerciseSet2.name = @"Excercise 2";
        excerciseSet2.numberofRepsActual = 0;
        excerciseSet2.numberOfRepsSuggested = 10;
        excerciseSet2.restTimeAfterInSecondsActual = 0;
        excerciseSet2.restTimeAfterInSecondsSuggested = 45;
        excerciseSet2.timeInSecondsActual = 0;
        excerciseSet2.timeInSecondsSuggested = 60;
        excerciseSet2.excerciseSetDescription = @"Ok good start, now let's do this";
    
        excerciseSet3.excerciseSetIndexNumberInCicuit = 2;
        excerciseSet3.isComplete = NO;
        excerciseSet3.name = @"Excercise 3";
        excerciseSet3.numberofRepsActual = 0;
        excerciseSet3.numberOfRepsSuggested = 12;
        excerciseSet3.restTimeAfterInSecondsActual = 0;
        excerciseSet3.restTimeAfterInSecondsSuggested = 30;
        excerciseSet3.timeInSecondsActual = 0;
        excerciseSet3.timeInSecondsSuggested = 60;
        excerciseSet3.excerciseSetDescription = @"last one, get after it!";
    
        excerciseSet4.excerciseSetIndexNumberInCicuit = 3;
        excerciseSet4.isComplete = NO;
        excerciseSet4.name = @"Excercise 4";
        excerciseSet4.numberofRepsActual = 0;
        excerciseSet4.numberOfRepsSuggested = 50;
        excerciseSet4.restTimeAfterInSecondsActual = 0;
        excerciseSet4.restTimeAfterInSecondsSuggested = 30;
        excerciseSet4.timeInSecondsActual = 0;
        excerciseSet4.timeInSecondsSuggested = 60;
        excerciseSet4.excerciseSetDescription = @"This is your first excercise, let's get after it";
    
        excerciseSet5.excerciseSetIndexNumberInCicuit = 4;
        excerciseSet5.isComplete = NO;
        excerciseSet5.name = @"Excercise 5";
        excerciseSet5.numberofRepsActual = 0;
        excerciseSet5.numberOfRepsSuggested = 12;
        excerciseSet5.restTimeAfterInSecondsActual = 0;
        excerciseSet5.restTimeAfterInSecondsSuggested = 30;
        excerciseSet5.timeInSecondsActual = 0;
        excerciseSet5.timeInSecondsSuggested = 60;
        excerciseSet5.excerciseSetDescription = @"Ok good start, now let's do this";
    
        excerciseSet6.excerciseSetIndexNumberInCicuit = 5;
        excerciseSet6.isComplete = NO;
        excerciseSet6.name = @"Excercise 6";
        excerciseSet6.numberofRepsActual = 0;
        excerciseSet6.numberOfRepsSuggested = 10;
        excerciseSet6.restTimeAfterInSecondsActual = 0;
        excerciseSet6.restTimeAfterInSecondsSuggested = 30;
        excerciseSet6.timeInSecondsActual = 0;
        excerciseSet6.timeInSecondsSuggested = 60;
        excerciseSet6.excerciseSetDescription = @"last one, get after it!";
    
        excerciseSet7.excerciseSetIndexNumberInCicuit = 6;
        excerciseSet7.isComplete = NO;
        excerciseSet7.name = @"Excercise 7";
        excerciseSet7.numberofRepsActual = 0;
        excerciseSet7.numberOfRepsSuggested = 10;
        excerciseSet7.restTimeAfterInSecondsActual = 0;
        excerciseSet7.restTimeAfterInSecondsSuggested = 30;
        excerciseSet7.timeInSecondsActual = 0;
        excerciseSet7.timeInSecondsSuggested = 60;
        excerciseSet7.excerciseSetDescription = @"Ok good start, now let's do this";
    
        excerciseSet8.excerciseSetIndexNumberInCicuit = 7;
        excerciseSet8.isComplete = NO;
        excerciseSet8.name = @"Excercise 8";
        excerciseSet8.numberofRepsActual = 0;
        excerciseSet8.numberOfRepsSuggested = 20;
        excerciseSet8.restTimeAfterInSecondsActual = 0;
        excerciseSet8.restTimeAfterInSecondsSuggested = 180;
        excerciseSet8.timeInSecondsActual = 0;
        excerciseSet8.timeInSecondsSuggested = 150;
        excerciseSet8.excerciseSetDescription = @"last one, get after it!";
    
        // add excercise to excercise set
        excerciseSet1.excercise = [self excerciseGivenName:@"Pullups"];
        excerciseSet2.excercise = [self excerciseGivenName:@"Crawl down pushups"];
        excerciseSet3.excercise = [self excerciseGivenName:@"Squats with dumbbell"];
        excerciseSet4.excercise = [self excerciseGivenName:@"Leg kicks"];
        excerciseSet5.excercise = [self excerciseGivenName:@"Lower back extensions"];
        excerciseSet6.excercise = [self excerciseGivenName:@"Dips"];
        excerciseSet7.excercise = [self excerciseGivenName:@"Bicep curls"];
        excerciseSet8.excercise = [self excerciseGivenName:@"Lunges with weight"];
    
        // add excercise set to circuit
        [circuit1 addExcerciseSetsObject:excerciseSet1];
        [circuit1 addExcerciseSetsObject:excerciseSet2];
        [circuit1 addExcerciseSetsObject:excerciseSet3];
        [circuit1 addExcerciseSetsObject:excerciseSet4];
        [circuit1 addExcerciseSetsObject:excerciseSet5];
        [circuit1 addExcerciseSetsObject:excerciseSet6];
        [circuit1 addExcerciseSetsObject:excerciseSet7];
        [circuit1 addExcerciseSetsObject:excerciseSet8];
    
    return circuit1;
}


-(Excercise *)excerciseGivenName:(NSString *)excerciseName
{
    DataStore *dataStore = [DataStore sharedDataStore];
    
    NSPredicate *givenExcerciseNamePredicate = [NSPredicate predicateWithFormat:@"name = %@",excerciseName];
    
    NSArray *excerciseArray = [dataStore.availableExcercises filteredArrayUsingPredicate:givenExcerciseNamePredicate];
    
    Excercise *excercise = excerciseArray[0];
    
    return excercise;
}









@end
