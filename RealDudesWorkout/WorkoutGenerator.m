//
//  WorkoutGenerator.m
//  RealDudesWorkout
//
//  Created by Brian Clouser on 3/13/16.
//  Copyright © 2016 The Qwiz LLC. All rights reserved.
//

#import "WorkoutGenerator.h"
#import "dataStore.h"


@implementation WorkoutGenerator

-(Workout *)createNewWorkoutStandard
{
    NSLog(@"in the create new workout standard method");
    
    self.dataStore = [dataStore sharedDataStore];
    
    Workout *workout = [NSEntityDescription insertNewObjectForEntityForName:@"Workout" inManagedObjectContext:self.dataStore.managedObjectContext];
    
    NSUInteger workoutNumber = self.dataStore.workouts.count + 1;
    
    NSString *workoutName = [NSString stringWithFormat:@"Workout #%li",(unsigned long)workoutNumber];
    
    workout.name = workoutName;
    
    Accessory *pullUpBar = [NSEntityDescription insertNewObjectForEntityForName:@"Accessory" inManagedObjectContext:self.dataStore.managedObjectContext];
    Accessory *dumbellThirtyFivePounds = [NSEntityDescription insertNewObjectForEntityForName:@"Accessory" inManagedObjectContext:self.dataStore.managedObjectContext];
    Accessory *lowerBackStructure = [NSEntityDescription insertNewObjectForEntityForName:@"Accessory" inManagedObjectContext:self.dataStore.managedObjectContext];
    Accessory *dipBar = [NSEntityDescription insertNewObjectForEntityForName:@"Accessory" inManagedObjectContext:self.dataStore.managedObjectContext];
    Accessory *bench = [NSEntityDescription insertNewObjectForEntityForName:@"Accessory" inManagedObjectContext:self.dataStore.managedObjectContext];
    
    pullUpBar.name = @"Pullup bar";
    pullUpBar.pictureName = @"pullUpBar";
    dumbellThirtyFivePounds.name = @"35 pound dumbbell";
    dumbellThirtyFivePounds.pictureName = @"dumbell";
    lowerBackStructure.name = @"Lower Back Extension Machine";
    lowerBackStructure.pictureName = @"lowerBackExtensionStructure";
    dipBar.name = @"Dip Bar";
    dipBar.pictureName = @"dipsBar";
    bench.name = @"Bench";
    bench.pictureName = @"bench";
    
    
    Excercise *excercise1 = [NSEntityDescription insertNewObjectForEntityForName:@"Excercise" inManagedObjectContext:self.dataStore.managedObjectContext];
    Excercise *excercise2 = [NSEntityDescription insertNewObjectForEntityForName:@"Excercise" inManagedObjectContext:self.dataStore.managedObjectContext];
    Excercise *excercise3 = [NSEntityDescription insertNewObjectForEntityForName:@"Excercise" inManagedObjectContext:self.dataStore.managedObjectContext];
    Excercise *excercise4 = [NSEntityDescription insertNewObjectForEntityForName:@"Excercise" inManagedObjectContext:self.dataStore.managedObjectContext];
    Excercise *excercise5 = [NSEntityDescription insertNewObjectForEntityForName:@"Excercise" inManagedObjectContext:self.dataStore.managedObjectContext];
    Excercise *excercise6 = [NSEntityDescription insertNewObjectForEntityForName:@"Excercise" inManagedObjectContext:self.dataStore.managedObjectContext];
    Excercise *excercise7 = [NSEntityDescription insertNewObjectForEntityForName:@"Excercise" inManagedObjectContext:self.dataStore.managedObjectContext];
    Excercise *excercise8 = [NSEntityDescription insertNewObjectForEntityForName:@"Excercise" inManagedObjectContext:self.dataStore.managedObjectContext];
    Excercise *excercise9 = [NSEntityDescription insertNewObjectForEntityForName:@"Excercise" inManagedObjectContext:self.dataStore.managedObjectContext];
    Excercise *excercise10 = [NSEntityDescription insertNewObjectForEntityForName:@"Excercise" inManagedObjectContext:self.dataStore.managedObjectContext];
    Excercise *excercise11 = [NSEntityDescription insertNewObjectForEntityForName:@"Excercise" inManagedObjectContext:self.dataStore.managedObjectContext];
    Excercise *excercise12 = [NSEntityDescription insertNewObjectForEntityForName:@"Excercise" inManagedObjectContext:self.dataStore.managedObjectContext];
    Excercise *excercise13 = [NSEntityDescription insertNewObjectForEntityForName:@"Excercise" inManagedObjectContext:self.dataStore.managedObjectContext];
    Excercise *excercise14 = [NSEntityDescription insertNewObjectForEntityForName:@"Excercise" inManagedObjectContext:self.dataStore.managedObjectContext];
    Excercise *excercise15 = [NSEntityDescription insertNewObjectForEntityForName:@"Excercise" inManagedObjectContext:self.dataStore.managedObjectContext];
    
    excercise1.indexInWorkoutNumber = 0;
    excercise1.uniqueIdentifier = [NSString stringWithFormat:@"Workout %lu, excercise %lld",workoutNumber, excercise1.indexInWorkoutNumber];
    excercise1.name = @"Pullups";
    excercise1.excerciseDescription = @"This is the description for pull ups";
    excercise1.category = @"back";
    excercise1.numberOfRepsSuggested = 8;
    excercise1.numberOfRepsActual = 0;
    excercise1.timeInSecondsSuggested = 45;
    excercise1.timeInSecondsActual = 0;
    excercise1.pictureName = @"pullUp";
    [excercise1 addAccessoriesObject:pullUpBar];
    
    
    excercise2.indexInWorkoutNumber = 1;
    excercise2.uniqueIdentifier = [NSString stringWithFormat:@"Workout %u, excercise %lld",workoutNumber, excercise2.indexInWorkoutNumber];
    excercise2.name = @"Rest";
    excercise2.excerciseDescription = @"This is the description for Resting!";
    excercise2.category = @"rest";
    excercise2.numberOfRepsSuggested = 0;
    excercise2.numberOfRepsActual = 0;
    excercise2.timeInSecondsSuggested = 45;
    excercise2.timeInSecondsActual = 0;
    excercise2.pictureName = @"rest";
    
    excercise3.indexInWorkoutNumber = 2;
    excercise3.uniqueIdentifier = [NSString stringWithFormat:@"Workout %u, excercise %lld",workoutNumber, excercise3.indexInWorkoutNumber];
    excercise3.name = @"Crawl Down Pushups";
    excercise3.excerciseDescription = @"This is the description for Crawl Down Pushups";
    excercise3.category = @"chest";
    excercise3.numberOfRepsSuggested = 10;
    excercise3.numberOfRepsActual = 0;
    excercise3.timeInSecondsSuggested = 90;
    excercise3.timeInSecondsActual = 0;
    excercise3.pictureName = @"crawlDownPushups";
    
    excercise4.indexInWorkoutNumber = 3;
    excercise4.uniqueIdentifier = [NSString stringWithFormat:@"Workout %u, excercise %lld",workoutNumber, excercise4.indexInWorkoutNumber];
    excercise4.name = @"Rest";
    excercise4.excerciseDescription = @"This is the description for Rest";
    excercise4.category = @"rest";
    excercise4.numberOfRepsSuggested = 0;
    excercise4.numberOfRepsActual = 0;
    excercise4.timeInSecondsSuggested = 60;
    excercise4.timeInSecondsActual = 0;
    excercise4.pictureName = @"rest";
    
    excercise5.indexInWorkoutNumber = 4;
    excercise5.uniqueIdentifier = [NSString stringWithFormat:@"Workout %u, excercise %lld",workoutNumber, excercise5.indexInWorkoutNumber];
    excercise5.name = @"Squats";
    excercise5.excerciseDescription = @"This is the description for Squats";
    excercise5.category = @"legs";
    excercise5.numberOfRepsSuggested = 10;
    excercise5.numberOfRepsActual = 0;
    excercise5.timeInSecondsSuggested = 45;
    excercise5.timeInSecondsActual = 0;
    excercise5.pictureName = @"squat";
    [excercise5 addAccessoriesObject:dumbellThirtyFivePounds];
    
    excercise6.indexInWorkoutNumber = 5;
    excercise6.uniqueIdentifier = [NSString stringWithFormat:@"Workout %u, excercise %lld",workoutNumber, excercise6.indexInWorkoutNumber];
    excercise6.name = @"Rest";
    excercise6.excerciseDescription = @"This is the description for Rest";
    excercise6.category = @"rest";
    excercise6.numberOfRepsSuggested = 0;
    excercise6.numberOfRepsActual = 0;
    excercise6.timeInSecondsSuggested = 60;
    excercise6.timeInSecondsActual = 0;
    excercise6.pictureName = @"rest";
    
    excercise7.indexInWorkoutNumber = 6;
    excercise7.uniqueIdentifier = [NSString stringWithFormat:@"Workout %u, excercise %lld",workoutNumber, excercise7.indexInWorkoutNumber];
    excercise7.name = @"Leg Kicks";
    excercise7.excerciseDescription = @"This is the description for Leg Kicks";
    excercise7.category = @"core";
    excercise7.numberOfRepsSuggested = 50;
    excercise7.numberOfRepsActual = 0;
    excercise7.timeInSecondsSuggested = 45;
    excercise7.timeInSecondsActual = 0;
    excercise7.pictureName = @"legKicks";
    
    excercise8.indexInWorkoutNumber = 7;
    excercise8.uniqueIdentifier = [NSString stringWithFormat:@"Workout %u, excercise %lld",workoutNumber, excercise8.indexInWorkoutNumber];
    excercise8.name = @"Rest";
    excercise8.excerciseDescription = @"This is the description for Rest";
    excercise8.category = @"rest";
    excercise8.numberOfRepsSuggested = 0;
    excercise8.numberOfRepsActual = 0;
    excercise8.timeInSecondsSuggested = 60;
    excercise8.timeInSecondsActual = 0;
    excercise8.pictureName = @"rest";
    
    excercise9.indexInWorkoutNumber = 8;
    excercise9.uniqueIdentifier = [NSString stringWithFormat:@"Workout %u, excercise %lld",workoutNumber, excercise9.indexInWorkoutNumber];
    excercise9.name = @"Lower Back Extensions";
    excercise9.excerciseDescription = @"This is the description for Lower Back Extensions";
    excercise9.category = @"core";
    excercise9.numberOfRepsSuggested = 12;
    excercise9.numberOfRepsActual = 0;
    excercise9.timeInSecondsSuggested = 45;
    excercise9.timeInSecondsActual = 0;
    excercise9.pictureName = @"lowerBackExtensions";
    [excercise9 addAccessoriesObject:lowerBackStructure];
    
    excercise10.indexInWorkoutNumber = 9;
    excercise10.uniqueIdentifier = [NSString stringWithFormat:@"Workout %u, excercise %lld",workoutNumber, excercise10.indexInWorkoutNumber];
    excercise10.name = @"Rest";
    excercise10.excerciseDescription = @"This is the description for Rest";
    excercise10.category = @"rest";
    excercise10.numberOfRepsSuggested = 0;
    excercise10.numberOfRepsActual = 0;
    excercise10.timeInSecondsSuggested = 60;
    excercise10.timeInSecondsActual = 0;
    excercise10.pictureName = @"rest";
    
    excercise11.indexInWorkoutNumber = 10;
    excercise11.uniqueIdentifier = [NSString stringWithFormat:@"Workout %u, excercise %lld",workoutNumber, excercise11.indexInWorkoutNumber];
    excercise11.name = @"Bicep Curls";
    excercise11.excerciseDescription = @"This is the description for Bicep Curls";
    excercise11.category = @"back";
    excercise11.numberOfRepsSuggested = 10;
    excercise11.numberOfRepsActual = 0;
    excercise11.timeInSecondsSuggested = 45;
    excercise11.timeInSecondsActual = 0;
    excercise11.pictureName = @"curls";
    [excercise5 addAccessoriesObject:dumbellThirtyFivePounds];
    
    excercise12.indexInWorkoutNumber = 11;
    excercise12.uniqueIdentifier = [NSString stringWithFormat:@"Workout %u, excercise %lld",workoutNumber, excercise12.indexInWorkoutNumber];
    excercise12.name = @"Rest";
    excercise12.excerciseDescription = @"This is the description for Rest";
    excercise12.category = @"rest";
    excercise12.numberOfRepsSuggested = 0;
    excercise12.numberOfRepsActual = 0;
    excercise12.timeInSecondsSuggested = 60;
    excercise12.timeInSecondsActual = 0;
    excercise12.pictureName = @"rest";
    
    excercise13.indexInWorkoutNumber = 12;
    excercise13.uniqueIdentifier = [NSString stringWithFormat:@"Workout %u, excercise %lld",workoutNumber, excercise13.indexInWorkoutNumber];
    excercise13.name = @"Dips";
    excercise13.excerciseDescription = @"This is the description for Dips";
    excercise13.category = @"chest";
    excercise13.numberOfRepsSuggested = 10;
    excercise13.numberOfRepsActual = 0;
    excercise13.timeInSecondsSuggested = 45;
    excercise13.timeInSecondsActual = 0;
    excercise13.pictureName = @"dips";
    [excercise13 addAccessoriesObject:dipBar];
    
    excercise14.indexInWorkoutNumber = 13;
    excercise14.uniqueIdentifier = [NSString stringWithFormat:@"Workout %u, excercise %lld",workoutNumber, excercise14.indexInWorkoutNumber];
    excercise14.name = @"Rest";
    excercise14.excerciseDescription = @"This is the description for Rest";
    excercise14.category = @"rest";
    excercise14.numberOfRepsSuggested = 0;
    excercise14.numberOfRepsActual = 0;
    excercise14.timeInSecondsSuggested = 60;
    excercise14.timeInSecondsActual = 0;
    excercise14.pictureName = @"rest";
    
    excercise15.indexInWorkoutNumber = 14;
    excercise15.uniqueIdentifier = [NSString stringWithFormat:@"Workout %u, excercise %lld",workoutNumber, excercise15.indexInWorkoutNumber];
    excercise15.name = @"Lunges";
    excercise15.excerciseDescription = @"This is the description for Lunges";
    excercise15.category = @"legs";
    excercise15.numberOfRepsSuggested = 20;
    excercise15.numberOfRepsActual = 0;
    excercise15.timeInSecondsSuggested = 90;
    excercise15.timeInSecondsActual = 0;
    excercise15.pictureName = @"lunges";
    [excercise5 addAccessoriesObject:dumbellThirtyFivePounds];
    
    
    [workout addExcercisesObject:excercise1];
    [workout addExcercisesObject:excercise2];
    [workout addExcercisesObject:excercise3];
    [workout addExcercisesObject:excercise4];
    [workout addExcercisesObject:excercise5];
    [workout addExcercisesObject:excercise6];
    [workout addExcercisesObject:excercise7];
    [workout addExcercisesObject:excercise8];
    [workout addExcercisesObject:excercise9];
    [workout addExcercisesObject:excercise10];
    [workout addExcercisesObject:excercise11];
    [workout addExcercisesObject:excercise12];
    [workout addExcercisesObject:excercise13];
    [workout addExcercisesObject:excercise14];
    [workout addExcercisesObject:excercise15];
    
    [self.dataStore fetchData];
    
    
    NSLog(@"created the workout, it has %lu excercises in it",workout.excercises.count);
    
    return workout;
    
}



@end
