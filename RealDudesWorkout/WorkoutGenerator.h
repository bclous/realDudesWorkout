//
//  WorkoutGenerator.h
//  RealDudesWorkout
//
//  Created by Brian Clouser on 8/31/16.
//  Copyright © 2016 The Qwiz LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DataStore.h"
#import "Workout.h"

@interface WorkoutGenerator : NSObject

@property (strong, nonatomic) NSMutableArray *availableExercises;
@property (strong, nonatomic) NSMutableArray *availableAcessories;

@property (strong, nonatomic) NSMutableArray *availableBackExercises;
@property (strong, nonatomic) NSMutableArray *availableChestExercises;
@property (strong, nonatomic) NSMutableArray *availableFullBodyExercises;
@property (strong, nonatomic) NSMutableArray *availableCoreExercises;
@property (strong, nonatomic) NSMutableArray *availableFlexExercises;
@property (strong, nonatomic) NSMutableArray *availableLegsExercises;

@property (strong, nonatomic) NSMutableArray *backExercisesPriority1;
@property (strong, nonatomic) NSMutableArray *backExercisesPriority2;
@property (strong, nonatomic) NSMutableArray *chestExercisesPriority1;
@property (strong, nonatomic) NSMutableArray *chestExercisesPriority2;
@property (strong, nonatomic) NSMutableArray *fullBodyExercisesPriority1;
@property (strong, nonatomic) NSMutableArray *fullBodyExercisesPriority2;
@property (strong, nonatomic) NSMutableArray *coreExercisesPriority1;
@property (strong, nonatomic) NSMutableArray *coreExercisesPriority2;
@property (strong, nonatomic) NSMutableArray *flexExercisesPriority1;
@property (strong, nonatomic) NSMutableArray *flexExercisesPriority2;
@property (strong, nonatomic) NSMutableArray *legsExercisesPriority1;
@property (strong, nonatomic) NSMutableArray *legsExercisesPriority2;

@property (strong, nonatomic) DataStore *datastore;


-(instancetype)init;
-(Workout *)generateWorkoutWithTime:(NSInteger)time level:(NSInteger)level availableAccessories:(NSArray *)accessories;


@end
