//
//  ExerciseDescriptionView.h
//  RealDudesWorkout
//
//  Created by Brian Clouser on 6/6/16.
//  Copyright © 2016 The Qwiz LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ExcerciseSet.h"

@protocol ExerciseDescriptionDelegate <NSObject>

-(void)leaveDescriptionViewTapped;

@end

@interface ExerciseDescriptionView : UIView

@property (weak, nonatomic) id <ExerciseDescriptionDelegate> delegate;
@property (strong, nonatomic) ExcerciseSet *excerciseSet;

@end
