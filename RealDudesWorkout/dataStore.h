//
//  dataStore.h
//  RealDudesWorkout
//
//  Created by Brian Clouser on 3/9/16.
//  Copyright © 2016 The Qwiz LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "Excercise.h"
#import "Workout.h"

@interface dataStore : NSObject

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) NSArray *workouts;

+(instancetype)sharedDataStore;

-(void)saveContext;

-(void)fetchData;

-(NSURL *)applicationDocumentsDirectory;




@end
