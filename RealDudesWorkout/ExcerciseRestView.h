//
//  ExcerciseRestView.h
//  RealDudesWorkout
//
//  Created by Brian Clouser on 5/23/16.
//  Copyright © 2016 The Qwiz LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ExcerciseSet.h"

@protocol ExcerciseRestViewDelegate <NSObject>

-(void)exerciseTappedAtIndex:(NSUInteger)index;
-(NSUInteger)currentIndex;

@end

@interface ExcerciseRestView : UIView

@property (weak, nonatomic) id <ExcerciseRestViewDelegate>delegate;
@property (strong, nonatomic) ExcerciseSet *excerciseSet;
@property (nonatomic) BOOL isNext;
@property (weak, nonatomic) IBOutlet UIView *doneView;
@property (nonatomic) NSUInteger index;

-(void)formatExerciseView;

@end
