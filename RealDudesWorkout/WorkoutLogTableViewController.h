//
//  WorkoutLogTableViewController.h
//  RealDudesWorkout
//
//  Created by Brian Clouser on 3/17/16.
//  Copyright © 2016 The Qwiz LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataStore.h"

@interface WorkoutLogTableViewController : UITableViewController

@property (strong, nonatomic) DataStore *dataStore;

@end
