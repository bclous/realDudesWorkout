//
//  dataStore.m
//  RealDudesWorkout
//
//  Created by Brian Clouser on 3/9/16.
//  Copyright © 2016 The Qwiz LLC. All rights reserved.
//

#import "dataStore.h"

@implementation DataStore

@synthesize managedObjectContext = _managedObjectContext;

+ (instancetype)sharedDataStore;
{
    static DataStore *_sharedDataStore = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedDataStore = [[DataStore alloc] init];
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
    
    
    // create excercises
    
    Excercise *pullups = [NSEntityDescription insertNewObjectForEntityForName:@"Excercise" inManagedObjectContext:self.managedObjectContext];
    Excercise *crawlDownPushups = [NSEntityDescription insertNewObjectForEntityForName:@"Excercise" inManagedObjectContext:self.managedObjectContext];
    Excercise *squats = [NSEntityDescription insertNewObjectForEntityForName:@"Excercise" inManagedObjectContext:self.managedObjectContext];
    Excercise *squatsWithWeight = [NSEntityDescription insertNewObjectForEntityForName:@"Excercise" inManagedObjectContext:self.managedObjectContext];
    Excercise *legKicks = [NSEntityDescription insertNewObjectForEntityForName:@"Excercise" inManagedObjectContext:self.managedObjectContext];
    Excercise *lowerBackExtensions = [NSEntityDescription insertNewObjectForEntityForName:@"Excercise" inManagedObjectContext:self.managedObjectContext];
    Excercise *bicepCurls = [NSEntityDescription insertNewObjectForEntityForName:@"Excercise" inManagedObjectContext:self.managedObjectContext];
    Excercise *dips = [NSEntityDescription insertNewObjectForEntityForName:@"Excercise" inManagedObjectContext:self.managedObjectContext];
    Excercise *lunges = [NSEntityDescription insertNewObjectForEntityForName:@"Excercise" inManagedObjectContext:self.managedObjectContext];
    Excercise *lungesWithWeight = [NSEntityDescription insertNewObjectForEntityForName:@"Excercise" inManagedObjectContext:self.managedObjectContext];
    Excercise *dipsOnBench = [NSEntityDescription insertNewObjectForEntityForName:@"Excercise" inManagedObjectContext:self.managedObjectContext];
    Excercise *latPullDowns = [NSEntityDescription insertNewObjectForEntityForName:@"Excercise" inManagedObjectContext:self.managedObjectContext];
    Excercise *pushups = [NSEntityDescription insertNewObjectForEntityForName:@"Excercise" inManagedObjectContext:self.managedObjectContext];
    Excercise *jumpingJacks = [NSEntityDescription insertNewObjectForEntityForName:@"Excercise" inManagedObjectContext:self.managedObjectContext];
    Excercise *burpees = [NSEntityDescription insertNewObjectForEntityForName:@"Excercise" inManagedObjectContext:self.managedObjectContext];
    
    
    
    // create accessories
    
    Accessory *pullupBar = [NSEntityDescription insertNewObjectForEntityForName:@"Accessory" inManagedObjectContext:self.managedObjectContext];
    Accessory *dipsBar = [NSEntityDescription insertNewObjectForEntityForName:@"Accessory" inManagedObjectContext:self.managedObjectContext];
    Accessory *bench = [NSEntityDescription insertNewObjectForEntityForName:@"Accessory" inManagedObjectContext:self.managedObjectContext];
    Accessory *latPullDownMachine = [NSEntityDescription insertNewObjectForEntityForName:@"Accessory" inManagedObjectContext:self.managedObjectContext];
    Accessory *dumbells = [NSEntityDescription insertNewObjectForEntityForName:@"Accessory" inManagedObjectContext:self.managedObjectContext];
    Accessory *backExtensionMachine = [NSEntityDescription insertNewObjectForEntityForName:@"Accessory" inManagedObjectContext:self.managedObjectContext];
    
    // setting up excercices
    
    pullups.name = @"Pullups";
    pullups.pictureName = @"pullUp";
    pullups.category = @"back foundation";
    pullups.excerciseDescription = @"This is the description for pullups";
    
    crawlDownPushups.name = @"Crawl down pushups";
    crawlDownPushups.pictureName = @"crawlDownPushups";
    crawlDownPushups.category = @"chest foundation";
    crawlDownPushups.excerciseDescription = @"this is the description for crawl down pushups";
    
    squatsWithWeight.name = @"Body weight squats";
    squatsWithWeight.pictureName = @"squat";
    squatsWithWeight.category = @"legs foundation";
    squatsWithWeight.excerciseDescription = @"This is the description for Squats";
    
    squats.name = @"Squats with dumbbell";
    squats.pictureName = @"squat";
    squats.category = @"legs foundation";
    squats.excerciseDescription = @"This is the description for Squats";
    
    legKicks.name = @"Leg kicks";
    legKicks.pictureName = @"legKicks";
    legKicks.category = @"core";
    legKicks.excerciseDescription = @"This is the description for leg kicks";
    
    pushups.name = @"Pushups";
    pushups.pictureName = @"pushups";
    pushups.category = @"chest foundation";
    pushups.excerciseDescription = @"description";
    
    lowerBackExtensions.name = @"Lower back extensions";
    lowerBackExtensions.pictureName = @"lowerBackExtensions";
    lowerBackExtensions.category = @"core";
    lowerBackExtensions.excerciseDescription =  @"description";
    
    bicepCurls.name = @"Bicep curls";
    bicepCurls.pictureName = @"curls";
    bicepCurls.category = @"back";
    bicepCurls.excerciseDescription =  @"description";
    
    dips.name = @"Dips";
    dips.pictureName = @"dips";
    dips.category = @"chest";
    dips.excerciseDescription =  @"description";
    
    lunges.name = @"Lunges";
    lunges.pictureName = @"lunges";
    lunges.category = @"legs";
    lunges.excerciseDescription =  @"description";
    
    lungesWithWeight.name = @"Lunges with weight";
    lungesWithWeight.pictureName = @"lunges";
    lungesWithWeight.category = @"legs";
    lungesWithWeight.excerciseDescription =  @"description";
    
    dipsOnBench.name = @"Bench dips";
    dipsOnBench.pictureName = @"benchDips";
    dipsOnBench.category = @"chest";
    dipsOnBench.excerciseDescription =  @"description";
    
    latPullDowns.name = @"Lat pull downs";
    latPullDowns.pictureName = @"latPullDowns";
    latPullDowns.category = @"back";
    latPullDowns.excerciseDescription =  @"description";
    
    jumpingJacks.name = @"Jumping Jacks";
    jumpingJacks.pictureName = @"jumpingJacks";
    jumpingJacks.category = @"cardio";
    jumpingJacks.excerciseDescription =  @"description";
    
    burpees.name = @"Burpees";
    burpees.pictureName = @"burpees";
    burpees.category = @"cardio";
    burpees.excerciseDescription =  @"description";
    

    
    // setting up accessories
    
    pullupBar.name = @"Pullup bar";
    pullupBar.pictureName = @"pullUpBar";
    
    dipsBar.name = @"Dips bar";
    dipsBar.pictureName = @"dipsBar";
    
    bench.name = @"Bench";
    bench.pictureName = @"bench";
    
    backExtensionMachine.name = @"Back Extension machine";
    backExtensionMachine.pictureName = @"lowerBackExtensionStructure";
    
    dumbells.name = @"dumbells";
    dumbells.pictureName = @"dumbbell";
    
    latPullDownMachine.name = @"Lat pull down machine";
    latPullDownMachine.pictureName = @"latPullDownMachine";
    
    // add accessories to excercies
    
    [pullups addAccessoriesObject:pullupBar];
    [latPullDowns addAccessoriesObject:latPullDownMachine];
    [squatsWithWeight addAccessoriesObject:dumbells];
    [lungesWithWeight addAccessoriesObject:dumbells];
    [lowerBackExtensions addAccessoriesObject:backExtensionMachine];
    [dipsOnBench addAccessoriesObject:bench];
    [dips addAccessoriesObject:dipsBar];
    [bicepCurls addAccessoriesObject:dumbells];
    
    
    // create available excerciess and accessories arrays
    
    NSFetchRequest *excercisesRequest = [NSFetchRequest fetchRequestWithEntityName:@"Excercise"];
    NSFetchRequest *accessoriesRequest = [NSFetchRequest fetchRequestWithEntityName:@"Accessory"];
    
    self.availableExcercises = [self.managedObjectContext executeFetchRequest:excercisesRequest error:nil];
    self.availableAccessories = [self.managedObjectContext executeFetchRequest:accessoriesRequest error:nil];
    
}






@end
