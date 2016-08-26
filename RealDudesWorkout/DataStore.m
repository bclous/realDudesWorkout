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



-(void)createUser
{
    User *user = [NSEntityDescription insertNewObjectForEntityForName:@"User" inManagedObjectContext:self.managedObjectContext];
    
    user.name = @"Workout Bro";
    user.backLevel = 0;
    user.chestLevel = 0;
    user.legsLevel = 0;
    user.coreLevel = 0;
    user.flexLevel = 0;
    user.downloadDate = [[NSDate date] timeIntervalSince1970];
    
    self.user = user;
    
   [self saveContext];
    
    
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
    
    self.maxWorkoutNumber = 0;
    
    // create accessories

    Accessory *pullupBar = [NSEntityDescription insertNewObjectForEntityForName:@"Accessory" inManagedObjectContext:self.managedObjectContext];
    Accessory *dipsBar = [NSEntityDescription insertNewObjectForEntityForName:@"Accessory" inManagedObjectContext:self.managedObjectContext];
    Accessory *bench = [NSEntityDescription insertNewObjectForEntityForName:@"Accessory" inManagedObjectContext:self.managedObjectContext];
    Accessory *latPullDownMachine = [NSEntityDescription insertNewObjectForEntityForName:@"Accessory" inManagedObjectContext:self.managedObjectContext];
    Accessory *dumbells = [NSEntityDescription insertNewObjectForEntityForName:@"Accessory" inManagedObjectContext:self.managedObjectContext];
    Accessory *backExtensionMachine = [NSEntityDescription insertNewObjectForEntityForName:@"Accessory" inManagedObjectContext:self.managedObjectContext];
    
    // setting up accessories
    
    pullupBar.name = @"Pullup bar";
    pullupBar.pictureName = @"pullUpBar";
    
    dipsBar.name = @"Dips bar";
    dipsBar.pictureName = @"dipsBar";
    
    bench.name = @"Bench";
    bench.pictureName = @"bench";
    
    backExtensionMachine.name = @"Back Extension";
    backExtensionMachine.pictureName = @"lowerBackExtensionStructure";
    
    dumbells.name = @"Dumbells";
    dumbells.pictureName = @"dumbbell";
    
    latPullDownMachine.name = @"Lat pull down";
    latPullDownMachine.pictureName = @"latPullDownMachine";
    
     // create excercises

    Excercise *altArmLegPlank = [NSEntityDescription insertNewObjectForEntityForName:@"Excercise" inManagedObjectContext:self.managedObjectContext];
    altArmLegPlank.name = @"Alt Arm/Leg Plank";
    altArmLegPlank.pictureName = @"altArmLegPlank";
    altArmLegPlank.excerciseDescription = @"altArmLegPlank";
    altArmLegPlank.category = @"back";
    altArmLegPlank.isReps = YES;
    altArmLegPlank.repsLevel1 = 10;
    altArmLegPlank.repsLevel2 = 15;
    altArmLegPlank.repsLevel3 = 20;
    altArmLegPlank.timeLevel1 = 0;
    altArmLegPlank.timeLevel2 = 0;
    altArmLegPlank.timeLevel3 = 0;
    altArmLegPlank.isPriority = NO;
    
    
    Excercise *bicepCurls = [NSEntityDescription insertNewObjectForEntityForName:@"Excercise" inManagedObjectContext:self.managedObjectContext];
    bicepCurls.name = @"Bicep Curls";
    bicepCurls.pictureName = @"bicepCurls";
    bicepCurls.excerciseDescription = @"bicepCurls";
    bicepCurls.category = @"back";
    bicepCurls.isReps = YES;
    bicepCurls.repsLevel1 = 6;
    bicepCurls.repsLevel2 = 10;
    bicepCurls.repsLevel3 = 12;
    bicepCurls.timeLevel1 = 0;
    bicepCurls.timeLevel2 = 0;
    bicepCurls.timeLevel3 = 0;
    [bicepCurls addAccessoriesObject:dumbells];
    bicepCurls.isPriority = YES;
    
   
    Excercise *doorframeRows = [NSEntityDescription insertNewObjectForEntityForName:@"Excercise" inManagedObjectContext:self.managedObjectContext];
    doorframeRows.name = @"Doorframe Rows";
    doorframeRows.pictureName = @"doorframeRows";
    doorframeRows.excerciseDescription = @"doorframeRows";
    doorframeRows.category = @"back";
    doorframeRows.isReps = YES;
    doorframeRows.repsLevel1 = 6;
    doorframeRows.repsLevel2 = 10;
    doorframeRows.repsLevel3 = 12;
    doorframeRows.timeLevel1 = 0;
    doorframeRows.timeLevel2 = 0;
    doorframeRows.timeLevel3 = 0;
    doorframeRows.isPriority = NO;
    
    Excercise *elbowLifts = [NSEntityDescription insertNewObjectForEntityForName:@"Excercise" inManagedObjectContext:self.managedObjectContext];
    elbowLifts.name = @"Elbow Lifts";
    elbowLifts.pictureName = @"elbowLifts";
    elbowLifts.excerciseDescription = @"elbowLifts";
    elbowLifts.category = @"back";
    elbowLifts.isReps = YES;
    elbowLifts.repsLevel1 = 8;
    elbowLifts.repsLevel2 = 10;
    elbowLifts.repsLevel3 = 12;
    elbowLifts.timeLevel1 = 0;
    elbowLifts.timeLevel2 = 0;
    elbowLifts.timeLevel3 = 0;
    elbowLifts.isPriority = NO;
    
    
    Excercise *bridges = [NSEntityDescription insertNewObjectForEntityForName:@"Excercise" inManagedObjectContext:self.managedObjectContext];
    bridges.name = @"Bridges";
    bridges.pictureName = @"bridges";
    bridges.excerciseDescription = @"bridges";
    bridges.category = @"back";
    bridges.isReps = YES;
    bridges.repsLevel1 = 8;
    bridges.repsLevel2 = 12;
    bridges.repsLevel3 = 15;
    bridges.timeLevel1 = 0;
    bridges.timeLevel2 = 0;
    bridges.timeLevel3 = 0;
    bridges.isPriority = NO;
    

    Excercise *latPullDowns = [NSEntityDescription insertNewObjectForEntityForName:@"Excercise" inManagedObjectContext:self.managedObjectContext];
    latPullDowns.name = @"Lat Pull Downs";
    latPullDowns.pictureName = @"latPullDowns";
    latPullDowns.excerciseDescription = @"latPullDowns";
    latPullDowns.category = @"back";
    latPullDowns.isReps = YES;
    latPullDowns.repsLevel1 = 8;
    latPullDowns.repsLevel2 = 10;
    latPullDowns.repsLevel3 = 14;
    latPullDowns.timeLevel1 = 0;
    latPullDowns.timeLevel2 = 0;
    latPullDowns.timeLevel3 = 0;
    [latPullDowns addAccessoriesObject:latPullDownMachine];
    latPullDowns.isPriority = YES;
    
    Excercise *lowerBackExtensions = [NSEntityDescription insertNewObjectForEntityForName:@"Excercise" inManagedObjectContext:self.managedObjectContext];
    lowerBackExtensions.name = @"Lower Back Extensions";
    lowerBackExtensions.pictureName = @"lowerBackExtensions";
    lowerBackExtensions.excerciseDescription = @"lowerBackExtensions";
    lowerBackExtensions.category = @"back";
    lowerBackExtensions.isReps = YES;
    lowerBackExtensions.repsLevel1 = 8;
    lowerBackExtensions.repsLevel2 = 10;
    lowerBackExtensions.repsLevel3 = 15;
    lowerBackExtensions.timeLevel1 = 0;
    lowerBackExtensions.timeLevel2 = 0;
    lowerBackExtensions.timeLevel3 = 0;
    lowerBackExtensions.isPriority = NO;
    [lowerBackExtensions addAccessoriesObject:backExtensionMachine];
   
    Excercise *pullups = [NSEntityDescription insertNewObjectForEntityForName:@"Excercise" inManagedObjectContext:self.managedObjectContext];
    pullups.name = @"Pullups";
    pullups.pictureName = @"pullups";
    pullups.excerciseDescription = @"pullups";
    pullups.category = @"back";
    pullups.isReps = YES;
    pullups.repsLevel1 = 6;
    pullups.repsLevel2 = 8;
    pullups.repsLevel3 = 12;
    pullups.timeLevel1 = 0;
    pullups.timeLevel2 = 0;
    pullups.timeLevel3 = 0;
    pullups.isPriority = YES;
    [pullups addAccessoriesObject:pullupBar];
    
    Excercise *starPlank = [NSEntityDescription insertNewObjectForEntityForName:@"Excercise" inManagedObjectContext:self.managedObjectContext];
    starPlank.name = @"Star Plank";
    starPlank.pictureName = @"starPlank";
    starPlank.excerciseDescription = @"starPlank";
    starPlank.category = @"back";
    starPlank.isReps = NO;
    starPlank.repsLevel1 = 0;
    starPlank.repsLevel2 = 0;
    starPlank.repsLevel3 = 0;
    starPlank.timeLevel1 = 60;
    starPlank.timeLevel2 = 60;
    starPlank.timeLevel3 = 75;
    starPlank.isPriority = NO;
    
    Excercise *supermans = [NSEntityDescription insertNewObjectForEntityForName:@"Excercise" inManagedObjectContext:self.managedObjectContext];
    supermans.name = @"Supermans";
    supermans.pictureName = @"supermans";
    supermans.excerciseDescription = @"supermans";
    supermans.category = @"back";
    supermans.isReps = YES;
    supermans.repsLevel1 = 10;
    supermans.repsLevel2 = 12;
    supermans.repsLevel3 = 15;
    supermans.timeLevel1 = 0;
    supermans.timeLevel2 = 0;
    supermans.timeLevel3 = 0;
    supermans.isPriority = NO;
    
    Excercise *chestSqueezes = [NSEntityDescription insertNewObjectForEntityForName:@"Excercise" inManagedObjectContext:self.managedObjectContext];
    chestSqueezes.name = @"Chest Squeezes";
    chestSqueezes.pictureName = @"chestSqueezes";
    chestSqueezes.excerciseDescription = @"chestSqueezes";
    chestSqueezes.category = @"chest";
    chestSqueezes.isReps = NO;
    chestSqueezes.repsLevel1 = 0;
    chestSqueezes.repsLevel2 = 0;
    chestSqueezes.repsLevel3 = 0;
    chestSqueezes.timeLevel1 = 45;
    chestSqueezes.timeLevel2 = 60;
    chestSqueezes.timeLevel3 = 60;
    chestSqueezes.isPriority = NO;
    
    Excercise *clapPushups = [NSEntityDescription insertNewObjectForEntityForName:@"Excercise" inManagedObjectContext:self.managedObjectContext];
    clapPushups.name = @"Clap Pushups";
    clapPushups.pictureName = @"clapPushups";
    clapPushups.excerciseDescription = @"clapPushups";
    clapPushups.category = @"chest";
    clapPushups.isReps = YES;
    clapPushups.repsLevel1 = 0;
    clapPushups.repsLevel2 = 8;
    clapPushups.repsLevel3 = 15;
    clapPushups.timeLevel1 = 0;
    clapPushups.timeLevel2 = 0;
    clapPushups.timeLevel3 = 0;
    clapPushups.isPriority = YES;
    
    Excercise *crawlDownPushups = [NSEntityDescription insertNewObjectForEntityForName:@"Excercise" inManagedObjectContext:self.managedObjectContext];
    crawlDownPushups.name = @"Crawl Down Pushups";
    crawlDownPushups.pictureName = @"crawlDownPushups";
    crawlDownPushups.excerciseDescription = @"crawlDownPushups";
    crawlDownPushups.category = @"chest";
    crawlDownPushups.isReps = YES;
    crawlDownPushups.repsLevel1 = 0;
    crawlDownPushups.repsLevel2 = 10;
    crawlDownPushups.repsLevel3 = 15;
    crawlDownPushups.timeLevel1 = 0;
    crawlDownPushups.timeLevel2 = 0;
    crawlDownPushups.timeLevel3 = 0;
    crawlDownPushups.isPriority = YES;
    
    Excercise *dips = [NSEntityDescription insertNewObjectForEntityForName:@"Excercise" inManagedObjectContext:self.managedObjectContext];
    dips.name = @"Dips";
    dips.pictureName = @"dips";
    dips.excerciseDescription = @"dips";
    dips.category = @"chest";
    dips.isReps = YES;
    dips.repsLevel1 = 0;
    dips.repsLevel2 = 8;
    dips.repsLevel3 = 15;
    dips.timeLevel1 = 0;
    dips.timeLevel2 = 0;
    dips.timeLevel3 = 0;
    dips.isPriority = YES;
    [dips addAccessoriesObject:dipsBar];
    
    Excercise *benchWithDumbells = [NSEntityDescription insertNewObjectForEntityForName:@"Excercise" inManagedObjectContext:self.managedObjectContext];
    benchWithDumbells.name = @"Bench With Dumbells";
    benchWithDumbells.pictureName = @"benchWithDumbells";
    benchWithDumbells.excerciseDescription = @"benchWithDumbells";
    benchWithDumbells.category = @"chest";
    benchWithDumbells.isReps = YES;
    benchWithDumbells.repsLevel1 = 8;
    benchWithDumbells.repsLevel2 = 10;
    benchWithDumbells.repsLevel3 = 14;
    benchWithDumbells.timeLevel1 = 0;
    benchWithDumbells.timeLevel2 = 0;
    benchWithDumbells.timeLevel3 = 0;
    benchWithDumbells.isPriority = YES;
    [benchWithDumbells addAccessoriesObject:dumbells];
    [benchWithDumbells addAccessoriesObject:bench];

    Excercise *dipsOnBench = [NSEntityDescription insertNewObjectForEntityForName:@"Excercise" inManagedObjectContext:self.managedObjectContext];
    dipsOnBench.name = @"Dips On Bench";
    dipsOnBench.pictureName = @"dipsOnBench";
    dipsOnBench.excerciseDescription = @"dipsOnBench";
    dipsOnBench.category = @"chest";
    dipsOnBench.isReps = YES;
    dipsOnBench.repsLevel1 = 15;
    dipsOnBench.repsLevel2 = 30;
    dipsOnBench.repsLevel3 = 0;
    dipsOnBench.timeLevel1 = 0;
    dipsOnBench.timeLevel2 = 0;
    dipsOnBench.timeLevel3 = 0;
    dipsOnBench.isPriority = NO;
    [dipsOnBench addAccessoriesObject:bench];
    
    Excercise *plankRotationsWithPushup = [NSEntityDescription insertNewObjectForEntityForName:@"Excercise" inManagedObjectContext:self.managedObjectContext];
    plankRotationsWithPushup.name = @"Plank Rotations With Pushup";
    plankRotationsWithPushup.pictureName = @"plankRotationsWithPushup";
    plankRotationsWithPushup.excerciseDescription = @"plankRotationsWithPushup";
    plankRotationsWithPushup.category = @"full";
    plankRotationsWithPushup.isReps = YES;
    plankRotationsWithPushup.repsLevel1 = 0;
    plankRotationsWithPushup.repsLevel2 = 10;
    plankRotationsWithPushup.repsLevel3 = 18;
    plankRotationsWithPushup.timeLevel1 = 0;
    plankRotationsWithPushup.timeLevel2 = 0;
    plankRotationsWithPushup.timeLevel3 = 0;
    plankRotationsWithPushup.isPriority = YES;
    
    Excercise *pushups = [NSEntityDescription insertNewObjectForEntityForName:@"Excercise" inManagedObjectContext:self.managedObjectContext];
    pushups.name = @"Pushups";
    pushups.pictureName = @"pushups";
    pushups.excerciseDescription = @"pushups";
    pushups.category = @"chest";
    pushups.isReps = YES;
    pushups.repsLevel1 = 15;
    pushups.repsLevel2 = 30;
    pushups.repsLevel3 = 40;
    pushups.timeLevel1 = 0;
    pushups.timeLevel2 = 0;
    pushups.timeLevel3 = 0;
    pushups.isPriority = YES;
    
    
    Excercise *bicycleCrunches = [NSEntityDescription insertNewObjectForEntityForName:@"Excercise" inManagedObjectContext:self.managedObjectContext];
    bicycleCrunches.name = @"Bicycle Crunches";
    bicycleCrunches.pictureName = @"bicycleCrunches";
    bicycleCrunches.excerciseDescription = @"bicycleCrunches";
    bicycleCrunches.category = @"core";
    bicycleCrunches.isReps = YES;
    bicycleCrunches.repsLevel1 = 30;
    bicycleCrunches.repsLevel2 = 40;
    bicycleCrunches.repsLevel3 = 50;
    bicycleCrunches.timeLevel1 = 0;
    bicycleCrunches.timeLevel2 = 0;
    bicycleCrunches.timeLevel3 = 0;
    bicycleCrunches.isPriority = YES;
    
    Excercise *flutterKicks = [NSEntityDescription insertNewObjectForEntityForName:@"Excercise" inManagedObjectContext:self.managedObjectContext];
    flutterKicks.name = @"Flutter Kicks";
    flutterKicks.pictureName = @"flutterKicks";
    flutterKicks.excerciseDescription = @"flutterKicks";
    flutterKicks.category = @"core";
    flutterKicks.isReps = YES;
    flutterKicks.repsLevel1 = 30;
    flutterKicks.repsLevel2 = 40;
    flutterKicks.repsLevel3 = 50;
    flutterKicks.timeLevel1 = 0;
    flutterKicks.timeLevel2 = 0;
    flutterKicks.timeLevel3 = 0;
    flutterKicks.isPriority = YES;
    
    
    Excercise *sideCrunches = [NSEntityDescription insertNewObjectForEntityForName:@"Excercise" inManagedObjectContext:self.managedObjectContext];
    sideCrunches.name = @"Side Crunches";
    sideCrunches.pictureName = @"sideCrunches";
    sideCrunches.excerciseDescription = @"sideCrunches";
    sideCrunches.category = @"core";
    sideCrunches.isReps = YES;
    sideCrunches.repsLevel1 = 15;
    sideCrunches.repsLevel2 = 20;
    sideCrunches.repsLevel3 = 20;
    sideCrunches.timeLevel1 = 0;
    sideCrunches.timeLevel2 = 0;
    sideCrunches.timeLevel3 = 0;
    sideCrunches.isPriority = NO;
 
    Excercise *mountainClimbers = [NSEntityDescription insertNewObjectForEntityForName:@"Excercise" inManagedObjectContext:self.managedObjectContext];
    mountainClimbers.name = @"Mountain Climbers";
    mountainClimbers.pictureName = @"mountainClimbers";
    mountainClimbers.excerciseDescription = @"mountainClimbers";
    mountainClimbers.category = @"core";
    mountainClimbers.isReps = YES;
    mountainClimbers.repsLevel1 = 30;
    mountainClimbers.repsLevel2 = 40;
    mountainClimbers.repsLevel3 = 50;
    mountainClimbers.timeLevel1 = 0;
    mountainClimbers.timeLevel2 = 0;
    mountainClimbers.timeLevel3 = 0;
    mountainClimbers.isPriority = YES;
    

    Excercise *plank = [NSEntityDescription insertNewObjectForEntityForName:@"Excercise" inManagedObjectContext:self.managedObjectContext];
    plank.name = @"Plank";
    plank.pictureName = @"plank";
    plank.excerciseDescription = @"plank";
    plank.category = @"core";
    plank.isReps = NO;
    plank.repsLevel1 = 60;
    plank.repsLevel2 = 60;
    plank.repsLevel3 = 60;
    plank.timeLevel1 = 0;
    plank.timeLevel2 = 0;
    plank.timeLevel3 = 0;
    plank.isPriority = YES;
    
  
    Excercise *plankRotations = [NSEntityDescription insertNewObjectForEntityForName:@"Excercise" inManagedObjectContext:self.managedObjectContext];
    plankRotations.name = @"Plank Rotations";
    plankRotations.pictureName = @"plankRotations";
    plankRotations.excerciseDescription = @"plankRotations";
    plankRotations.category = @"core";
    plankRotations.isReps = YES;
    plankRotations.repsLevel1 = 10;
    plankRotations.repsLevel2 = 15;
    plankRotations.repsLevel3 = 20;
    plankRotations.timeLevel1 = 0;
    plankRotations.timeLevel2 = 0;
    plankRotations.timeLevel3 = 0;
    plankRotations.isPriority = NO;
    
    Excercise *shoulderTaps = [NSEntityDescription insertNewObjectForEntityForName:@"Excercise" inManagedObjectContext:self.managedObjectContext];
    shoulderTaps.name = @"Shoulder Taps";
    shoulderTaps.pictureName = @"shoulderTaps";
    shoulderTaps.excerciseDescription = @"shoulderTaps";
    shoulderTaps.category = @"core";
    shoulderTaps.isReps = YES;
    shoulderTaps.repsLevel1 = 20;
    shoulderTaps.repsLevel2 = 30;
    shoulderTaps.repsLevel3 = 40;
    shoulderTaps.timeLevel1 = 0;
    shoulderTaps.timeLevel2 = 0;
    shoulderTaps.timeLevel3 = 0;
    shoulderTaps.isPriority = YES;
    
    Excercise *childsPose = [NSEntityDescription insertNewObjectForEntityForName:@"Excercise" inManagedObjectContext:self.managedObjectContext];
    childsPose.name = @"Childs Pose";
    childsPose.pictureName = @"childsPose";
    childsPose.excerciseDescription = @"childsPose";
    childsPose.category = @"flex";
    childsPose.isReps = NO;
    childsPose.repsLevel1 = 0;
    childsPose.repsLevel2 = 0;
    childsPose.repsLevel3 = 0;
    childsPose.timeLevel1 = 60;
    childsPose.timeLevel2 = 60;
    childsPose.timeLevel3 = 60;
    childsPose.isPriority = YES;

    Excercise *downDog = [NSEntityDescription insertNewObjectForEntityForName:@"Excercise" inManagedObjectContext:self.managedObjectContext];
    downDog.name = @"Down Dog";
    downDog.pictureName = @"downDog";
    downDog.excerciseDescription = @"downDog";
    downDog.category = @"flex";
    downDog.isReps = NO;
    downDog.repsLevel1 = 0;
    downDog.repsLevel2 = 0;
    downDog.repsLevel3 = 0;
    downDog.timeLevel1 = 60;
    downDog.timeLevel2 = 60;
    downDog.timeLevel3 = 60;
    downDog.isPriority = YES;
    
    Excercise *touchToes = [NSEntityDescription insertNewObjectForEntityForName:@"Excercise" inManagedObjectContext:self.managedObjectContext];
    touchToes.name = @"Touch Toes";
    touchToes.pictureName = @"touchToes";
    touchToes.excerciseDescription = @"touchToes";
    touchToes.category = @"flex";
    touchToes.isReps = NO;
    touchToes.repsLevel1 = 0;
    touchToes.repsLevel2 = 0;
    touchToes.repsLevel3 = 0;
    touchToes.timeLevel1 = 60;
    touchToes.timeLevel2 = 60;
    touchToes.timeLevel3 = 60;
    touchToes.isPriority = YES;
    
    Excercise *burpees = [NSEntityDescription insertNewObjectForEntityForName:@"Excercise" inManagedObjectContext:self.managedObjectContext];
    burpees.name = @"Burpees";
    burpees.pictureName = @"burpees";
    burpees.excerciseDescription = @"burpees";
    burpees.category = @"full";
    burpees.isReps = YES;
    burpees.repsLevel1 = 8;
    burpees.repsLevel2 = 12;
    burpees.repsLevel3 = 15;
    burpees.timeLevel1 = 0;
    burpees.timeLevel2 = 0;
    burpees.timeLevel3 = 0;
    burpees.isPriority = YES;
    
    Excercise *burpeesWithPushup = [NSEntityDescription insertNewObjectForEntityForName:@"Excercise" inManagedObjectContext:self.managedObjectContext];
    burpeesWithPushup.name = @"Burpees With Pushup";
    burpeesWithPushup.pictureName = @"burpeesWithPushup";
    burpeesWithPushup.excerciseDescription = @"burpeesWithPushup";
    burpeesWithPushup.category = @"full";
    burpeesWithPushup.isReps = YES;
    burpeesWithPushup.repsLevel1 = 5;
    burpeesWithPushup.repsLevel2 = 10;
    burpeesWithPushup.repsLevel3 = 15;
    burpeesWithPushup.timeLevel1 = 0;
    burpeesWithPushup.timeLevel2 = 0;
    burpeesWithPushup.timeLevel3 = 0;
    burpeesWithPushup.isPriority = YES;
    

    Excercise *jumpingJacks = [NSEntityDescription insertNewObjectForEntityForName:@"Excercise" inManagedObjectContext:self.managedObjectContext];
    jumpingJacks.name = @"Jumping Jacks";
    jumpingJacks.pictureName = @"jumpingJacks";
    jumpingJacks.excerciseDescription = @"jumpingJacks";
    jumpingJacks.category = @"full";
    jumpingJacks.isReps = YES;
    jumpingJacks.repsLevel1 = 50;
    jumpingJacks.repsLevel2 = 75;
    jumpingJacks.repsLevel3 = 100;
    jumpingJacks.timeLevel1 = 0;
    jumpingJacks.timeLevel2 = 0;
    jumpingJacks.timeLevel3 = 0;
    jumpingJacks.isPriority = YES;
    

    Excercise *squatMilitaryLift = [NSEntityDescription insertNewObjectForEntityForName:@"Excercise" inManagedObjectContext:self.managedObjectContext];
    squatMilitaryLift.name = @"Squat Military Lift";
    squatMilitaryLift.pictureName = @"squatMilitaryLift";
    squatMilitaryLift.excerciseDescription = @"squatMilitaryLift";
    squatMilitaryLift.category = @"full";
    squatMilitaryLift.isReps = YES;
    squatMilitaryLift.repsLevel1 = 0;
    squatMilitaryLift.repsLevel2 = 8;
    squatMilitaryLift.repsLevel3 = 12;
    squatMilitaryLift.timeLevel1 = 0;
    squatMilitaryLift.timeLevel2 = 0;
    squatMilitaryLift.timeLevel3 = 0;
    squatMilitaryLift.isPriority = YES;
    [squatMilitaryLift addAccessoriesObject:dumbells];
    
    Excercise *lunges = [NSEntityDescription insertNewObjectForEntityForName:@"Excercise" inManagedObjectContext:self.managedObjectContext];
    lunges.name = @"Lunges";
    lunges.pictureName = @"lunges";
    lunges.excerciseDescription = @"lunges";
    lunges.category = @"legs";
    lunges.isReps = YES;
    lunges.repsLevel1 = 8;
    lunges.repsLevel2 = 10;
    lunges.repsLevel3 = 15;
    lunges.timeLevel1 = 0;
    lunges.timeLevel2 = 0;
    lunges.timeLevel3 = 0;
    lunges.isPriority = YES;

    Excercise *lungesWithWeight = [NSEntityDescription insertNewObjectForEntityForName:@"Excercise" inManagedObjectContext:self.managedObjectContext];
    lungesWithWeight.name = @"Lunges With Weight";
    lungesWithWeight.pictureName = @"lungesWithWeight";
    lungesWithWeight.excerciseDescription = @"lungesWithWeight";
    lungesWithWeight.category = @"legs";
    lungesWithWeight.isReps = YES;
    lungesWithWeight.repsLevel1 = 0;
    lungesWithWeight.repsLevel2 = 8;
    lungesWithWeight.repsLevel3 = 14;
    lungesWithWeight.timeLevel1 = 0;
    lungesWithWeight.timeLevel2 = 0;
    lungesWithWeight.timeLevel3 = 0;
    lungesWithWeight.isPriority = YES;
    [lungesWithWeight addAccessoriesObject:dumbells];

    Excercise *squats = [NSEntityDescription insertNewObjectForEntityForName:@"Excercise" inManagedObjectContext:self.managedObjectContext];
    squats.name = @"Squats";
    squats.pictureName = @"squats";
    squats.excerciseDescription = @"squats";
    squats.category = @"legs";
    squats.isReps = YES;
    squats.repsLevel1 = 10;
    squats.repsLevel2 = 12;
    squats.repsLevel3 = 20;
    squats.timeLevel1 = 0;
    squats.timeLevel2 = 0;
    squats.timeLevel3 = 0;
    squats.isPriority = YES;
    
    Excercise *squatsWithWeight = [NSEntityDescription insertNewObjectForEntityForName:@"Excercise" inManagedObjectContext:self.managedObjectContext];
    squatsWithWeight.name = @"Squats With Weight";
    squatsWithWeight.pictureName = @"squatsWithWeight";
    squatsWithWeight.excerciseDescription = @"squatsWithWeight";
    squatsWithWeight.category = @"legs";
    squatsWithWeight.isReps = YES;
    squatsWithWeight.repsLevel1 = 0;
    squatsWithWeight.repsLevel2 = 10;
    squatsWithWeight.repsLevel3 = 14;
    squatsWithWeight.timeLevel1 = 0;
    squatsWithWeight.timeLevel2 = 0;
    squatsWithWeight.timeLevel3 = 0;
    squatsWithWeight.isPriority = YES;
    [squatsWithWeight addAccessoriesObject:dumbells];
    
    Excercise *jumpKneeTucks = [NSEntityDescription insertNewObjectForEntityForName:@"Excercise" inManagedObjectContext:self.managedObjectContext];
    jumpKneeTucks.name = @"Jump Knee Tucks";
    jumpKneeTucks.pictureName = @"jumpKneeTucks";
    jumpKneeTucks.excerciseDescription = @"jumpKneeTucks";
    jumpKneeTucks.category = @"legs";
    jumpKneeTucks.isReps = YES;
    jumpKneeTucks.repsLevel1 = 8;
    jumpKneeTucks.repsLevel2 = 12;
    jumpKneeTucks.repsLevel3 = 15;
    jumpKneeTucks.timeLevel1 = 0;
    jumpKneeTucks.timeLevel2 = 0;
    jumpKneeTucks.timeLevel3 = 0;
    jumpKneeTucks.isPriority = YES;

    
    // create available excerciess and accessories arrays
    
    NSFetchRequest *excercisesRequest = [NSFetchRequest fetchRequestWithEntityName:@"Excercise"];
    NSFetchRequest *accessoriesRequest = [NSFetchRequest fetchRequestWithEntityName:@"Accessory"];
    
    self.availableExcercises = [self.managedObjectContext executeFetchRequest:excercisesRequest error:nil];
    self.availableAccessories = [self.managedObjectContext executeFetchRequest:accessoriesRequest error:nil];
    
}






@end
