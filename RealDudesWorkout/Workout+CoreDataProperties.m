//
//  Workout+CoreDataProperties.m
//  RealDudesWorkout
//
//  Created by Brian Clouser on 8/25/16.
//  Copyright © 2016 The Qwiz LLC. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Workout+CoreDataProperties.h"

@implementation Workout (CoreDataProperties)

@dynamic date;
@dynamic isFinished;
@dynamic isFinishedSuccessfully;
@dynamic level;
@dynamic name;
@dynamic targetTimeInSeconds;
@dynamic timeInSeconds;
@dynamic workoutNumber;
@dynamic availableAccessories;
@dynamic circuits;
@dynamic user;

@end
