//
//  WeeklyWorkoutTotalsView.m
//  RealDudesWorkout
//
//  Created by Brian Clouser on 6/27/16.
//  Copyright © 2016 The Qwiz LLC. All rights reserved.
//

#import "WeeklyWorkoutTotalsView.h"
#import "DataStore.h"
#import "NSString+BDC_Utility.h"

@interface WeeklyWorkoutTotalsView ()

@property (strong, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UILabel *totalWorkoutsLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalTimeLabel;
@property (weak, nonatomic) IBOutlet UIStackView *monthStackView;
@property (weak, nonatomic) IBOutlet UIStackView *monthLabelsStackView;
@property (weak, nonatomic) IBOutlet UILabel *month12Label;
@property (weak, nonatomic) IBOutlet UILabel *month11Label;
@property (weak, nonatomic) IBOutlet UILabel *month10Label;
@property (weak, nonatomic) IBOutlet UILabel *month9Label;
@property (weak, nonatomic) IBOutlet UILabel *month8Label;
@property (weak, nonatomic) IBOutlet UILabel *month7Label;
@property (weak, nonatomic) IBOutlet UILabel *month6Label;
@property (weak, nonatomic) IBOutlet UILabel *month5Label;
@property (weak, nonatomic) IBOutlet UILabel *month4Label;
@property (weak, nonatomic) IBOutlet UILabel *month3Label;
@property (weak, nonatomic) IBOutlet UILabel *month2Label;
@property (weak, nonatomic) IBOutlet UILabel *month1Label;
@property (weak, nonatomic) IBOutlet UIView *graphBottomLineView;

@property (strong, nonatomic) NSMutableArray *workoutTotals;
@property (strong, nonatomic) NSMutableArray *monthStrings;
@property (nonatomic) NSInteger totalWorkouts;
@property (nonatomic) NSTimeInterval totalTime;
@property (nonatomic) NSInteger maxWorkouts;

@property (strong, nonatomic) IBOutletCollection(NSLayoutConstraint) NSArray* monthHeightConstraints;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *month12Height;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *month11Height;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *month10Height;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *month9Height;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *month8Height;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *month7Height;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *month6Height;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *month5Height;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *month4Height;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *month3Height;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *month2Height;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *month1Height;
@property (weak, nonatomic) IBOutlet UILabel *last12MonthsBigLabel;

@end

@implementation WeeklyWorkoutTotalsView


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
    
    [[NSBundle mainBundle] loadNibNamed:@"LastTwelveMonthsWorkoutTotals" owner:self options:nil];
    [self addSubview:self.contentView];
    self.contentView.frame = self.bounds;
    
    _workoutTotals = [NSMutableArray new];
    _monthStrings = [NSMutableArray new];
    _totalWorkouts = 0;
    _totalTime = 0;
    _maxWorkouts = 0;
    
    [self formatView];
    [self setAllMonthsToHeightZeroAnimated:NO];
}

-(void)formatView
{
    self.totalTime = 0;
    self.totalWorkouts= 0;
    [self generateMonthlyWorkoutTotalsAndNames];
    [self formatLabels];
}

-(void)generateMonthlyWorkoutTotalsAndNames
{
    [self.workoutTotals removeAllObjects];
    [self.monthStrings removeAllObjects];
    NSDate *today = [NSDate date];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [[NSDateComponents alloc] init];
    
    for (NSUInteger monthsAgo = 0; monthsAgo < 12; monthsAgo++)
    {
        components.month = -monthsAgo;
        NSDate *newDate = [calendar dateByAddingComponents:components toDate:today options:0];
        DataStore *dataStore = [DataStore sharedDataStore];
        NSArray *workoutsInMonth = [dataStore.user workoutsInMonthFromDate:newDate];
        
        for (Workout *workout in workoutsInMonth)
        {
            self.totalTime = self.totalTime + workout.timeInSeconds;
        }
        
        self.totalWorkouts = self.totalWorkouts + workoutsInMonth.count;
        
        if (workoutsInMonth.count > self.maxWorkouts)
        {
            self.maxWorkouts = workoutsInMonth.count;
        }
        
        NSNumber *workouts = [NSNumber numberWithInteger:workoutsInMonth.count];
        [self.workoutTotals addObject:workouts];
        [self.monthStrings addObject:[NSString shortMonthNameFromDate:newDate]];
        
    }
}

