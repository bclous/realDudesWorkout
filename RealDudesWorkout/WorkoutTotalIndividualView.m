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
    [self setViewForTimePeriod:timePeriod];
    
}

-(void)setViewForTimePeriod:(NSString *)timePeriod
{
    if ([timePeriod isEqualToString:@"week"])
    {
        self.workouts = [self.dataStore.user workoutsSinceMonday];
        
    }
    else if ([timePeriod isEqualToString:@"month"])
    {
        self.workouts = [self.dataStore.user workoutsSinceFirstOfMonth];
    }
    else
    {
        self.workouts = [self.dataStore.user workoutsSinceFirstOfYear];
    }
    
    self.workoutNumberLabel.text = [NSString stringWithFormat:@"%lu", self.workouts.count];
    self.workoutsSinceLabel.text = self.workouts.count == 1 ? [NSString stringWithFormat:@"workout this %@", timePeriod] : [NSString stringWithFormat:@"workouts this %@", timePeriod];
    
    NSString *totalTime = [NSString timeInSentenceForm:[self totalWorkoutTime] includSecondsAlways:NO includeSecondsWhenUnderOneHour:NO abbreviate:YES];
    NSString *averageTime = [NSString timeInSentenceForm:[self averageWorkoutTime] includSecondsAlways:NO includeSecondsWhenUnderOneHour:NO abbreviate:YES];
    
    self.totalTimeLabel.text = [NSString stringWithFormat:@"Total: %@", totalTime];
    self.averageTimeLabel.text = [NSString stringWithFormat:@"Average: %@", averageTime];
    
    
}

- (IBAction)moreLabelTapped:(id)sender
{
    [self.delegate moreDetailsTappped:self.timePeriod];
}

- (IBAction)moreLabelOuterViewTapped:(id)sender
{
    [self.delegate moreDetailsTappped:self.timePeriod];
}

-(NSTimeInterval)totalWorkoutTime
{
    NSTimeInterval totalTime = 0;
    
    for (Workout *workout in self.workouts)
    {
        totalTime = workout.timeInSeconds + totalTime;
    }
    
    return totalTime;
}

-(NSTimeInterval)averageWorkoutTime
{
    NSTimeInterval totalTime = 0;
    
    for (Workout *workout in self.workouts)
    {
        totalTime = workout.timeInSeconds + totalTime;
    }
    
    if (self.workouts.count == 0)
    {
        return 0;
    }
    else
    {
        return totalTime / self.workouts.count;
    }
}





@end
