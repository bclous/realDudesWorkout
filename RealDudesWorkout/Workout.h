//
//  Workout.h
//  RealDudesWorkout
//
//  Created by Brian Clouser on 3/9/16.
//  Copyright © 2016 The Qwiz LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "dataStore.h"

NS_ASSUME_NONNULL_BEGIN

@interface Workout : NSManagedObject


// Insert code here to declare functionality of your managed object subclass


-(NSString *)workoutStartDayOfWeek;
-(NSString *)workoutStartDayOfMonth;
-(NSString *)workoutStartMonth;
-(NSString *)workoutTimeString;
//-(NSString *)stringCompletedExcercies;
//-(NSArray *)arrayOfCompletedExcercises;

-(Workout *)generateWorkout;

-(NSArray *)excercisesInOrder;






@end

NS_ASSUME_NONNULL_END

#import "Workout+CoreDataProperties.h"
