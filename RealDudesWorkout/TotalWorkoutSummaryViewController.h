//
//  TotalWorkoutSummaryViewController.h
//  RealDudesWorkout
//
//  Created by Brian Clouser on 4/2/16.
//  Copyright © 2016 The Qwiz LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TotalWorkoutSummaryViewController : UIViewController

@property (strong, nonatomic) NSArray *workoutsSinceSetDay;
@property (strong, nonatomic) NSArray *workoutsSinceTimeInterval;
@property (strong, nonatomic) NSString *timePeriod;

@end
