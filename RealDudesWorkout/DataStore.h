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
#import "User.h"



@interface DataStore : NSObject

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) User *user;
@property (strong, nonatomic) NSArray *availableExcercises;
@property (strong, nonatomic) NSArray *availableAccessories;
@property (nonatomic) NSUInteger maxWorkoutNumber;


+(instancetype)sharedDataStore;

-(instancetype)init;

-(void)saveContext;

-(void)fetchData;

-(NSURL *)applicationDocumentsDirectory;




@end
