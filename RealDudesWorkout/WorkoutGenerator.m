//
//  WorkoutGenerator.m
//  RealDudesWorkout
//
//  Created by Brian Clouser on 8/31/16.
//  Copyright © 2016 The Qwiz LLC. All rights reserved.
//

#import "WorkoutGenerator.h"

@implementation WorkoutGenerator

-(instancetype)init
{
    self = [super init];
    
    if (self)
    {
        _datastore = [DataStore sharedDataStore];
        _availableAcessories = [NSMutableArray new];
        _availableExercises = [NSMutableArray new];
        _availableBackExercises = [NSMutableArray new];
        _availableCoreExercises = [NSMutableArray new];
        _availableFlexExercises = [NSMutableArray new];
        _availableChestExercises = [NSMutableArray new];
        _availableLegsExercises = [NSMutableArray new];
        _availableFullBodyExercises = [NSMutableArray new];
        _backExercisesPriority1 = [NSMutableArray new];
        _backExercisesPriority2 = [NSMutableArray new];
        _chestExercisesPriority1 = [NSMutableArray new];
        _chestExercisesPriority2 = [NSMutableArray new];
        _fullBodyExercisesPriority1 = [NSMutableArray new];
        _fullBodyExercisesPriority2 = [NSMutableArray new];
        _flexExercisesPriority1 = [NSMutableArray new];
        _flexExercisesPriority2 = [NSMutableArray new];
        _coreExercisesPriority1 = [NSMutableArray new];
        _coreExercisesPriority2 = [NSMutableArray new];
        _legsExercisesPriority1 = [NSMutableArray new];
        _legsExercisesPriority2 = [NSMutableArray new];
    }
    
    return self;
}

-(Workout *)generateWorkoutWithTime:(NSInteger)time level:(NSInteger)level availableAccessories:(NSArray *)accessories
{
    self.availableExercises = [self.datastore.availableExcercises mutableCopy];
    self.availableAcessories = [accessories mutableCopy];
    [self generateAvailableExercisesWithLevel:level];
    [self generateAvailableExerciseArraysByCategory];
    
    BOOL firstWorkout = self.datastore.user.workouts.count == 0;
    
    Workout *workout = [NSEntityDescription insertNewObjectForEntityForName:@"Workout" inManagedObjectContext:self.datastore.managedObjectContext];
    
    if (firstWorkout)
    {
        workout.workoutNumber = 1;
    }
    else
    {
        Workout *lastworkout = [[self.datastore.user orderedWorkoutsLIFO] firstObject];
        
        workout.workoutNumber = lastworkout.workoutNumber + 1;
    }
    
    NSString *workoutName = [NSString stringWithFormat:@"Workout #%li",(unsigned long)workout.workoutNumber];
    workout.name = workoutName;
    workout.date = [[NSDate date] timeIntervalSince1970];
    
    workout.isFinished = NO;
    workout.isFinishedSuccessfully = NO;
    workout.timeInSeconds = 0;
    
    if (time == 10)
    {
        Circuit *circuit1 = [self generateCircuitIsTenMinuteWorkout:YES Index:1 Level:level];
        [workout addCircuitsObject:circuit1];
    }
    else if (time == 20)
    {
        Circuit *circuit1 = [self generateCircuitIsTenMinuteWorkout:NO Index:1 Level:level];
        Circuit *circuit2 = [self generateCircuitIsTenMinuteWorkout:NO Index:1 Level:level];
        [workout addCircuitsObject:circuit1];
        [workout addCircuitsObject:circuit2];
    }
    else if (time == 30)
    {
        Circuit *circuit1 = [self generateCircuitIsTenMinuteWorkout:NO Index:1 Level:level];
        Circuit *circuit2 = [self generateCircuitIsTenMinuteWorkout:NO Index:1 Level:level];
        Circuit *circuit3 = [self generateCircuitIsTenMinuteWorkout:NO Index:1 Level:level];
        [workout addCircuitsObject:circuit1];
        [workout addCircuitsObject:circuit2];
        [workout addCircuitsObject:circuit3];
    }
    else if (time == 40)
    {
        Circuit *circuit1 = [self generateCircuitIsTenMinuteWorkout:NO Index:1 Level:level];
        Circuit *circuit2 = [self generateCircuitIsTenMinuteWorkout:NO Index:2 Level:level];
        Circuit *circuit3 = [self generateCircuitIsTenMinuteWorkout:NO Index:1 Level:level];
        Circuit *circuit4 = [self generateCircuitIsTenMinuteWorkout:NO Index:2 Level:level];
        [workout addCircuitsObject:circuit1];
        [workout addCircuitsObject:circuit2];
        [workout addCircuitsObject:circuit3];
        [workout addCircuitsObject:circuit4];
    }
    else if (time == 50)
    {
        Circuit *circuit1 = [self generateCircuitIsTenMinuteWorkout:NO Index:1 Level:level];
        Circuit *circuit2 = [self generateCircuitIsTenMinuteWorkout:NO Index:2 Level:level];
        Circuit *circuit3 = [self generateCircuitIsTenMinuteWorkout:NO Index:1 Level:level];
        Circuit *circuit4 = [self generateCircuitIsTenMinuteWorkout:NO Index:2 Level:level];
        Circuit *circuit5 = [self generateCircuitIsTenMinuteWorkout:NO Index:1 Level:level];
        [workout addCircuitsObject:circuit1];
        [workout addCircuitsObject:circuit2];
        [workout addCircuitsObject:circuit3];
        [workout addCircuitsObject:circuit4];
        [workout addCircuitsObject:circuit5];
    }
    else
    {
        Circuit *circuit1 = [self generateCircuitIsTenMinuteWorkout:NO Index:1 Level:level];
        Circuit *circuit2 = [self generateCircuitIsTenMinuteWorkout:NO Index:2 Level:level];
        Circuit *circuit3 = [self generateCircuitIsTenMinuteWorkout:NO Index:1 Level:level];
        Circuit *circuit4 = [self generateCircuitIsTenMinuteWorkout:NO Index:2 Level:level];
        Circuit *circuit5 = [self generateCircuitIsTenMinuteWorkout:NO Index:1 Level:level];
        Circuit *circuit6 = [self generateCircuitIsTenMinuteWorkout:NO Index:2 Level:level];
        [workout addCircuitsObject:circuit1];
        [workout addCircuitsObject:circuit2];
        [workout addCircuitsObject:circuit3];
        [workout addCircuitsObject:circuit4];
        [workout addCircuitsObject:circuit5];
        [workout addCircuitsObject:circuit6];
    }
    
    return workout;

}

