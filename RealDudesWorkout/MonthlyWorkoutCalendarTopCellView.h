//
//  MonthlyWorkoutCalendarTopCellView.h
//  RealDudesWorkout
//
//  Created by Brian Clouser on 7/3/16.
//  Copyright © 2016 The Qwiz LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CalendarMonth.h"

@interface MonthlyWorkoutCalendarTopCellView : UIView
@property (nonatomic) NSInteger monthOffset;

-(void)transitionToScrollingView;
-(void)transitionToStaticView;

@end
