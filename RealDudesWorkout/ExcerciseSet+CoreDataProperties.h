//
//  ExcerciseSet+CoreDataProperties.h
//  RealDudesWorkout
//
//  Created by Brian Clouser on 8/25/16.
//  Copyright © 2016 The Qwiz LLC. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "ExcerciseSet.h"
#import "Circuit.h"
#import "Excercise.h"

NS_ASSUME_NONNULL_BEGIN

@interface ExcerciseSet (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *excerciseSetDescription;
@property (nonatomic) int64_t excerciseSetIndexNumberInCicuit;
@property (nonatomic) BOOL isComplete;
@property (nullable, nonatomic, retain) NSString *name;
@property (nonatomic) int64_t numberofRepsActual;
@property (nonatomic) int64_t numberOfRepsSuggested;
@property (nonatomic) int64_t restTimeAfterInSecondsActual;
@property (nonatomic) int64_t restTimeAfterInSecondsSuggested;
@property (nonatomic) int64_t timeInSecondsActual;
@property (nonatomic) int64_t timeInSecondsSuggested;
@property (nullable, nonatomic, retain) NSSet<Circuit *> *circuit;
@property (nullable, nonatomic, retain) Excercise *excercise;

@end

@interface ExcerciseSet (CoreDataGeneratedAccessors)

- (void)addCircuitObject:(Circuit *)value;
- (void)removeCircuitObject:(Circuit *)value;
- (void)addCircuit:(NSSet<Circuit *> *)values;
- (void)removeCircuit:(NSSet<Circuit *> *)values;

@end

NS_ASSUME_NONNULL_END
