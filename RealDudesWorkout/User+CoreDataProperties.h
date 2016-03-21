//
//  User+CoreDataProperties.h
//  RealDudesWorkout
//
//  Created by Brian Clouser on 3/19/16.
//  Copyright © 2016 The Qwiz LLC. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "User.h"
#import "Workout.h"

NS_ASSUME_NONNULL_BEGIN

@interface User (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *name;
@property (nonatomic) int64_t backLevel;
@property (nonatomic) int64_t chestLevel;
@property (nonatomic) int64_t coreLevel;
@property (nonatomic) int64_t legsLevel;
@property (nonatomic) int64_t flexLevel;
@property (nullable, nonatomic, retain) NSSet<Workout *> *workouts;

@end

@interface User (CoreDataGeneratedAccessors)

- (void)addWorkoutsObject:(Workout *)value;
- (void)removeWorkoutsObject:(Workout *)value;
- (void)addWorkouts:(NSSet<Workout *> *)values;
- (void)removeWorkouts:(NSSet<Workout *> *)values;

@end

NS_ASSUME_NONNULL_END
