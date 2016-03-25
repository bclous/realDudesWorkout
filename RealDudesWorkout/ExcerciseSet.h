//
//  ExcerciseSet.h
//  RealDudesWorkout
//
//  Created by Brian Clouser on 3/18/16.
//  Copyright © 2016 The Qwiz LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Circuit, Excercise;

NS_ASSUME_NONNULL_BEGIN

@interface ExcerciseSet : NSManagedObject

// Insert code here to declare functionality of your managed object subclass

-(NSString *)timeStringFromActualExcerciseSetTime;

-(NSString *)generateExcerciseDurationTimeString;

@end

NS_ASSUME_NONNULL_END

#import "ExcerciseSet+CoreDataProperties.h"
