//
//  RestView2.h
//  RealDudesWorkout
//
//  Created by Brian Clouser on 5/23/16.
//  Copyright © 2016 The Qwiz LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Workout.h"
#import "WorkoutOverRestView.h"

@protocol RestViewDelegate <NSObject>

-(void)restIsOver;

@end

@interface RestView2 : UIView

@property (strong, nonatomic) Workout *workout;
@property (weak, nonatomic) id <RestViewDelegate> delegate;
@property (nonatomic) NSUInteger indexOfExcerciseJustFinished;
@property (nonatomic) NSUInteger indexOfExerciseUpNext;
@property (nonatomic) BOOL workoutOver;
@property (weak, nonatomic) IBOutlet WorkoutOverRestView *workoutOverView;

-(void)countdown;
-(void)updateRestViewComponentsForIndex:(NSUInteger)index;


@end
