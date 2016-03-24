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

@property (weak, nonatomic) IBOutlet UIButton *startWorkoutButton;
@property (strong, nonatomic) Workout *workout;


@end

@implementation NewWorkoutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.dataStore = [DataStore sharedDataStore];
    
}
- (IBAction)startWorkoutButtonTapped:(id)sender
{
    
    
 
}





#pragma mark - Navigation


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    
    self.workout = [self.dataStore.user generateNewWorkout];
    

}



@end
