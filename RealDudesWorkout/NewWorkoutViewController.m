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

@property (weak, nonatomic) IBOutlet UILabel *workoutDurationLabel;
@property (weak, nonatomic) IBOutlet UISlider *slider;
@property (weak, nonatomic) IBOutlet UILabel *accessToLabel;


@property (strong, nonatomic) Workout *workout;

@property (strong, nonatomic) NSArray *accessories;

@end

@implementation NewWorkoutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    self.dataStore = [DataStore sharedDataStore];
//    
//    self.accessories = self.dataStore.availableAccessories;
//    
//    NSLog(@"self.accessories count is %lu", self.dataStore.availableAccessories.count);
    
//    self.accessoryTopLeft.accessory = self.accessories[0];
//    self.accessoryTopRight.accessory = self.accessories[1];
//    self.accessoryMiddleLeft.accessory = self.accessories[2];
//    self.accessoryMiddleRight.accessory = self.accessories[3];
//    self.accessoryBottomLeft.accessory = self.accessories[4];
//    self.accessoryBottomRight.accessory = self.accessories[5];
//    
//    self.workoutDurationLabel.text = @"I want to work out for 40 minutes";
//    
//    self.accessoryBottomRight.layer.cornerRadius = 5;
//    self.accessoryBottomRight.layer.masksToBounds = YES;
//    
//    self.accessoryBottomLeft.layer.cornerRadius = 5;
//    self.accessoryBottomLeft.layer.masksToBounds = YES;
//    
//    self.accessoryMiddleRight.layer.cornerRadius = 5;
//    self.accessoryMiddleRight.layer.masksToBounds = YES;
//    
//    self.accessoryMiddleLeft.layer.cornerRadius = 5;
//    self.accessoryMiddleLeft.layer.masksToBounds = YES;
//    
//    self.accessoryTopRight.layer.cornerRadius = 5;
//    self.accessoryTopRight.layer.masksToBounds = YES;
//    
//    self.accessoryTopLeft.layer.cornerRadius = 5;
//    self.accessoryTopLeft.layer.masksToBounds = YES;
//    
    
    
    
    
    
    
//}
//- (IBAction)topLeftAccessoryTapped:(id)sender
//{
//     NSLog(@"we're getting touched");
//    self.accessoryTopLeft.timesTouched = self.accessoryTopLeft.timesTouched + 1;
//   
//}
//- (IBAction)topRightAccessoryTapped:(id)sender
//{
//    self.accessoryTopRight.timesTouched++;
//}
//- (IBAction)middleLeftAccessoryTapped:(id)sender
//{
//    self.accessoryMiddleLeft.timesTouched++;
//}
//
//- (IBAction)middleRightAccessoryTapped:(id)sender
//{
//    self.accessoryMiddleRight.timesTouched++;
//}
//
//- (IBAction)bottomLeftView:(id)sender
//{
//    self.accessoryBottomLeft.timesTouched++;
//}
//- (IBAction)bottomRightAccessoryTapped:(id)sender
//{
//    self.accessoryBottomRight.timesTouched++;
//}
//
//- (IBAction)sliderMoved:(id)sender
//{
//    CGFloat RoundedValue =  roundf(self.slider.value);
//    
//    CGFloat floatValueRounded = roundf(RoundedValue / 10.0) * 10.0;
//    
//    NSUInteger LabelValue = floatValueRounded / 1;
//    
//    NSString *label = [NSString stringWithFormat:@"I want to work out for %lu minutes",LabelValue];
//    
//    self.workoutDurationLabel.text = label;
//    
//}






#pragma mark - Navigation

//
//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
//{
//    
//    
//    self.workout = [self.dataStore.user generateNewWorkout];
//    
//
//}
}


@end