-(Circuit *)generateCircuitIsTenMinuteWorkout:(BOOL)isTenMinuteWorkout Index:(NSInteger)index Level:(NSInteger)level
{
     Circuit *circuit1 = [NSEntityDescription insertNewObjectForEntityForName:@"Circuit" inManagedObjectContext:self.datastore.managedObjectContext];
    
    Excercise *backExercise0 = self.availableBackExercises[0];
    Excercise *backExercise1 = self.availableBackExercises[1];
    Excercise *chestExercise0 = self.availableChestExercises[0];
    Excercise *chestExercise1 = self.availableChestExercises[1];
    Excercise *coreExercise0 = self.availableCoreExercises[0];
    Excercise *coreExercise1 = self.availableCoreExercises[1];
    Excercise *legsExercise0 = self.availableLegsExercises[0];
    Excercise *legsExercise1 = self.availableLegsExercises[1];
    Excercise *flexExercise0 = self.availableFlexExercises[0];
    Excercise *flexExercise1 = self.availableFlexExercises[1];
    Excercise *fullExercise0 = self.availableFullBodyExercises[0];
    Excercise *fullExercise1 = self.availableFullBodyExercises[1];
    
    if (isTenMinuteWorkout)
    {
        ExcerciseSet *set1 = [self generateExcerciseSetWithExcercise:fullExercise0 level:level isLast:NO];
        ExcerciseSet *set2 = [self generateExcerciseSetWithExcercise:backExercise0 level:level isLast:NO];
        ExcerciseSet *set3 = [self generateExcerciseSetWithExcercise:chestExercise0 level:level isLast:NO];
        ExcerciseSet *set4 = [self generateExcerciseSetWithExcercise:coreExercise0 level:level isLast:NO];
        ExcerciseSet *set5 = [self generateExcerciseSetWithExcercise:legsExercise0 level:level isLast:NO];
        ExcerciseSet *set6 = [self generateExcerciseSetWithExcercise:flexExercise0 level:level isLast:NO];
        ExcerciseSet *set7 = [self generateExcerciseSetWithExcercise:fullExercise1 level:level isLast:NO];
        set1.excerciseSetIndexNumberInCicuit = 1;
        set2.excerciseSetIndexNumberInCicuit = 2;
        set3.excerciseSetIndexNumberInCicuit = 3;
        set4.excerciseSetIndexNumberInCicuit = 4;
        set5.excerciseSetIndexNumberInCicuit = 5;
        set6.excerciseSetIndexNumberInCicuit = 6;
        set7.excerciseSetIndexNumberInCicuit = 7;
        
        [circuit1 addExcerciseSetsObject:set1];
        [circuit1 addExcerciseSetsObject:set2];
        [circuit1 addExcerciseSetsObject:set3];
        [circuit1 addExcerciseSetsObject:set4];
        [circuit1 addExcerciseSetsObject:set5];
        [circuit1 addExcerciseSetsObject:set6];
        [circuit1 addExcerciseSetsObject:set7];
        
        return circuit1;
    }
    
    else if (index == 1)
    {
        ExcerciseSet *set1 = [self generateExcerciseSetWithExcercise:backExercise0 level:level isLast:NO];
        ExcerciseSet *set2 = [self generateExcerciseSetWithExcercise:chestExercise0 level:level isLast:NO];
        ExcerciseSet *set3 = [self generateExcerciseSetWithExcercise:coreExercise0 level:level isLast:NO];
        ExcerciseSet *set4 = [self generateExcerciseSetWithExcercise:legsExercise0 level:level isLast:NO];
        ExcerciseSet *set5 = [self generateExcerciseSetWithExcercise:flexExercise0 level:level isLast:NO];
        ExcerciseSet *set6 = [self generateExcerciseSetWithExcercise:fullExercise0 level:level isLast:YES];
        set1.excerciseSetIndexNumberInCicuit = 1;
        set2.excerciseSetIndexNumberInCicuit = 2;
        set3.excerciseSetIndexNumberInCicuit = 3;
        set4.excerciseSetIndexNumberInCicuit = 4;
        set5.excerciseSetIndexNumberInCicuit = 5;
        set6.excerciseSetIndexNumberInCicuit = 6;
        
        [circuit1 addExcerciseSetsObject:set1];
        [circuit1 addExcerciseSetsObject:set2];
        [circuit1 addExcerciseSetsObject:set3];
        [circuit1 addExcerciseSetsObject:set4];
        [circuit1 addExcerciseSetsObject:set5];
        [circuit1 addExcerciseSetsObject:set6];
        
        return circuit1;
    }
    
    else
    {
        ExcerciseSet *set1 = [self generateExcerciseSetWithExcercise:backExercise1 level:level isLast:NO];
        ExcerciseSet *set2 = [self generateExcerciseSetWithExcercise:chestExercise1 level:level isLast:NO];
        ExcerciseSet *set3 = [self generateExcerciseSetWithExcercise:coreExercise1 level:level isLast:NO];
        ExcerciseSet *set4 = [self generateExcerciseSetWithExcercise:legsExercise1 level:level isLast:NO];
        ExcerciseSet *set5 = [self generateExcerciseSetWithExcercise:flexExercise1 level:level isLast:NO];
        ExcerciseSet *set6 = [self generateExcerciseSetWithExcercise:fullExercise1 level:level isLast:YES];
        set1.excerciseSetIndexNumberInCicuit = 1;
        set2.excerciseSetIndexNumberInCicuit = 2;
        set3.excerciseSetIndexNumberInCicuit = 3;
        set4.excerciseSetIndexNumberInCicuit = 4;
        set5.excerciseSetIndexNumberInCicuit = 5;
        set6.excerciseSetIndexNumberInCicuit = 6;
        
        [circuit1 addExcerciseSetsObject:set1];
        [circuit1 addExcerciseSetsObject:set2];
        [circuit1 addExcerciseSetsObject:set3];
        [circuit1 addExcerciseSetsObject:set4];
        [circuit1 addExcerciseSetsObject:set5];
        [circuit1 addExcerciseSetsObject:set6];
        
        return circuit1;
    }
}


