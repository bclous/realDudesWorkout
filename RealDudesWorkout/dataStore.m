//
//  dataStore.m
//  RealDudesWorkout
//
//  Created by Brian Clouser on 3/9/16.
//  Copyright © 2016 The Qwiz LLC. All rights reserved.
//

#import "dataStore.h"

@implementation dataStore

@synthesize managedObjectContext = _managedObjectContext;

+ (instancetype)sharedDataStore;
{
    static dataStore *_sharedDataStore = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedDataStore = [[dataStore alloc] init];
    });
    
    return _sharedDataStore;
}

//-(instancetype)init
//{
//    self = [super init];
//    
//    if (self)
//    {
//        NSLog(@"this is getting called and count is: %lu",self.availableExcercises.count);
//        BOOL firstTime = self.availableExcercises.count == 0;
//        
//        if (firstTime)
//        {
//            NSLog(@"this is happening");
//            [self createUser];
//            [self generateAvailableExcercisesAndAccessoriesArrays];
//        }
//    }
//    
//    return self;
//}


-(void)createUser
{
    User *user = [NSEntityDescription insertNewObjectForEntityForName:@"User" inManagedObjectContext:self.managedObjectContext];
    
    user.name = @"Workout Bro";
    user.backLevel = 0;
    user.chestLevel = 0;
    user.legsLevel = 0;
    user.coreLevel = 0;
    user.flexLevel = 0;
    
    self.user = user;
    
   // [self saveContext]; do I need this?
    
    
}

-(void)saveContext
{
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil)
    {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error])
        {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            
            abort();
        }
    }

}

- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSManagedObjectContext *)managedObjectContext
{
    if (_managedObjectContext != nil)
    {
        return _managedObjectContext;
    }
    
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"Model.sqlite"];
    
    NSError *error = nil;
    
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"Model" withExtension:@"momd"];
    NSManagedObjectModel *managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    NSPersistentStoreCoordinator *coordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:managedObjectModel];
    
    [coordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error];
    if (coordinator != nil) {
        _managedObjectContext = [[NSManagedObjectContext alloc] init];
        [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return _managedObjectContext;
}




-(void)fetchData
{
    NSFetchRequest *excercisesRequest = [NSFetchRequest fetchRequestWithEntityName:@"Excercise"];
    NSFetchRequest *accessoriesRequest = [NSFetchRequest fetchRequestWithEntityName:@"Accessory"];
    NSFetchRequest *userRequest = [NSFetchRequest fetchRequestWithEntityName:@"User"];
    
    self.availableExcercises = [self.managedObjectContext executeFetchRequest:excercisesRequest error:nil];
    self.availableAccessories = [self.managedObjectContext executeFetchRequest:accessoriesRequest error:nil];
    
    NSArray *users = [self.managedObjectContext executeFetchRequest:userRequest error:nil];
    
    
    if (users.count == 0)
    {
        [self createUser];
        [self generateAvailableExcercisesAndAccessoriesArrays];
    }
    else
    {
        self.user = users[0];
    }
    
    [self saveContext];
    
}

-(void)generateAvailableExcercisesAndAccessoriesArrays
{
    
    Excercise *pullups = [NSEntityDescription insertNewObjectForEntityForName:@"Excercise" inManagedObjectContext:self.managedObjectContext];
    Excercise *crawlDownPushups = [NSEntityDescription insertNewObjectForEntityForName:@"Excercise" inManagedObjectContext:self.managedObjectContext];
    Excercise *squats = [NSEntityDescription insertNewObjectForEntityForName:@"Excercise" inManagedObjectContext:self.managedObjectContext];
    Excercise *legKicks = [NSEntityDescription insertNewObjectForEntityForName:@"Excercise" inManagedObjectContext:self.managedObjectContext];
    
    Accessory *pullupBar = [NSEntityDescription insertNewObjectForEntityForName:@"Accessory" inManagedObjectContext:self.managedObjectContext];
    
    pullups.name = @"Pullups";
    pullups.pictureName = @"pullUp";
    pullups.category = @"back";
    pullups.excerciseDescription = @"This is the description for pullups";
    
    crawlDownPushups.name = @"Crawl down pushups";
    crawlDownPushups.pictureName = @"crawlDownPushups";
    crawlDownPushups.category = @"chest";
    crawlDownPushups.excerciseDescription = @"this is the description for crawl down pushups";
    
    squats.name = @"Squats";
    squats.pictureName = @"squat";
    squats.category = @"legs";
    squats.excerciseDescription = @"This is the description for Squats";
    
    legKicks.name = @"Leg kicks";
    legKicks.pictureName = @"legKicks";
    legKicks.category = @"core";
    legKicks.excerciseDescription = @"This is the description for leg kicks";
    
    pullupBar.name = @"Pullup bar";
    pullupBar.pictureName = @"pullUpBar";
    
    [pullups addAccessoriesObject:pullupBar];
    
    
    NSFetchRequest *excercisesRequest = [NSFetchRequest fetchRequestWithEntityName:@"Excercise"];
    NSFetchRequest *accessoriesRequest = [NSFetchRequest fetchRequestWithEntityName:@"Accessory"];
    
    self.availableExcercises = [self.managedObjectContext executeFetchRequest:excercisesRequest error:nil];
    self.availableAccessories = [self.managedObjectContext executeFetchRequest:accessoriesRequest error:nil];
    
}






@end
