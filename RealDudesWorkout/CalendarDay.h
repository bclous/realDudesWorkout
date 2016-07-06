//
//  CalendarDay.h
//  RealDudesWorkout
//
//  Created by Brian Clouser on 7/3/16.
//  Copyright © 2016 The Qwiz LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CalendarDay : UIView

@property (nonatomic) NSUInteger day;
@property (nonatomic) BOOL representsRealDay;
@property (nonatomic) BOOL isFuture;
@property (nonatomic) BOOL isToday;
@property (nonatomic) BOOL didWorkout;
@property (nonatomic) BOOL isPreDownload;

-(void)roundCornersWithWidth:(CGFloat)width;

@end
