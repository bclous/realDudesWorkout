//
//  NewWorkoutViewController.m
//  RealDudesWorkout
//
//  Created by Brian Clouser on 3/10/16.
//  Copyright © 2016 The Qwiz LLC. All rights reserved.
//

#import "NewWorkoutViewController.h"
#import "activeWorkoutViewController.h"
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
    
    self.navigationItem.leftBarButtonItem.title = @"asd;lfkjsdaf";
    
    
    

    
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
 
    
    self.workout = [self.dataStore.user generateNewWorkout];
    
    NSArray *circuits = [self.workout.circuits allObjects];
    
    NSLog(@"new workout set up with: %lu circuits, %lu excerciseSets in each circuit",self.workout.circuits.count, ((Circuit *)circuits[0]).excerciseSets.count);
    
    NSLog(@"sending the new workout to the active view controller.  Workout has %lu excercises in it", self.workout.circuits.count);
    
    ActiveWorkoutViewController *destinationVC = segue.destinationViewController;
    
    destinationVC.workout = self.workout;

    
}



@end
