//
//  SkipExerciseView.h
//  RealDudesWorkout
//
//  Created by Brian Clouser on 7/22/16.
//  Copyright © 2016 The Qwiz LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SkipExerciseViewDelegate <NSObject>

-(void)buttonTapped:(NSInteger)buttonIndex;

@end

@interface SkipExerciseView : UIView

@property (weak, nonatomic) id <SkipExerciseViewDelegate> delegate;

@end