-(void)formatLabels
{
    self.month1Label.text = [NSString stringWithFormat:@"%lu",[self.workoutTotals[0] integerValue]];
    self.month2Label.text = [NSString stringWithFormat:@"%lu",[self.workoutTotals[1] integerValue]];
    self.month3Label.text = [NSString stringWithFormat:@"%lu",[self.workoutTotals[2] integerValue]];
    self.month4Label.text = [NSString stringWithFormat:@"%lu",[self.workoutTotals[3] integerValue]];
    self.month5Label.text = [NSString stringWithFormat:@"%lu",[self.workoutTotals[4] integerValue]];
    self.month6Label.text = [NSString stringWithFormat:@"%lu",[self.workoutTotals[5] integerValue]];
    self.month7Label.text = [NSString stringWithFormat:@"%lu",[self.workoutTotals[6] integerValue]];
    self.month8Label.text = [NSString stringWithFormat:@"%lu",[self.workoutTotals[7] integerValue]];
    self.month9Label.text = [NSString stringWithFormat:@"%lu",[self.workoutTotals[8] integerValue]];
    self.month10Label.text = [NSString stringWithFormat:@"%lu",[self.workoutTotals[9] integerValue]];
    self.month11Label.text = [NSString stringWithFormat:@"%lu",[self.workoutTotals[10] integerValue]];
    self.month12Label.text = [NSString stringWithFormat:@"%lu",[self.workoutTotals[11] integerValue]];
    
    
    NSUInteger month = 11;
    for (UILabel *label in [self.monthLabelsStackView arrangedSubviews])
    {
        label.text = self.monthStrings[month];
        month--;
    }
    
    self.totalWorkoutsLabel.text = self.totalWorkouts == 1 ? @"1 Workout" : [NSString stringWithFormat:@"%lu Workouts", self.totalWorkouts];
    self.totalTimeLabel.text = [NSString timeInSentenceForm:self.totalTime includSecondsAlways:NO includeSecondsWhenUnderOneHour:YES abbreviate:YES];
    
    
}

-(void)setAllMonthsToHeightZeroAnimated:(BOOL)animated
{
    for (NSLayoutConstraint *constraint in self.monthHeightConstraints)
    {
        constraint.constant = 3;
    }
    
    if (!animated)
    {
        [self layoutIfNeeded];
        return;
    }
    
    [UIView animateWithDuration:.2 animations:^{
        [self layoutIfNeeded];
    }];
}

-(void)setAllMonthsToAdjustedHeight:(BOOL)animated
{
    CGFloat interval = self.maxWorkouts == 0? 147.0 : 147.0 / self.maxWorkouts;
    
    self.month1Height.constant = [self.workoutTotals[0] floatValue] * interval;
    self.month2Height.constant = [self.workoutTotals[1] floatValue] * interval;
    self.month3Height.constant = [self.workoutTotals[2] floatValue] * interval;
    self.month4Height.constant = [self.workoutTotals[3] floatValue] * interval;
    self.month5Height.constant = [self.workoutTotals[4] floatValue] * interval;
    self.month6Height.constant = [self.workoutTotals[5] floatValue] * interval;
    self.month7Height.constant = [self.workoutTotals[6] floatValue] * interval;
    self.month8Height.constant = [self.workoutTotals[7] floatValue] * interval;
    self.month9Height.constant = [self.workoutTotals[8] floatValue] * interval;
    self.month10Height.constant = [self.workoutTotals[9] floatValue] * interval;
    self.month11Height.constant = [self.workoutTotals[10] floatValue] * interval;
    self.month12Height.constant = [self.workoutTotals[11] floatValue] * interval;
    
    for (NSLayoutConstraint *constraint in self.monthHeightConstraints)
    {
        constraint.constant = constraint.constant < 3 ? 3 : constraint.constant;
    }
    
    if (!animated)
    {
        [self layoutIfNeeded];
    }
    
    [UIView animateWithDuration:.3 animations:^{
        [self layoutIfNeeded];
    }];
}

-(void)transitionToScrollingView
{
    [self formatGraphContentShow:NO];
    [self setAllMonthsToHeightZeroAnimated:NO];
}
-(void)transitionToStaticView
{
    [UIView animateWithDuration:.2 delay:.2 options:0 animations:^{
        [self formatGraphContentShow:YES];
    } completion:^(BOOL finished) {
        [self setAllMonthsToAdjustedHeight:YES];
    }];
}

-(void)formatGraphContentShow:(BOOL)show
{
    self.monthLabelsStackView.alpha = show;
    self.monthStackView.alpha = show;
    self.month1Label.alpha = show;
    self.month2Label.alpha = show;
    self.month3Label.alpha = show;
    self.month4Label.alpha = show;
    self.month5Label.alpha = show;
    self.month6Label.alpha = show;
    self.month7Label.alpha = show;
    self.month8Label.alpha = show;
    self.month9Label.alpha = show;
    self.month10Label.alpha = show;
    self.month11Label.alpha = show;
    self.month12Label.alpha = show;
    self.totalWorkoutsLabel.alpha = show;
    self.totalTimeLabel.alpha = show;
    self.graphBottomLineView.alpha = show;
    self.last12MonthsBigLabel.alpha = !show;
}





@end
