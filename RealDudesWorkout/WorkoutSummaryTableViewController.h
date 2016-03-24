//
//  WorkoutSummaryTableViewController.h
//  RealDudesWorkout
//
//  Created by Brian Clouser on 3/23/16.
//  Copyright © 2016 The Qwiz LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Workout.h"


@interface WorkoutSummaryTableViewController : UITableViewController

@property (strong, nonatomic) Workout *workout;

@end
