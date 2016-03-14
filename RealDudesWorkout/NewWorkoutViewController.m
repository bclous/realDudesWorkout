//
//  NewWorkoutViewController.m
//  RealDudesWorkout
//
//  Created by Brian Clouser on 3/10/16.
//  Copyright © 2016 The Qwiz LLC. All rights reserved.
//

#import "NewWorkoutViewController.h"
#import "activeWorkoutViewController.h"
#import "WorkoutGenerator.h"

@interface NewWorkoutViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *leftImage;
@property (weak, nonatomic) IBOutlet UIImageView *rightImage;

@property (weak, nonatomic) IBOutlet UIButton *startWorkoutButton;


@end

@implementation NewWorkoutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.dataStore = [dataStore sharedDataStore];
    

    self.leftImage.image = [UIImage imageNamed:@"dumbbell"];
    self.rightImage.image = [UIImage imageNamed:@"pullUpBar"];
    

    
}
- (IBAction)startWorkoutButtonTapped:(id)sender
{
    
    // create new workout in our core data
    
    NSLog(@"START WORKOUT BUTTON CALLED");
    
 
}



#pragma mark - Navigation


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
   
    NSLog(@"PREPARE TO SEGUE CALLED");
 
    
    WorkoutGenerator *workoutGenerator = [[WorkoutGenerator alloc] init];
    
    self.workout = [workoutGenerator createNewWorkoutStandard];
    
    NSLog(@"sending the new workout to the active view controller.  Workout has %u excercises in it", self.workout.excercises.count);
    
    activeWorkoutViewController *destinationVC = segue.destinationViewController;
    
    destinationVC.workout = self.workout;

    
}

//-(void)createWorkout
//{
//    
//    NSLog(@"in create workout");
//    self.workout = [NSEntityDescription insertNewObjectForEntityForName:@"Workout" inManagedObjectContext:self.dataStore.managedObjectContext];
//    
//    NSLog(@"created new workout in core data");
//    
//    [self.dataStore fetchData];
//    
//    // name and number the workout
//    
//    NSUInteger workoutNumber = self.dataStore.workouts.count;
//    
//    NSString *workoutName = [NSString stringWithFormat:@"Workout #%li",(unsigned long)workoutNumber];
//    
//    self.workout.name = workoutName;
//    
//    
//    //add excercises to workout - can randomize or rotate depending on workout #  THIS WILL PROBABLY BE ITS OWN METHOD ON CREATING THE WORKOUT AND SETTING THE NUMBER OF REPS AND STUFF in fact THIS IS PROBABLY GOING TO ALL GO IN THE WORKOUT CLASS - GENERATING A WORKING BASED ON A FEW ENTRIES LIKE LEVEL AND MAYBE TIME?
//    
//    NSLog(@"just about to add the first excercise to the workout");
//    
//    [self.workout addExcercisesObject:[self ExcerciseFromName:@"Pullups"]];
//    
//    NSLog(@"added the first excercise.  Did we get here?");
//    [self.workout addExcercisesObject:[self ExcerciseFromName:@"Rest"]];
//    [self.workout addExcercisesObject:[self ExcerciseFromName:@"Crawl Down Pushups"]];
//    [self.workout addExcercisesObject:[self ExcerciseFromName:@"Squats"]];
//    [self.workout addExcercisesObject:[self ExcerciseFromName:@"Lower Back Extensions"]];
//    [self.workout addExcercisesObject:[self ExcerciseFromName:@"Leg Kicks"]];
//    [self.workout addExcercisesObject:[self ExcerciseFromName:@"Bicep Curls"]];
//    [self.workout addExcercisesObject:[self ExcerciseFromName:@"Dips"]];
//    [self.workout addExcercisesObject:[self ExcerciseFromName:@"Lunges"]];
//    
//    NSLog(@"finished addding excercises");
//    [self.dataStore fetchData];
//}
//
//-(Excercise *)ExcerciseFromName:(NSString *)name
//{
//    
//    NSLog(@"got into excercise from name method");
//    
//    NSLog(@"%lu excercises in self.datastore.excercises", (unsigned long)self.dataStore.excercises.count);
//    
//    for (Excercise *excercise in self.dataStore.excercises)
//    {
//        
//        NSLog(@"got into the for loop!");
//        BOOL nameMatch = [excercise.name isEqualToString:name];
//        
//        if (nameMatch)
//        {
//            NSLog(@"got into the if statement");
//            return excercise;
//            
//            break;
//        }
//   
//    }
//    
//    return nil;
//}


@end
