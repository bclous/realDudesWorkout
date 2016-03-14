//
//  NewWorkoutViewController.h
//  RealDudesWorkout
//
//  Created by Brian Clouser on 3/10/16.
//  Copyright © 2016 The Qwiz LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "dataStore.h"

@interface NewWorkoutViewController : UIViewController

@property (strong, nonatomic) dataStore *dataStore;
@property (strong, nonatomic) Workout *workout;

@end
