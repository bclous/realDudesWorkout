//
//  RestView.h
//  RealDudesWorkout
//
//  Created by Brian Clouser on 3/20/16.
//  Copyright © 2016 The Qwiz LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RestView : UIVisualEffectView

@property (strong, nonatomic) IBOutlet UIView *restView;

@property (weak, nonatomic) IBOutlet UILabel *lastExcerciseRepsLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeInSecondsLabel;

@end
