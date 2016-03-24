//
//  ExcerciseView.h
//  RealDudesWorkout
//
//  Created by Brian Clouser on 3/20/16.
//  Copyright © 2016 The Qwiz LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ExcerciseSet.h"

@interface ExcerciseView : UIView

@property (strong, nonatomic) ExcerciseSet *excerciseSet;

-(void)changeBackgroundColor;


@end
