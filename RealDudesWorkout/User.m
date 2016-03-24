//
//  User.m
//  RealDudesWorkout
//
//  Created by Brian Clouser on 3/19/16.
//  Copyright © 2016 The Qwiz LLC. All rights reserved.
//

#import "User.h"
#import "Workout.h"

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

-(Workout *)generateNewWorkout
{
    NSLog(@"in the create new workout standard method");
    
    DataStore *store = [DataStore sharedDataStore];
    
    // create workout
    
    Workout *workout = [NSEntityDescription insertNewObjectForEntityForName:@"Workout" inManagedObjectContext:store.managedObjectContext];
    
    NSUInteger workoutNumber = self.workouts.count +1;
    
    NSString *workoutName = [NSString stringWithFormat:@"Workout #%li",(unsigned long)workoutNumber];
    
    workout.name = workoutName;
    
    workout.date = [[NSDate date] timeIntervalSince1970];
    
    workout.isFinished = NO;
    workout.isFinishedSuccessfully = NO;
    workout.timeInSeconds = 0;
    
    // create circuits
    
    Circuit *circuit1 = [NSEntityDescription insertNewObjectForEntityForName:@"Circuit" inManagedObjectContext:store.managedObjectContext];
    
    circuit1.name = @"Circuit 1";
    circuit1.circuitIndexNumberInWorkout = 0;
    
    // create excercise sets
    
    ExcerciseSet *excerciseSet1 =  [NSEntityDescription insertNewObjectForEntityForName:@"ExcerciseSet" inManagedObjectContext:store.managedObjectContext];
    
    ExcerciseSet *excerciseSet2 = [NSEntityDescription insertNewObjectForEntityForName:@"ExcerciseSet" inManagedObjectContext:store.managedObjectContext];
    
    ExcerciseSet *excerciseSet3 = [NSEntityDescription insertNewObjectForEntityForName:@"ExcerciseSet" inManagedObjectContext:store.managedObjectContext];
    
    excerciseSet1.excerciseSetIndexNumberInCicuit = 0;
    excerciseSet1.isComplete = NO;
    excerciseSet1.name = @"Excercise 1";
    excerciseSet1.numberofRepsActual = 0;
    excerciseSet1.numberOfRepsSuggested = 50;
    excerciseSet1.restTimeAfterInSecondsActual = 0;
    excerciseSet1.restTimeAfterInSecondsSuggested = 59;
    excerciseSet1.timeInSecondsActual = 0;
    excerciseSet1.timeInSecondsSuggested = 60;
    excerciseSet1.excerciseSetDescription = @"This is your first excercise, let's get after it";
    
    excerciseSet2.excerciseSetIndexNumberInCicuit = 1;
    excerciseSet2.isComplete = NO;
    excerciseSet2.name = @"Excercise 2";
    excerciseSet2.numberofRepsActual = 0;
    excerciseSet2.numberOfRepsSuggested = 8;
    excerciseSet2.restTimeAfterInSecondsActual = 0;
    excerciseSet2.restTimeAfterInSecondsSuggested = 59;
    excerciseSet2.timeInSecondsActual = 0;
    excerciseSet2.timeInSecondsSuggested = 60;
    excerciseSet2.excerciseSetDescription = @"Ok good start, now let's do this";
    
    excerciseSet3.excerciseSetIndexNumberInCicuit = 2;
    excerciseSet3.isComplete = NO;
    excerciseSet3.name = @"Excercise 3";
    excerciseSet3.numberofRepsActual = 0;
    excerciseSet3.numberOfRepsSuggested = 20;
    excerciseSet3.restTimeAfterInSecondsActual = 0;
    excerciseSet3.restTimeAfterInSecondsSuggested = 59;
    excerciseSet3.timeInSecondsActual = 0;
    excerciseSet3.timeInSecondsSuggested = 60;
    excerciseSet3.excerciseSetDescription = @"last one, get after it!";
    
    // add excercise to excercise set
    excerciseSet1.excercise = store.availableExcercises[1];
    excerciseSet2.excercise = store.availableExcercises[2];
    excerciseSet3.excercise = store.availableExcercises[3];
    
    // add excercise set to circuit
    [circuit1 addExcerciseSetsObject:excerciseSet1];
    [circuit1 addExcerciseSetsObject:excerciseSet2];
    [circuit1 addExcerciseSetsObject:excerciseSet3];
    
    // add circuit to workout
    [workout addCircuitsObject:circuit1];
    
    // add workout to user
    [self addWorkoutsObject:workout];
    
    [store fetchData];
    
    return workout;
    

}



@end
