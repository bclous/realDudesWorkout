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

-(void)startButtonTapped;

@end

@interface WorkoutOnBoardView : UIView

@property (weak, nonatomic) IBOutlet AccessoryOnBoardView *accessory1;
@property (weak, nonatomic) IBOutlet AccessoryOnBoardView *accessory2;
@property (weak, nonatomic) IBOutlet AccessoryOnBoardView *accessory3;
@property (weak, nonatomic) IBOutlet AccessoryOnBoardView *accessory4;
@property (weak, nonatomic) IBOutlet AccessoryOnBoardView *accessory5;
@property (weak, nonatomic) IBOutlet AccessoryOnBoardView *accessory6;

@property (weak, nonatomic) id <WorkoutOnBoardDelegate> delegate;


@end
