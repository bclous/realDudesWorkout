//
//  RestView2.h
//  RealDudesWorkout
//
//  Created by Brian Clouser on 5/23/16.
//  Copyright © 2016 The Qwiz LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Workout.h"

@interface RestView2 : UIView

@property (strong, nonatomic) Workout *workout;
@property (nonatomic) NSUInteger indexOfExcerciseJustFinished;
@property (weak, nonatomic) IBOutlet UILabel *nextWorkoutLabel;

-(void)countdown;
-(void)generateExerciseStackView;
-(void)updateRestViewComponentsForIndex:(NSUInteger)index;

@end
