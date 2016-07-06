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
    self.calendarMonth.alpha = 0;
    self.workoutNumberLabel.alpha = 0;
    self.totalTimeLabel.alpha = 0;
    self.bigLabel.alpha = 1;
    

}

-(void)transitionToStaticView
{
    
    
    [UIView animateWithDuration:.6 animations:^{
        self.bigLabel.alpha = 0;
        self.calendarMonth.alpha = 1;
        self.workoutNumberLabel.alpha = 1;
        self.totalTimeLabel.alpha = 1;
        
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


@end
