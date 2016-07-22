//
//  ExcerciseRestView.h
//  RealDudesWorkout
//
//  Created by Brian Clouser on 5/23/16.
//  Copyright © 2016 The Qwiz LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ExcerciseSet.h"

@interface ExcerciseRestView : UIView

@property (strong, nonatomic) ExcerciseSet *excerciseSet;
@property (nonatomic) BOOL isNext;
@property (weak, nonatomic) IBOutlet UIView *doneView;
@property (weak, nonatomic) IBOutlet UIImageView *checkImage;

-(void)adjustFormatFinished:(BOOL)finished;

@end
