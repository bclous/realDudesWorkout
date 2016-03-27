//
//  Circuit.m
//  RealDudesWorkout
//
//  Created by Brian Clouser on 3/18/16.
//  Copyright © 2016 The Qwiz LLC. All rights reserved.
//

#import "Circuit.h"
#import "Workout.h"

@implementation Circuit

// Insert code here to add functionality to your managed object subclass

-(NSArray *)excerciseSetsInOrder
{
    NSArray *excerciseSetsNotInOrder = [self.excerciseSets allObjects];
    
    NSSortDescriptor *ExcerciseSetSortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"excerciseSetIndexNumberInCicuit" ascending:YES];
    
    NSArray *excerciseSetsInOrder = [excerciseSetsNotInOrder sortedArrayUsingDescriptors:@[ExcerciseSetSortDescriptor]];
    
    return excerciseSetsInOrder;
    
}

-(Circuit *)ClouserCircuit
{
    
     DataStore *store = [DataStore sharedDataStore];
    
    Circuit *circuit1 = [NSEntityDescription insertNewObjectForEntityForName:@"Circuit" inManagedObjectContext:store.managedObjectContext];
    
    circuit1.name = @"Circuit 1";
    circuit1.circuitIndexNumberInWorkout = 0;
    
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
    excerciseSet1.restTimeAfterInSecondsSuggested = 59;
    excerciseSet1.timeInSecondsActual = 0;
    excerciseSet1.timeInSecondsSuggested = 60;
    excerciseSet1.excerciseSetDescription = @"This is your first excercise, let's get after it";
    
    excerciseSet2.excerciseSetIndexNumberInCicuit = 1;
    excerciseSet2.isComplete = NO;
    excerciseSet2.name = @"Excercise 2";
    excerciseSet2.numberofRepsActual = 0;
    excerciseSet2.numberOfRepsSuggested = 10;
    excerciseSet2.restTimeAfterInSecondsActual = 0;
    excerciseSet2.restTimeAfterInSecondsSuggested = 59;
    excerciseSet2.timeInSecondsActual = 0;
    excerciseSet2.timeInSecondsSuggested = 60;
    excerciseSet2.excerciseSetDescription = @"Ok good start, now let's do this";
    
    excerciseSet3.excerciseSetIndexNumberInCicuit = 2;
    excerciseSet3.isComplete = NO;
    excerciseSet3.name = @"Excercise 3";
    excerciseSet3.numberofRepsActual = 0;
    excerciseSet3.numberOfRepsSuggested = 12;
    excerciseSet3.restTimeAfterInSecondsActual = 0;
    excerciseSet3.restTimeAfterInSecondsSuggested = 59;
    excerciseSet3.timeInSecondsActual = 0;
    excerciseSet3.timeInSecondsSuggested = 60;
    excerciseSet3.excerciseSetDescription = @"last one, get after it!";
    
    excerciseSet4.excerciseSetIndexNumberInCicuit = 3;
    excerciseSet4.isComplete = NO;
    excerciseSet4.name = @"Excercise 4";
    excerciseSet4.numberofRepsActual = 0;
    excerciseSet4.numberOfRepsSuggested = 8;
    excerciseSet4.restTimeAfterInSecondsActual = 0;
    excerciseSet4.restTimeAfterInSecondsSuggested = 59;
    excerciseSet4.timeInSecondsActual = 0;
    excerciseSet4.timeInSecondsSuggested = 60;
    excerciseSet4.excerciseSetDescription = @"This is your first excercise, let's get after it";
    
    excerciseSet5.excerciseSetIndexNumberInCicuit = 4;
    excerciseSet5.isComplete = NO;
    excerciseSet5.name = @"Excercise 5";
    excerciseSet5.numberofRepsActual = 0;
    excerciseSet5.numberOfRepsSuggested = 10;
    excerciseSet5.restTimeAfterInSecondsActual = 0;
    excerciseSet5.restTimeAfterInSecondsSuggested = 59;
    excerciseSet5.timeInSecondsActual = 0;
    excerciseSet5.timeInSecondsSuggested = 60;
    excerciseSet5.excerciseSetDescription = @"Ok good start, now let's do this";
    
    excerciseSet6.excerciseSetIndexNumberInCicuit = 5;
    excerciseSet6.isComplete = NO;
    excerciseSet6.name = @"Excercise 6";
    excerciseSet6.numberofRepsActual = 0;
    excerciseSet6.numberOfRepsSuggested = 12;
    excerciseSet6.restTimeAfterInSecondsActual = 0;
    excerciseSet6.restTimeAfterInSecondsSuggested = 59;
    excerciseSet6.timeInSecondsActual = 0;
    excerciseSet6.timeInSecondsSuggested = 60;
    excerciseSet6.excerciseSetDescription = @"last one, get after it!";
    
    excerciseSet7.excerciseSetIndexNumberInCicuit = 6;
    excerciseSet7.isComplete = NO;
    excerciseSet7.name = @"Excercise 7";
    excerciseSet7.numberofRepsActual = 0;
    excerciseSet7.numberOfRepsSuggested = 10;
    excerciseSet7.restTimeAfterInSecondsActual = 0;
    excerciseSet7.restTimeAfterInSecondsSuggested = 59;
    excerciseSet7.timeInSecondsActual = 0;
    excerciseSet7.timeInSecondsSuggested = 60;
    excerciseSet7.excerciseSetDescription = @"Ok good start, now let's do this";
    
    excerciseSet8.excerciseSetIndexNumberInCicuit = 7;
    excerciseSet8.isComplete = NO;
    excerciseSet8.name = @"Excercise 8";
    excerciseSet8.numberofRepsActual = 0;
    excerciseSet8.numberOfRepsSuggested = 12;
    excerciseSet8.restTimeAfterInSecondsActual = 0;
    excerciseSet8.restTimeAfterInSecondsSuggested = 59;
    excerciseSet8.timeInSecondsActual = 0;
    excerciseSet8.timeInSecondsSuggested = 60;
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
