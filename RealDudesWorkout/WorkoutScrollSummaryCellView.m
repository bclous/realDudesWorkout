//
//  WorkoutScrollSummaryCellView.m
//  RealDudesWorkout
//
//  Created by Brian Clouser on 5/16/16.
//  Copyright © 2016 The Qwiz LLC. All rights reserved.
//

#import "WorkoutScrollSummaryCellView.h"
#import "ExcerciseTotalView.h"
#import "UIColor+BDC_Color.h"

@interface WorkoutScrollSummaryCellView ()

@property (strong, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UIView *containerWhiteView;
@property (weak, nonatomic) IBOutlet UIView *dateContainerCircleView;
@property (weak, nonatomic) IBOutlet UILabel *monthLabel;
@property (weak, nonatomic) IBOutlet UILabel *dayOfMonthLabel;
@property (weak, nonatomic) IBOutlet UILabel *dayOfWeekAndTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *workoutNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *workoutDurationLabel;
@property (weak, nonatomic) IBOutlet UILabel *excercisesLabel;
@property (weak, nonatomic) IBOutlet UIStackView *dateStackView;

@end

@implementation WorkoutScrollSummaryCellView

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
    [[NSBundle mainBundle] loadNibNamed:@"WorkoutScrollSummaryCell" owner:self options:nil];
    [self addSubview:self.contentView];
    self.contentView.frame = self.bounds;
    
    self.dateContainerCircleView.layer.cornerRadius = 25;
    self.dateContainerCircleView.layer.borderWidth = 2;
    self.dateContainerCircleView.layer.borderColor = [[UIColor bdc_offblackbackgroundColor] CGColor];
    [self bringSubviewToFront:self.monthLabel];
}

-(void)setWorkout:(Workout *)workout
{
    _workout = workout;
    
    self.monthLabel.text = [workout workoutStartMonth];
    self.dayOfMonthLabel.text = [workout workoutStartDayOfMonth];
    self.dayOfWeekAndTimeLabel.text = [NSString stringWithFormat:@"%@ %@", [workout workoutStartDayOfWeek], [workout workoutStartTime]];
    self.workoutNumberLabel.text = workout.name;
    self.workoutDurationLabel.text = [workout stringFromTimeInterval:workout.timeInSeconds];
    
    BOOL oneExcercise = [workout completedExcercisesInOrder].count == 1;
    self.excercisesLabel.text = oneExcercise ? @"1 exercise" : [NSString stringWithFormat:@"%lu exercises >",[workout completedExcercisesInOrder].count];
    
}

@end
