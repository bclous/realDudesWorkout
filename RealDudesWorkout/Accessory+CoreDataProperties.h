//
//  Accessory+CoreDataProperties.h
//  RealDudesWorkout
//
//  Created by Brian Clouser on 3/13/16.
//  Copyright © 2016 The Qwiz LLC. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Accessory.h"
#import "Excercise.h"

NS_ASSUME_NONNULL_BEGIN

@interface Accessory (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSString *pictureName;
@property (nullable, nonatomic, retain) NSSet<Excercise *> *excercises;

@end

@interface Accessory (CoreDataGeneratedAccessors)

- (void)addExcercisesObject:(Excercise *)value;
- (void)removeExcercisesObject:(Excercise *)value;
- (void)addExcercises:(NSSet<Excercise *> *)values;
- (void)removeExcercises:(NSSet<Excercise *> *)values;

@end

NS_ASSUME_NONNULL_END
