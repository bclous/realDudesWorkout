//
//  WorkoutOnBoardView.h
//  RealDudesWorkout
//
//  Created by Brian Clouser on 5/20/16.
//  Copyright © 2016 The Qwiz LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AccessoryOnBoardView.h"

@protocol WorkoutOnBoardDelegate <NSObject>

-(void)generateWorkoutTapped:(NSInteger)minutes accessories:(NSMutableArray *)accessories level:(NSInteger)level;

@end

@interface WorkoutOnBoardView : UIView

@property (weak, nonatomic) id <WorkoutOnBoardDelegate> delegate;

-(void)resetView;


@end
