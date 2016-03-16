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
    
    Excercise *excercise16A = [NSEntityDescription insertNewObjectForEntityForName:@"Excercise" inManagedObjectContext:self.dataStore.managedObjectContext];

    
    
    Excercise *excercise16 = [NSEntityDescription insertNewObjectForEntityForName:@"Excercise" inManagedObjectContext:self.dataStore.managedObjectContext];
    Excercise *excercise17 = [NSEntityDescription insertNewObjectForEntityForName:@"Excercise" inManagedObjectContext:self.dataStore.managedObjectContext];
    Excercise *excercise18 = [NSEntityDescription insertNewObjectForEntityForName:@"Excercise" inManagedObjectContext:self.dataStore.managedObjectContext];
    Excercise *excercise18A = [NSEntityDescription insertNewObjectForEntityForName:@"Excercise" inManagedObjectContext:self.dataStore.managedObjectContext];
    Excercise *excercise19 = [NSEntityDescription insertNewObjectForEntityForName:@"Excercise" inManagedObjectContext:self.dataStore.managedObjectContext];
    Excercise *excercise20 = [NSEntityDescription insertNewObjectForEntityForName:@"Excercise" inManagedObjectContext:self.dataStore.managedObjectContext];
    Excercise *excercise21 = [NSEntityDescription insertNewObjectForEntityForName:@"Excercise" inManagedObjectContext:self.dataStore.managedObjectContext];
    Excercise *excercise22 = [NSEntityDescription insertNewObjectForEntityForName:@"Excercise" inManagedObjectContext:self.dataStore.managedObjectContext];
    Excercise *excercise23 = [NSEntityDescription insertNewObjectForEntityForName:@"Excercise" inManagedObjectContext:self.dataStore.managedObjectContext];
    Excercise *excercise24 = [NSEntityDescription insertNewObjectForEntityForName:@"Excercise" inManagedObjectContext:self.dataStore.managedObjectContext];
    Excercise *excercise25 = [NSEntityDescription insertNewObjectForEntityForName:@"Excercise" inManagedObjectContext:self.dataStore.managedObjectContext];
    Excercise *excercise26 = [NSEntityDescription insertNewObjectForEntityForName:@"Excercise" inManagedObjectContext:self.dataStore.managedObjectContext];
    Excercise *excercise27 = [NSEntityDescription insertNewObjectForEntityForName:@"Excercise" inManagedObjectContext:self.dataStore.managedObjectContext];
    Excercise *excercise28= [NSEntityDescription insertNewObjectForEntityForName:@"Excercise" inManagedObjectContext:self.dataStore.managedObjectContext];
    Excercise *excercise29 = [NSEntityDescription insertNewObjectForEntityForName:@"Excercise" inManagedObjectContext:self.dataStore.managedObjectContext];
    Excercise *excercise30 = [NSEntityDescription insertNewObjectForEntityForName:@"Excercise" inManagedObjectContext:self.dataStore.managedObjectContext];
    
    Excercise *excercise31 = [NSEntityDescription insertNewObjectForEntityForName:@"Excercise" inManagedObjectContext:self.dataStore.managedObjectContext];
    Excercise *excercise32 = [NSEntityDescription insertNewObjectForEntityForName:@"Excercise" inManagedObjectContext:self.dataStore.managedObjectContext];
    Excercise *excercise33 = [NSEntityDescription insertNewObjectForEntityForName:@"Excercise" inManagedObjectContext:self.dataStore.managedObjectContext];
    Excercise *excercise33A = [NSEntityDescription insertNewObjectForEntityForName:@"Excercise" inManagedObjectContext:self.dataStore.managedObjectContext];
    Excercise *excercise34 = [NSEntityDescription insertNewObjectForEntityForName:@"Excercise" inManagedObjectContext:self.dataStore.managedObjectContext];
    Excercise *excercise35 = [NSEntityDescription insertNewObjectForEntityForName:@"Excercise" inManagedObjectContext:self.dataStore.managedObjectContext];
    Excercise *excercise36 = [NSEntityDescription insertNewObjectForEntityForName:@"Excercise" inManagedObjectContext:self.dataStore.managedObjectContext];
    Excercise *excercise37 = [NSEntityDescription insertNewObjectForEntityForName:@"Excercise" inManagedObjectContext:self.dataStore.managedObjectContext];
    Excercise *excercise38 = [NSEntityDescription insertNewObjectForEntityForName:@"Excercise" inManagedObjectContext:self.dataStore.managedObjectContext];
    Excercise *excercise39 = [NSEntityDescription insertNewObjectForEntityForName:@"Excercise" inManagedObjectContext:self.dataStore.managedObjectContext];
    Excercise *excercise40 = [NSEntityDescription insertNewObjectForEntityForName:@"Excercise" inManagedObjectContext:self.dataStore.managedObjectContext];
    Excercise *excercise41 = [NSEntityDescription insertNewObjectForEntityForName:@"Excercise" inManagedObjectContext:self.dataStore.managedObjectContext];
    Excercise *excercise42 = [NSEntityDescription insertNewObjectForEntityForName:@"Excercise" inManagedObjectContext:self.dataStore.managedObjectContext];
   
    
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
    excercise1.isComplete = NO;
    [excercise1 addAccessoriesObject:pullUpBar];
    
    
    excercise2.indexInWorkoutNumber = 1;
    excercise2.uniqueIdentifier = [NSString stringWithFormat:@"Workout %u, excercise %lld",workoutNumber, excercise2.indexInWorkoutNumber];
    excercise2.name = @"Rest";
    excercise2.excerciseDescription = @"This is the description for Resting!";
    excercise2.category = @"rest";
    excercise2.numberOfRepsSuggested = 0;
    excercise2.numberOfRepsActual = 0;
    excercise2.timeInSecondsSuggested = 60;
    excercise2.timeInSecondsActual = 0;
    excercise2.isComplete = NO;
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
    excercise3.isComplete = NO;
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
    excercise4.isComplete = NO;
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
    excercise5.isComplete = NO;
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
    excercise6.isComplete = NO;
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
    excercise7.isComplete = NO;
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
    excercise8.isComplete = NO;
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
    excercise9.isComplete = NO;
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
    excercise10.isComplete = NO;
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
    excercise11.isComplete = NO;
    excercise11.pictureName = @"curls";
    [excercise11 addAccessoriesObject:dumbellThirtyFivePounds];
    
    excercise12.indexInWorkoutNumber = 11;
    excercise12.uniqueIdentifier = [NSString stringWithFormat:@"Workout %u, excercise %lld",workoutNumber, excercise12.indexInWorkoutNumber];
    excercise12.name = @"Rest";
    excercise12.excerciseDescription = @"This is the description for Rest";
    excercise12.category = @"rest";
    excercise12.numberOfRepsSuggested = 0;
    excercise12.numberOfRepsActual = 0;
    excercise12.timeInSecondsSuggested = 60;
    excercise12.timeInSecondsActual = 0;
    excercise12.isComplete = NO;
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
    excercise13.isComplete = NO;
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
    excercise14.isComplete = NO;
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
    excercise15.isComplete = NO;
    excercise15.pictureName = @"lunges";
    [excercise5 addAccessoriesObject:dumbellThirtyFivePounds];
    
    excercise16A.indexInWorkoutNumber = 15;
    excercise16A.uniqueIdentifier = [NSString stringWithFormat:@"Workout %lu, excercise %lld",workoutNumber, excercise16A.indexInWorkoutNumber];
    excercise16A.name = @"Rest";
    excercise16A.excerciseDescription = @"This is the description for Rest";
    excercise16A.category = @"rest";
    excercise16A.numberOfRepsSuggested = 0;
    excercise16A.numberOfRepsActual = 0;
    excercise16A.timeInSecondsSuggested = 60;
    excercise16A.timeInSecondsActual = 0;
    excercise16A.pictureName = @"rest";
    excercise16A.isComplete = NO;
   
    
    excercise16.indexInWorkoutNumber = 16;
    excercise16.uniqueIdentifier = [NSString stringWithFormat:@"Workout %lu, excercise %lld",workoutNumber, excercise16.indexInWorkoutNumber];
    excercise16.name = @"Pullups";
    excercise16.excerciseDescription = @"This is the description for pull ups";
    excercise16.category = @"back";
    excercise16.numberOfRepsSuggested = 8;
    excercise16.numberOfRepsActual = 0;
    excercise16.timeInSecondsSuggested = 45;
    excercise16.timeInSecondsActual = 0;
    excercise16.pictureName = @"pullUp";
    excercise16.isComplete = NO;
    [excercise16 addAccessoriesObject:pullUpBar];
    
    
    excercise17.indexInWorkoutNumber = 17;
    excercise17.uniqueIdentifier = [NSString stringWithFormat:@"Workout %u, excercise %lld",workoutNumber, excercise17.indexInWorkoutNumber];
    excercise17.name = @"Rest";
    excercise17.excerciseDescription = @"This is the description for Resting!";
    excercise17.category = @"rest";
    excercise17.numberOfRepsSuggested = 0;
    excercise17.numberOfRepsActual = 0;
    excercise17.timeInSecondsSuggested = 60;
    excercise17.timeInSecondsActual = 0;
    excercise17.isComplete = NO;
    excercise17.pictureName = @"rest";
    
    excercise18.indexInWorkoutNumber = 18;
    excercise18.uniqueIdentifier = [NSString stringWithFormat:@"Workout %u, excercise %lld",workoutNumber, excercise18.indexInWorkoutNumber];
    excercise18.name = @"Crawl Down Pushups";
    excercise18.excerciseDescription = @"This is the description for Crawl Down Pushups";
    excercise18.category = @"chest";
    excercise18.numberOfRepsSuggested = 10;
    excercise18.numberOfRepsActual = 0;
    excercise18.timeInSecondsSuggested = 90;
    excercise18.timeInSecondsActual = 0;
    excercise18.isComplete = NO;
    excercise18.pictureName = @"crawlDownPushups";
    
    excercise18A.indexInWorkoutNumber = 19;
    excercise18A.uniqueIdentifier = [NSString stringWithFormat:@"Workout %u, excercise %lld",workoutNumber, excercise17.indexInWorkoutNumber];
    excercise18A.name = @"Rest";
    excercise18A.excerciseDescription = @"This is the description for Resting!";
    excercise18A.category = @"rest";
    excercise18A.numberOfRepsSuggested = 0;
    excercise18A.numberOfRepsActual = 0;
    excercise18A.timeInSecondsActual = 0;
    excercise18A.isComplete = NO;
    excercise18A.pictureName = @"rest";
    
    
    
    excercise19.indexInWorkoutNumber = 20;
    excercise19.uniqueIdentifier = [NSString stringWithFormat:@"Workout %u, excercise %lld",workoutNumber, excercise19.indexInWorkoutNumber];
    excercise19.name = @"Squats";
    excercise19.excerciseDescription = @"This is the description for Squats";
    excercise19.category = @"legs";
    excercise19.numberOfRepsSuggested = 10;
    excercise19.numberOfRepsActual = 0;
    excercise19.timeInSecondsSuggested = 419;
    excercise19.timeInSecondsActual = 0;
    excercise19.isComplete = NO;
    excercise19.pictureName = @"squat";
    [excercise19 addAccessoriesObject:dumbellThirtyFivePounds];
    
    excercise20.indexInWorkoutNumber = 21;
    excercise20.uniqueIdentifier = [NSString stringWithFormat:@"Workout %u, excercise %lld",workoutNumber, excercise20.indexInWorkoutNumber];
    excercise20.name = @"Rest";
    excercise20.excerciseDescription = @"This is the description for Rest";
    excercise20.category = @"rest";
    excercise20.numberOfRepsSuggested = 0;
    excercise20.numberOfRepsActual = 0;
    excercise20.timeInSecondsSuggested = 60;
    excercise20.timeInSecondsActual = 0;
    excercise20.isComplete = NO;
    excercise20.pictureName = @"rest";
    
    excercise21.indexInWorkoutNumber = 22;
    excercise21.uniqueIdentifier = [NSString stringWithFormat:@"Workout %u, excercise %lld",workoutNumber, excercise21.indexInWorkoutNumber];
    excercise21.name = @"Leg Kicks";
    excercise21.excerciseDescription = @"This is the description for Leg Kicks";
    excercise21.category = @"core";
    excercise21.numberOfRepsSuggested = 50;
    excercise21.numberOfRepsActual = 0;
    excercise21.timeInSecondsSuggested = 45;
    excercise21.timeInSecondsActual = 0;
    excercise21.isComplete = NO;
    excercise21.pictureName = @"legKicks";
    
    excercise22.indexInWorkoutNumber = 23;
    excercise22.uniqueIdentifier = [NSString stringWithFormat:@"Workout %u, excercise %lld",workoutNumber, excercise22.indexInWorkoutNumber];
    excercise22.name = @"Rest";
    excercise22.excerciseDescription = @"This is the description for Rest";
    excercise22.category = @"rest";
    excercise22.numberOfRepsSuggested = 0;
    excercise22.numberOfRepsActual = 0;
    excercise22.timeInSecondsSuggested = 60;
    excercise22.timeInSecondsActual = 0;
    excercise22.isComplete = NO;
    excercise22.pictureName = @"rest";
    
    excercise23.indexInWorkoutNumber = 24;
    excercise23.uniqueIdentifier = [NSString stringWithFormat:@"Workout %u, excercise %lld",workoutNumber, excercise23.indexInWorkoutNumber];
    excercise23.name = @"Lower Back Extensions";
    excercise23.excerciseDescription = @"This is the description for Lower Back Extensions";
    excercise23.category = @"core";
    excercise23.numberOfRepsSuggested = 12;
    excercise23.numberOfRepsActual = 0;
    excercise23.timeInSecondsSuggested = 45;
    excercise23.timeInSecondsActual = 0;
    excercise23.isComplete = NO;
    excercise23.pictureName = @"lowerBackExtensions";
    [excercise23 addAccessoriesObject:lowerBackStructure];
    
    excercise24.indexInWorkoutNumber = 25;
    excercise24.uniqueIdentifier = [NSString stringWithFormat:@"Workout %u, excercise %lld",workoutNumber, excercise24.indexInWorkoutNumber];
    excercise24.name = @"Rest";
    excercise24.excerciseDescription = @"This is the description for Rest";
    excercise24.category = @"rest";
    excercise24.numberOfRepsSuggested = 0;
    excercise24.numberOfRepsActual = 0;
    excercise24.timeInSecondsSuggested = 60;
    excercise24.timeInSecondsActual = 0;
    excercise24.isComplete = NO;
    excercise24.pictureName = @"rest";
    
    excercise25.indexInWorkoutNumber = 26;
    excercise25.uniqueIdentifier = [NSString stringWithFormat:@"Workout %u, excercise %lld",workoutNumber, excercise25.indexInWorkoutNumber];
    excercise25.name = @"Bicep Curls";
    excercise25.excerciseDescription = @"This is the description for Bicep Curls";
    excercise25.category = @"back";
    excercise25.numberOfRepsSuggested = 10;
    excercise25.numberOfRepsActual = 0;
    excercise25.timeInSecondsSuggested = 45;
    excercise25.timeInSecondsActual = 0;
    excercise25.isComplete = NO;
    excercise25.pictureName = @"curls";
    [excercise25 addAccessoriesObject:dumbellThirtyFivePounds];
    
    excercise26.indexInWorkoutNumber = 27;
    excercise26.uniqueIdentifier = [NSString stringWithFormat:@"Workout %u, excercise %lld",workoutNumber, excercise26.indexInWorkoutNumber];
    excercise26.name = @"Rest";
    excercise26.excerciseDescription = @"This is the description for Rest";
    excercise26.category = @"rest";
    excercise26.numberOfRepsSuggested = 0;
    excercise26.numberOfRepsActual = 0;
    excercise26.timeInSecondsSuggested = 60;
    excercise26.timeInSecondsActual = 0;
    excercise26.isComplete = NO;
    excercise26.pictureName = @"rest";
    
    excercise27.indexInWorkoutNumber = 28;
    excercise27.uniqueIdentifier = [NSString stringWithFormat:@"Workout %u, excercise %lld",workoutNumber, excercise27.indexInWorkoutNumber];
    excercise27.name = @"Dips";
    excercise27.excerciseDescription = @"This is the description for Dips";
    excercise27.category = @"chest";
    excercise27.numberOfRepsSuggested = 10;
    excercise27.numberOfRepsActual = 0;
    excercise27.timeInSecondsSuggested = 45;
    excercise27.timeInSecondsActual = 0;
    excercise27.isComplete = NO;
    excercise27.pictureName = @"dips";
    [excercise27 addAccessoriesObject:dipBar];
    
    excercise28.indexInWorkoutNumber = 29;
    excercise28.uniqueIdentifier = [NSString stringWithFormat:@"Workout %u, excercise %lld",workoutNumber, excercise28.indexInWorkoutNumber];
    excercise28.name = @"Rest";
    excercise28.excerciseDescription = @"This is the description for Rest";
    excercise28.category = @"rest";
    excercise28.numberOfRepsSuggested = 0;
    excercise28.numberOfRepsActual = 0;
    excercise28.timeInSecondsSuggested = 60;
    excercise28.timeInSecondsActual = 0;
    excercise28.isComplete = NO;
    excercise28.pictureName = @"rest";
    
    excercise29.indexInWorkoutNumber = 30;
    excercise29.uniqueIdentifier = [NSString stringWithFormat:@"Workout %u, excercise %lld",workoutNumber, excercise29.indexInWorkoutNumber];
    excercise29.name = @"Lunges";
    excercise29.excerciseDescription = @"This is the description for Lunges";
    excercise29.category = @"legs";
    excercise29.numberOfRepsSuggested = 20;
    excercise29.numberOfRepsActual = 0;
    excercise29.timeInSecondsSuggested = 90;
    excercise29.timeInSecondsActual = 0;
    excercise29.isComplete = NO;
    excercise29.pictureName = @"lunges";
    [excercise29 addAccessoriesObject:dumbellThirtyFivePounds];
    
    excercise30.indexInWorkoutNumber = 31;
    excercise30.uniqueIdentifier = [NSString stringWithFormat:@"Workout %u, excercise %lld",workoutNumber, excercise30.indexInWorkoutNumber];
    excercise30.name = @"Rest";
    excercise30.excerciseDescription = @"This is the description for Rest";
    excercise30.category = @"rest";
    excercise30.numberOfRepsSuggested = 0;
    excercise30.numberOfRepsActual = 0;
    excercise30.timeInSecondsSuggested = 60;
    excercise30.timeInSecondsActual = 0;
    excercise30.isComplete = NO;
    excercise30.pictureName = @"rest";
    
    
    excercise31.indexInWorkoutNumber = 32;
    excercise31.uniqueIdentifier = [NSString stringWithFormat:@"Workout %lu, excercise %lld",workoutNumber, excercise31.indexInWorkoutNumber];
    excercise31.name = @"Pullups";
    excercise31.excerciseDescription = @"This is the description for pull ups";
    excercise31.category = @"back";
    excercise31.numberOfRepsSuggested = 8;
    excercise31.numberOfRepsActual = 0;
    excercise31.timeInSecondsSuggested = 45;
    excercise31.timeInSecondsActual = 0;
    excercise31.pictureName = @"pullUp";
    excercise31.isComplete = NO;
    [excercise31 addAccessoriesObject:pullUpBar];
    
    
    excercise32.indexInWorkoutNumber = 33;
    excercise32.uniqueIdentifier = [NSString stringWithFormat:@"Workout %u, excercise %lld",workoutNumber, excercise32.indexInWorkoutNumber];
    excercise32.name = @"Rest";
    excercise32.excerciseDescription = @"This is the description for Resting!";
    excercise32.category = @"rest";
    excercise32.numberOfRepsSuggested = 0;
    excercise32.numberOfRepsActual = 0;
    excercise32.timeInSecondsSuggested = 60;
    excercise32.timeInSecondsActual = 0;
    excercise32.isComplete = NO;
    excercise32.pictureName = @"rest";
    
    excercise33.indexInWorkoutNumber = 34;
    excercise33.uniqueIdentifier = [NSString stringWithFormat:@"Workout %u, excercise %lld",workoutNumber, excercise33.indexInWorkoutNumber];
    excercise33.name = @"Crawl Down Pushups";
    excercise33.excerciseDescription = @"This is the description for Crawl Down Pushups";
    excercise33.category = @"chest";
    excercise33.numberOfRepsSuggested = 10;
    excercise33.numberOfRepsActual = 0;
    excercise33.timeInSecondsSuggested = 90;
    excercise33.timeInSecondsActual = 0;
    excercise33.isComplete = NO;
    excercise33.pictureName = @"crawlDownPushups";
    
    
    excercise33A.indexInWorkoutNumber = 35;
    excercise33A.uniqueIdentifier = [NSString stringWithFormat:@"Workout %u, excercise %lld",workoutNumber, excercise32.indexInWorkoutNumber];
    excercise33A.name = @"Rest";
    excercise33A.excerciseDescription = @"This is the description for Resting!";
    excercise33A.category = @"rest";
    excercise33A.numberOfRepsSuggested = 0;
    excercise33A.numberOfRepsActual = 0;
    excercise33A.timeInSecondsSuggested = 60;
    excercise33A.timeInSecondsActual = 0;
    excercise33A.isComplete = NO;
    excercise33A.pictureName = @"rest";
    
    
    excercise34.indexInWorkoutNumber = 36;
    excercise34.uniqueIdentifier = [NSString stringWithFormat:@"Workout %u, excercise %lld",workoutNumber, excercise34.indexInWorkoutNumber];
    excercise34.name = @"Squats";
    excercise34.excerciseDescription = @"This is the description for Squats";
    excercise34.category = @"legs";
    excercise34.numberOfRepsSuggested = 10;
    excercise34.numberOfRepsActual = 0;
    excercise34.timeInSecondsSuggested = 434;
    excercise34.timeInSecondsActual = 0;
    excercise34.isComplete = NO;
    excercise34.pictureName = @"squat";
    [excercise34 addAccessoriesObject:dumbellThirtyFivePounds];
    
    excercise35.indexInWorkoutNumber = 37;
    excercise35.uniqueIdentifier = [NSString stringWithFormat:@"Workout %u, excercise %lld",workoutNumber, excercise35.indexInWorkoutNumber];
    excercise35.name = @"Rest";
    excercise35.excerciseDescription = @"This is the description for Rest";
    excercise35.category = @"rest";
    excercise35.numberOfRepsSuggested = 0;
    excercise35.numberOfRepsActual = 0;
    excercise35.timeInSecondsSuggested = 60;
    excercise35.timeInSecondsActual = 0;
    excercise35.isComplete = NO;
    excercise35.pictureName = @"rest";
    
    excercise36.indexInWorkoutNumber = 38;
    excercise36.uniqueIdentifier = [NSString stringWithFormat:@"Workout %u, excercise %lld",workoutNumber, excercise36.indexInWorkoutNumber];
    excercise36.name = @"Leg Kicks";
    excercise36.excerciseDescription = @"This is the description for Leg Kicks";
    excercise36.category = @"core";
    excercise36.numberOfRepsSuggested = 50;
    excercise36.numberOfRepsActual = 0;
    excercise36.timeInSecondsSuggested = 45;
    excercise36.timeInSecondsActual = 0;
    excercise36.isComplete = NO;
    excercise36.pictureName = @"legKicks";
    
    
    excercise37.indexInWorkoutNumber = 40;
    excercise37.uniqueIdentifier = [NSString stringWithFormat:@"Workout %u, excercise %lld",workoutNumber, excercise37.indexInWorkoutNumber];
    excercise37.name = @"Lower Back Extensions";
    excercise37.excerciseDescription = @"This is the description for Lower Back Extensions";
    excercise37.category = @"core";
    excercise37.numberOfRepsSuggested = 12;
    excercise37.numberOfRepsActual = 0;
    excercise37.timeInSecondsSuggested = 45;
    excercise37.timeInSecondsActual = 0;
    excercise37.isComplete = NO;
    excercise37.pictureName = @"lowerBackExtensions";
    [excercise37 addAccessoriesObject:lowerBackStructure];
    
    excercise38.indexInWorkoutNumber = 39;
    excercise38.uniqueIdentifier = [NSString stringWithFormat:@"Workout %u, excercise %lld",workoutNumber, excercise38.indexInWorkoutNumber];
    excercise38.name = @"Rest";
    excercise38.excerciseDescription = @"This is the description for Rest";
    excercise38.category = @"rest";
    excercise38.numberOfRepsSuggested = 0;
    excercise38.numberOfRepsActual = 0;
    excercise38.timeInSecondsSuggested = 60;
    excercise38.timeInSecondsActual = 0;
    excercise38.isComplete = NO;
    excercise38.pictureName = @"rest";
    
    excercise39.indexInWorkoutNumber = 41;
    excercise39.uniqueIdentifier = [NSString stringWithFormat:@"Workout %u, excercise %lld",workoutNumber, excercise39.indexInWorkoutNumber];
    excercise39.name = @"Rest";
    excercise39.excerciseDescription = @"This is the description for Rest";
    excercise39.category = @"rest";
    excercise39.numberOfRepsSuggested = 0;
    excercise39.numberOfRepsActual = 0;
    excercise39.timeInSecondsSuggested = 60;
    excercise39.timeInSecondsActual = 0;
    excercise39.isComplete = NO;
    excercise39.pictureName = @"rest";
    
    excercise40.indexInWorkoutNumber = 42;
    excercise40.uniqueIdentifier = [NSString stringWithFormat:@"Workout %u, excercise %lld",workoutNumber, excercise40.indexInWorkoutNumber];
    excercise40.name = @"Dips";
    excercise40.excerciseDescription = @"This is the description for Dips";
    excercise40.category = @"chest";
    excercise40.numberOfRepsSuggested = 10;
    excercise40.numberOfRepsActual = 0;
    excercise40.timeInSecondsSuggested = 45;
    excercise40.timeInSecondsActual = 0;
    excercise40.isComplete = NO;
    excercise40.pictureName = @"dips";
    [excercise40 addAccessoriesObject:dipBar];
    
    excercise41.indexInWorkoutNumber = 43;
    excercise41.uniqueIdentifier = [NSString stringWithFormat:@"Workout %u, excercise %lld",workoutNumber, excercise41.indexInWorkoutNumber];
    excercise41.name = @"Rest";
    excercise41.excerciseDescription = @"This is the description for Rest";
    excercise41.category = @"rest";
    excercise41.numberOfRepsSuggested = 0;
    excercise41.numberOfRepsActual = 0;
    excercise41.timeInSecondsSuggested = 60;
    excercise41.timeInSecondsActual = 0;
    excercise41.isComplete = NO;
    excercise41.pictureName = @"rest";
    
    excercise42.indexInWorkoutNumber = 44;
    excercise42.uniqueIdentifier = [NSString stringWithFormat:@"Workout %u, excercise %lld",workoutNumber, excercise42.indexInWorkoutNumber];
    excercise42.name = @"Lunges";
    excercise42.excerciseDescription = @"This is the description for Lunges";
    excercise42.category = @"legs";
    excercise42.numberOfRepsSuggested = 20;
    excercise42.numberOfRepsActual = 0;
    excercise42.timeInSecondsSuggested = 90;
    excercise42.timeInSecondsActual = 0;
    excercise42.isComplete = NO;
    excercise42.pictureName = @"lunges";
    [excercise42 addAccessoriesObject:dumbellThirtyFivePounds];
    

    
    
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
    [workout addExcercisesObject:excercise16A];
    [workout addExcercisesObject:excercise16];
    [workout addExcercisesObject:excercise17];
    [workout addExcercisesObject:excercise18];
    [workout addExcercisesObject:excercise18A];
    [workout addExcercisesObject:excercise19];
    [workout addExcercisesObject:excercise20];
    [workout addExcercisesObject:excercise21];
    [workout addExcercisesObject:excercise22];
    [workout addExcercisesObject:excercise23];
    [workout addExcercisesObject:excercise24];
    [workout addExcercisesObject:excercise25];
    [workout addExcercisesObject:excercise26];
    [workout addExcercisesObject:excercise27];
    [workout addExcercisesObject:excercise28];
    [workout addExcercisesObject:excercise29];
    [workout addExcercisesObject:excercise30];
    [workout addExcercisesObject:excercise31];
    [workout addExcercisesObject:excercise32];
    [workout addExcercisesObject:excercise33];
    [workout addExcercisesObject:excercise33A];
    [workout addExcercisesObject:excercise34];
    [workout addExcercisesObject:excercise35];
    [workout addExcercisesObject:excercise36];
    [workout addExcercisesObject:excercise37];
    [workout addExcercisesObject:excercise38];
    [workout addExcercisesObject:excercise39];
    [workout addExcercisesObject:excercise40];
    [workout addExcercisesObject:excercise41];
    [workout addExcercisesObject:excercise42];
    
    
    [self.dataStore fetchData];
    
    
    NSLog(@"created the workout, it has %lu excercises in it",workout.excercises.count);
    
    return workout;
    
}



@end
