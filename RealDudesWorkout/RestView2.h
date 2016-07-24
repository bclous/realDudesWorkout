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

-(void)countdown;
-(void)generateExerciseStackView;
-(void)updateScrollViewToIndex:(NSUInteger)index animate:(BOOL)animate;
-(void)updateForExerciseFinishedAtIndex:(NSUInteger)index;
-(void)updateExerciseViewAtIndex:(NSUInteger)index status:(NSUInteger)status;
-(void)updateRestViewComponentsForIndex:(NSUInteger)index;

@end
