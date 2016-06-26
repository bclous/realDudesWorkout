//
//  WorkoutTotalsDetailView.m
//  RealDudesWorkout
//
//  Created by Brian Clouser on 6/26/16.
//  Copyright © 2016 The Qwiz LLC. All rights reserved.
//

#import "WorkoutTotalsDetailView.h"
#import "Datastore.h"

@interface WorkoutTotalsDetailView ()

@property (strong, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UILabel *timePeriodMainLabel;
@property (weak, nonatomic) IBOutlet UILabel *timePeriodSecondaryLabel;
@property (weak, nonatomic) IBOutlet UILabel *numberOfWorkoutsLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *emptyScrollViewLabel;
@property (weak, nonatomic) IBOutlet UIButton *generateWorkoutButton;
@property (weak, nonatomic) IBOutlet UIScrollView *exerciseScrollView;
@property (strong, nonatomic) UIStackView *stackView;


@end

@implementation WorkoutTotalsDetailView

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
    
    [[NSBundle mainBundle] loadNibNamed:@"WorkoutTotalsDetail" owner:self options:nil];
    
    [self addSubview:self.contentView];
    
    self.contentView.frame = self.bounds;

}

- (IBAction)generateWorkoutTapped:(id)sender {
}



-(void)setTimePeriod:(NSString *)timePeriod
{
    _timePeriod = timePeriod;
    [self formatTimePeriodLabel];

}

-(void)setWorkouts:(NSArray *)workouts
{
    _workouts = workouts;
    [self formatNumberOfWorkoutsLabel];
    [self formatTimeLabel];

}


-(void)createStackView
{
    self.stackView = [[UIStackView alloc] init];
    
    self.stackView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.exerciseScrollView addSubview:self.stackView];
    
    [self.stackView.leftAnchor constraintEqualToAnchor:self.exerciseScrollView.leftAnchor].active = YES;
    [self.stackView.topAnchor constraintEqualToAnchor:self.exerciseScrollView.topAnchor].active = YES;
    [self.stackView.rightAnchor constraintEqualToAnchor:self.exerciseScrollView.rightAnchor].active = YES;
    [self.stackView.bottomAnchor constraintEqualToAnchor:self.exerciseScrollView.bottomAnchor].active = YES;
    
    [self.stackView.heightAnchor constraintEqualToAnchor:self.exerciseScrollView.heightAnchor].active = YES;

}

-(void)addExercisesToScrollView
{
    
}



-(void)formatTimePeriodLabel
{
    if ([self.timePeriod isEqualToString:@"week"])
    {
        
        self.timePeriodMainLabel.text = @"This Week";
        self.timePeriodSecondaryLabel.text = @"(since Monday)";
        
    }
    else if ([self.timePeriod isEqualToString:@"month"])
    {
        self.timePeriodMainLabel.text = @"This Month";
        self.timePeriodSecondaryLabel.text = [NSString stringWithFormat:@"(%@)", [NSString currentMonth]];
    }
    else
    {
        self.timePeriodMainLabel.text = @"This Year";
        self.timePeriodSecondaryLabel.text = [NSString stringWithFormat:@"(%@)", [NSString currentYear]];
    }
    
}

-(void)formatNumberOfWorkoutsLabel
{
    NSUInteger numberOfWorkouts = self.workouts.count;
    
    if (numberOfWorkouts == 1)
    {
        self.numberOfWorkoutsLabel.text = @"1 workout";
    }
    else
    {
        self.numberOfWorkoutsLabel.text = [NSString stringWithFormat:@"%lu workouts", numberOfWorkouts];
    }
    
}

-(void)formatTimeLabel
{
    NSTimeInterval totalTime = 0;
    NSTimeInterval averageTime = 0;
    
    for (Workout *workout in self.workouts)
    {
        totalTime = totalTime + workout.timeInSeconds;
    }
    
    if (self.workouts.count > 0)
    {
        averageTime = totalTime / self.workouts.count;
    }
    
    self.timeLabel.text = [NSString stringWithFormat:@"Total: %@ (Average: %@)", [NSString timeInSentenceForm:totalTime includSecondsAlways:NO includeSecondsWhenUnderOneHour:NO abbreviate:YES], [NSString timeInSentenceForm:averageTime includSecondsAlways:NO includeSecondsWhenUnderOneHour:NO abbreviate:YES]];
}


@end
