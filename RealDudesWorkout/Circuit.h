//
//  Circuit.h
//  RealDudesWorkout
//
//  Created by Brian Clouser on 3/18/16.
//  Copyright © 2016 The Qwiz LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Workout;

NS_ASSUME_NONNULL_BEGIN

@interface Circuit : NSManagedObject

// Insert code here to declare functionality of your managed object subclass

-(NSArray *)excerciseSetsInOrder;

@end

NS_ASSUME_NONNULL_END

#import "Circuit+CoreDataProperties.h"
