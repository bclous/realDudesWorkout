//
//  Circuit+CoreDataProperties.h
//  RealDudesWorkout
//
//  Created by Brian Clouser on 3/18/16.
//  Copyright © 2016 The Qwiz LLC. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Circuit.h"
#import "Workout.h"
#import "ExcerciseSet.h"

NS_ASSUME_NONNULL_BEGIN

@interface Circuit (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *name;
@property (nonatomic) int64_t circuitIndexNumberInWorkout;
@property (nullable, nonatomic, retain) Workout *workout;
@property (nullable, nonatomic, retain) NSSet<ExcerciseSet *> *excerciseSets;

@end

@interface Circuit (CoreDataGeneratedAccessors)

- (void)addExcerciseSetsObject:(ExcerciseSet *)value;
- (void)removeExcerciseSetsObject:(ExcerciseSet *)value;
- (void)addExcerciseSets:(NSSet<ExcerciseSet *> *)values;
- (void)removeExcerciseSets:(NSSet<ExcerciseSet *> *)values;

@end

NS_ASSUME_NONNULL_END
