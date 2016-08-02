//
//  CalendarMonth.h
//  RealDudesWorkout
//
//  Created by Brian Clouser on 7/3/16.
//  Copyright © 2016 The Qwiz LLC. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface CalendarMonth : UIView

@property (nonatomic) NSInteger monthAdditionToNow;

-(NSString *)monthFromDate;
-(NSString *)numberOfWorkoutsLabel;
-(NSString *)totalTimeLabel;
-(BOOL)monthIsSquare;

@end
