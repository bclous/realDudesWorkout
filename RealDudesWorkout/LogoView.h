//
//  LogoView.h
//  RealDudesWorkout
//
//  Created by Brian Clouser on 7/24/16.
//  Copyright © 2016 The Qwiz LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LogoViewDelegate <NSObject>

-(void)animationComplete;

@end

@interface LogoView : UIView

@property (weak, nonatomic) id <LogoViewDelegate> delegate;

-(void)performGenerateWorkoutAnimation;


@end
