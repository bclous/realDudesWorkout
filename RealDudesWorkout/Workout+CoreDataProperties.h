//
//  Workout+CoreDataProperties.h
//  RealDudesWorkout
//
//  Created by Brian Clouser on 3/19/16.
//  Copyright © 2016 The Qwiz LLC. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Workout.h"
#import "Circuit.h"
#import "User.h"

NS_ASSUME_NONNULL_BEGIN

@interface Workout (CoreDataProperties)

@property (nonatomic) NSTimeInterval date;
@property (nonatomic) BOOL isFinished;
@property (nonatomic) BOOL isFinishedSuccessfully;
@property (nullable, nonatomic, retain) NSString *name;
@property (nonatomic) int64_t timeInSeconds;
@property (nullable, nonatomic, retain) NSSet<Circuit *> *circuits;
@property (nullable, nonatomic, retain) NSManagedObject *user;

@end

@interface Workout (CoreDataGeneratedAccessors)

- (void)addCircuitsObject:(Circuit *)value;
- (void)removeCircuitsObject:(Circuit *)value;
- (void)addCircuits:(NSSet<Circuit *> *)values;
- (void)removeCircuits:(NSSet<Circuit *> *)values;

@end

NS_ASSUME_NONNULL_END
