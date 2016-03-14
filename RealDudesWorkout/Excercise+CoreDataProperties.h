//
//  Excercise+CoreDataProperties.h
//  RealDudesWorkout
//
//  Created by Brian Clouser on 3/13/16.
//  Copyright © 2016 The Qwiz LLC. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Excercise.h"
#import "Accessory.h"
#import "Workout.h"

NS_ASSUME_NONNULL_BEGIN

@interface Excercise (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *uniqueIdentifier;
@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSString *excerciseDescription;
@property (nullable, nonatomic, retain) NSString *category;
@property (nonatomic) int64_t numberOfRepsSuggested;
@property (nonatomic) int64_t numberOfRepsActual;
@property (nonatomic) int64_t timeInSecondsSuggested;
@property (nonatomic) int64_t timeInSecondsActual;
@property (nullable, nonatomic, retain) NSString *pictureName;
@property (nonatomic) int64_t indexInWorkoutNumber;
@property (nullable, nonatomic, retain) Workout *workout;
@property (nullable, nonatomic, retain) NSSet<Accessory *> *accessories;

@end

@interface Excercise (CoreDataGeneratedAccessors)

- (void)addAccessoriesObject:(Accessory *)value;
- (void)removeAccessoriesObject:(Accessory *)value;
- (void)addAccessories:(NSSet<Accessory *> *)values;
- (void)removeAccessories:(NSSet<Accessory *> *)values;

@end

NS_ASSUME_NONNULL_END
