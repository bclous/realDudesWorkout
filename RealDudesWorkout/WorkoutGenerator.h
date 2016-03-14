//
//  WorkoutGenerator.h
//  RealDudesWorkout
//
//  Created by Brian Clouser on 3/13/16.
//  Copyright © 2016 The Qwiz LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "dataStore.h"
#import "Workout.h"

@interface WorkoutGenerator : NSObject

@property (strong, nonatomic) dataStore *dataStore;
@property (nonatomic) BOOL test;

-(Workout *)createNewWorkoutStandard;

@end
