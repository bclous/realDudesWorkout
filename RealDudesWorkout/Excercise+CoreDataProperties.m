//
//  Excercise+CoreDataProperties.m
//  RealDudesWorkout
//
//  Created by Brian Clouser on 3/13/16.
//  Copyright © 2016 The Qwiz LLC. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Excercise+CoreDataProperties.h"

@implementation Excercise (CoreDataProperties)

@dynamic uniqueIdentifier;
@dynamic name;
@dynamic excerciseDescription;
@dynamic category;
@dynamic numberOfRepsSuggested;
@dynamic numberOfRepsActual;
@dynamic timeInSecondsSuggested;
@dynamic timeInSecondsActual;
@dynamic pictureName;
@dynamic indexInWorkoutNumber;
@dynamic workout;
@dynamic accessories;

@end
