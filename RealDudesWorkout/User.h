//
//  User.h
//  RealDudesWorkout
//
//  Created by Brian Clouser on 3/19/16.
//  Copyright © 2016 The Qwiz LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "NSString+BDC_Utility.h"

@class Workout;

NS_ASSUME_NONNULL_BEGIN

@interface User : NSManagedObject

// Insert code here to declare functionality of your managed object subclass

-(NSArray *)orderedWorkoutsLIFO;
-(NSArray *)orderedWorkoutsFIFO;

-(Workout *)generateNewWorkout;

-(NSArray *)workoutsSinceMonday;
-(NSArray *)workoutsSinceFirstOfMonth;
-(NSArray *)workoutsSinceFirstOfYear;
-(NSArray *)workoutsLastSevenDays;
-(NSArray *)workoutsLastThirtyDays;
-(NSArray *)workoutsLast365Days;

-(NSDictionary *)dictionaryOfExcercisesWithQuantityGivenWorkouts:(NSArray *)workouts;

-(NSArray *)excerciseNameAndQuantitySortedGivenWorkouts:(NSArray *)workouts;
-(NSArray *)excercisePictureNamesSortedGivenWorkouts:(NSArray *)workouts;
-(NSOrderedSet *)orderedSetOfWorkoutDates;

@end

NS_ASSUME_NONNULL_END

#import "User+CoreDataProperties.h"
