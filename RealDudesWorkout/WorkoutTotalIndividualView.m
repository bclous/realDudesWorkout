//
//  WorkoutTotalIndividualView.m
//  RealDudesWorkout
//
//  Created by Brian Clouser on 6/6/16.
//  Copyright © 2016 The Qwiz LLC. All rights reserved.
//

#import "WorkoutTotalIndividualView.h"
#import "DataStore.h"

@interface WorkoutTotalIndividualView ()

@property (strong, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UILabel *workoutNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *workoutsSinceLabel;
@property (strong, nonatomic) NSArray *workouts;
@property (strong, nonatomic) DataStore *dataStore;

@end

@implementation WorkoutTotalIndividualView

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
    
    
    [[NSBundle mainBundle] loadNibNamed:@"WorkoutTotalIndividual" owner:self options:nil];
    
    [self addSubview:self.contentView];
    
    self.contentView.frame = self.bounds;
    
    self.dataStore = [DataStore sharedDataStore];
    
    
}

-(void)setTimePeriod:(NSString *)timePeriod
{
    _timePeriod = timePeriod;
    
    if ([timePeriod isEqualToString:@"week"])
    {
        [self setViewForWeek];
    }
    else if ([timePeriod isEqualToString:@"month"])
    {
        [self setViewForMonth];
    }
    else if ([timePeriod isEqualToString:@"year"])
    {
        [self setViewForYear];
    }
    
}

-(void)setViewForWeek
{
    self.workouts = [self.dataStore.user workoutsSinceMonday];
    
    self.workoutNumberLabel.text = [NSString stringWithFormat:@"%lu", self.workouts.count];
    self.workoutsSinceLabel.text = @"workouts this week";
}

-(void)setViewForMonth
{
    self.workouts = [self.dataStore.user workoutsSinceFirstOfMonth];
    
    self.workoutNumberLabel.text = [NSString stringWithFormat:@"%lu", self.workouts.count];
    self.workoutsSinceLabel.text = @"workouts this month";
    
}

-(void)setViewForYear
{
    self.workouts = [self.dataStore.user workoutsSinceFirstOfYear];
    
    self.workoutNumberLabel.text = [NSString stringWithFormat:@"%lu", self.workouts.count];
    self.workoutsSinceLabel.text = @"workouts this year";
}



@end