-(ExcerciseSet *)generateExcerciseSetWithExcercise:(Excercise *)excercise level:(NSInteger)level isLast:(BOOL)isLast;
{
    DataStore *store = [DataStore sharedDataStore];
    
    ExcerciseSet *excerciseSet1 =  [NSEntityDescription insertNewObjectForEntityForName:@"ExcerciseSet" inManagedObjectContext:store.managedObjectContext];
    
    excerciseSet1.excerciseSetIndexNumberInCicuit = 0;
    excerciseSet1.isComplete = NO;
    excerciseSet1.name = @"Excercise 1";
    excerciseSet1.numberofRepsActual = 0;
    excerciseSet1.excercise = excercise;
    
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

-(void)generateAvailableExercisesWithLevel:(NSInteger)level
{
    NSMutableArray *exercisesToRemove = [NSMutableArray new];

    for (Excercise *excercise in self.availableExercises)
    {
        for (Accessory *accessory in excercise.accessories)
        {
            if (![self.availableAcessories containsObject:accessory])
            {
                [exercisesToRemove addObject:excercise];
                break;
            }
        }
        
        if (level == 1 && excercise.repsLevel1 == 0 && excercise.timeLevel1 == 0)
        {
            [exercisesToRemove addObject:excercise];
            break;
        }
        if (level == 2 && excercise.repsLevel2 == 0 && excercise.timeLevel2 == 0)
        {
            [exercisesToRemove addObject:excercise];
            break;
        }
        if (level == 3 && excercise.repsLevel3 == 0 && excercise.timeLevel3 == 0)
        {
            [exercisesToRemove addObject:excercise];
            break;
        }
    }
    
    
    for (Excercise *exercise in exercisesToRemove)
    {
        if ([self.availableExercises containsObject:exercise])
        {
            [self.availableExercises removeObject:exercise];
        }
    }
}

-(void)generateAvailableExerciseArraysByCategory
{
    NSPredicate *backExercises = [NSPredicate predicateWithFormat:@"category = %@",@"back"];
     NSPredicate *chestExercises = [NSPredicate predicateWithFormat:@"category = %@",@"chest"];
     NSPredicate *fullExercises = [NSPredicate predicateWithFormat:@"category = %@",@"full"];
     NSPredicate *legsExercises = [NSPredicate predicateWithFormat:@"category = %@",@"legs"];
     NSPredicate *flexExercises = [NSPredicate predicateWithFormat:@"category = %@",@"flex"];
     NSPredicate *coreExercises = [NSPredicate predicateWithFormat:@"category = %@",@"core"];
    
    self.availableBackExercises = [[self.availableExercises filteredArrayUsingPredicate:backExercises] mutableCopy];
    self.availableChestExercises = [[self.availableExercises filteredArrayUsingPredicate:chestExercises] mutableCopy];
    self.availableFullBodyExercises = [[self.availableExercises filteredArrayUsingPredicate:fullExercises] mutableCopy];
    self.availableLegsExercises = [[self.availableExercises filteredArrayUsingPredicate:legsExercises] mutableCopy];
    self.availableFlexExercises = [[self.availableExercises filteredArrayUsingPredicate:flexExercises] mutableCopy];
    self.availableCoreExercises = [[self.availableExercises filteredArrayUsingPredicate:coreExercises] mutableCopy];
    
    [self filterExercisesIntoPriorityBucketsFromTopLevelArray:self.availableBackExercises priority1Array:self.backExercisesPriority1 priority2Array:self.backExercisesPriority2];
    [self filterExercisesIntoPriorityBucketsFromTopLevelArray:self.availableChestExercises priority1Array:self.chestExercisesPriority1 priority2Array:self.chestExercisesPriority2];
    [self filterExercisesIntoPriorityBucketsFromTopLevelArray:self.availableLegsExercises priority1Array:self.legsExercisesPriority1 priority2Array:self.legsExercisesPriority2];
    [self filterExercisesIntoPriorityBucketsFromTopLevelArray:self.availableFullBodyExercises priority1Array:self.fullBodyExercisesPriority1 priority2Array:self.fullBodyExercisesPriority2];
    [self filterExercisesIntoPriorityBucketsFromTopLevelArray:self.availableCoreExercises priority1Array:self.coreExercisesPriority1 priority2Array:self.coreExercisesPriority2];
    [self filterExercisesIntoPriorityBucketsFromTopLevelArray:self.availableFlexExercises priority1Array:self.flexExercisesPriority1 priority2Array:self.flexExercisesPriority2];
    
}

-(void)filterExercisesIntoPriorityBucketsFromTopLevelArray:(NSMutableArray *)topLevelArray priority1Array:(NSMutableArray *)priority1Array priority2Array:(NSMutableArray *)priority2Array
{
    for (Excercise *exercise in topLevelArray)
    {
        if (exercise.isPriority)
        {
            [priority1Array addObject:exercise];
        }
        else
        {
            [priority2Array addObject:exercise];
        }
    }
    
    [topLevelArray removeAllObjects];
    
    [self shuffleArray:priority1Array];
    [self shuffleArray:priority2Array];
    
    for (Excercise *exercise in priority1Array)
    {
        [topLevelArray addObject:exercise];
    }
    
    for (Excercise *exercise in priority2Array)
    {
        [topLevelArray addObject:exercise];
    }
}

-(void)shuffleArray:(NSMutableArray *)array
{
    NSUInteger count = array.count;
    if (count < 1) return;
    for (NSUInteger i = 0; i < count - 1; ++i) {
        NSInteger remainingCount = count - i;
        NSInteger exchangeIndex = i + arc4random_uniform((u_int32_t )remainingCount);
        [array exchangeObjectAtIndex:i withObjectAtIndex:exchangeIndex];
    }
}






@end
