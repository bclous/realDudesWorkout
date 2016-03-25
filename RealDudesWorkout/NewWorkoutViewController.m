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
#import "AccessoryWithNameView.h"

@interface NewWorkoutViewController ()

@property (weak, nonatomic) IBOutlet UIButton *startWorkoutButton;
@property (strong, nonatomic) Workout *workout;
@property (weak, nonatomic) IBOutlet UILabel *workoutDurationLabel;
@property (weak, nonatomic) IBOutlet UISlider *slider;
@property (weak, nonatomic) IBOutlet UILabel *accessToLabel;
@property (weak, nonatomic) IBOutlet AccessoryWithNameView *accessoryTopLeft;
@property (weak, nonatomic) IBOutlet AccessoryWithNameView *accessoryTopRight;
@property (weak, nonatomic) IBOutlet AccessoryWithNameView *accessoryMiddleLeft;
@property (weak, nonatomic) IBOutlet AccessoryWithNameView *accessoryMiddleRight;
@property (weak, nonatomic) IBOutlet AccessoryWithNameView *accessoryBottomLeft;
@property (weak, nonatomic) IBOutlet AccessoryWithNameView *accessoryBottomRight;

@property (strong, nonatomic) NSArray *accessories;

@end

@implementation NewWorkoutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.dataStore = [DataStore sharedDataStore];
    
    self.accessories = self.dataStore.availableAccessories;
    
    self.accessoryTopLeft.accessory = self.accessories[0];
    self.accessoryTopRight.accessory = self.accessories[0];
    self.accessoryMiddleLeft.accessory = self.accessories[0];
    self.accessoryMiddleRight.accessory = self.accessories[0];
    self.accessoryBottomLeft.accessory = self.accessories[0];
    self.accessoryBottomRight.accessory = self.accessories[0];
    
    
    
    
    
}
- (IBAction)topLeftAccessoryTapped:(id)sender
{
     NSLog(@"we're getting touched");
    self.accessoryTopLeft.timesTouched = self.accessoryTopLeft.timesTouched + 1;
   
}
- (IBAction)topRightAccessoryTapped:(id)sender
{
    self.accessoryTopRight.timesTouched++;
}
- (IBAction)middleLeftAccessoryTapped:(id)sender
{
    self.accessoryMiddleLeft.timesTouched++;
}

- (IBAction)middleRightAccessoryTapped:(id)sender
{
    self.accessoryMiddleRight.timesTouched++;
}

- (IBAction)bottomLeftView:(id)sender
{
    self.accessoryBottomLeft.timesTouched++;
}
- (IBAction)bottomRightAccessoryTapped:(id)sender
{
    self.accessoryBottomRight.timesTouched++;
}







#pragma mark - Navigation


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    
    self.workout = [self.dataStore.user generateNewWorkout];
    

}



@end
