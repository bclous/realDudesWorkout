//
//  MonthlyWorkoutCalendarTopCellView.m
//  RealDudesWorkout
//
//  Created by Brian Clouser on 7/3/16.
//  Copyright © 2016 The Qwiz LLC. All rights reserved.
//

#import "MonthlyWorkoutCalendarTopCellView.h"

@interface MonthlyWorkoutCalendarTopCellView ()

@property (strong, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UILabel *bigLabel;
@property (weak, nonatomic) IBOutlet UILabel *workoutNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalTimeLabel;
@property (weak, nonatomic) IBOutlet CalendarMonth *calendarMonth;

@end

@implementation MonthlyWorkoutCalendarTopCellView

-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    
    if (self)
    {
        [self commonInit];
    }
    
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self)
    {
        [self commonInit];
    }
    
    return self;
}

-(void)commonInit
{
    
    [[NSBundle mainBundle] loadNibNamed:@"MonthlyWorkoutCalendar" owner:self options:nil];
    
    [self addSubview:self.contentView];
    
    self.contentView.frame = self.bounds;
    
}

-(void)transitionToScrollingView
{
    [self formatContentShow:NO];
}

-(void)transitionToStaticView
{
    [UIView animateWithDuration:.2 delay:.2 options:0 animations:^{
        [self formatContentShow:YES];
    } completion:^(BOOL finished) {
    // nada
    }];
}

-(void)setMonthOffset:(NSInteger)monthOffset
{
    _monthOffset = monthOffset;
    
    self.calendarMonth.monthAdditionToNow = monthOffset;
    
    if (monthOffset == 0)
    {
        self.bigLabel.text = @"THIS MONTH";
    }
    else if (monthOffset == -1)
    {
        self.bigLabel.text = @"LAST MONTH";
    }
    else if (monthOffset == 1)
    {
        self.bigLabel.text = @"NEXT MONTH";
    }
    else
    {
        self.bigLabel.text = [self.calendarMonth monthFromDate];
    }
    
    self.workoutNumberLabel.text = [self.calendarMonth numberOfWorkoutsLabel];
    self.totalTimeLabel.text = [self.calendarMonth totalTimeLabel];
}

-(void)formatContentShow:(BOOL)show
{
    self.bigLabel.alpha = !show;
    self.calendarMonth.alpha = show;
    self.workoutNumberLabel.alpha = show;
    self.totalTimeLabel.alpha = show;
}




@end
