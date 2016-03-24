//
//  RestView.h
//  RealDudesWorkout
//
//  Created by Brian Clouser on 3/20/16.
//  Copyright © 2016 The Qwiz LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Workout.h"

@interface RestView : UIVisualEffectView

@property (strong, nonatomic) ExcerciseSet *excerciseSetJustFinished;
@property (strong, nonatomic) ExcerciseSet *excerciseSetUpNext;
@property (strong, nonatomic) Workout *currentWorkout;




/// reminder - your button is in excercise view, so to have it do something to rest view, rest view should be a subview of excercise view, not a subview of the main view controller, that way you can basically just bring it up and back down inside of methods in excerciseView


@end
