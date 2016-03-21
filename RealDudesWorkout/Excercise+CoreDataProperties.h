//
//  Excercise+CoreDataProperties.h
//  RealDudesWorkout
//
//  Created by Brian Clouser on 3/18/16.
//  Copyright © 2016 The Qwiz LLC. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Excercise.h"
#import "ExcerciseSet.h"
#import "Accessory.h"

NS_ASSUME_NONNULL_BEGIN

@interface Excercise (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSString *pictureName;
@property (nullable, nonatomic, retain) NSString *excerciseDescription;
@property (nullable, nonatomic, retain) NSString *category;
@property (nullable, nonatomic, retain) ExcerciseSet *excerciseSet;
@property (nullable, nonatomic, retain) NSSet<Accessory *> *accessories;

@end

@interface Excercise (CoreDataGeneratedAccessors)

- (void)addAccessoriesObject:(Accessory *)value;
- (void)removeAccessoriesObject:(Accessory *)value;
- (void)addAccessories:(NSSet<Accessory *> *)values;
- (void)removeAccessories:(NSSet<Accessory *> *)values;

@end

NS_ASSUME_NONNULL_END
