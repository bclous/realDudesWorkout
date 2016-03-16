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
#import <FontAwesomeKit/FontAwesomeKit.h>

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



@end
