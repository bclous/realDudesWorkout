//
//  WorkoutsSinceSummaryView.m
//  RealDudesWorkout
//
//  Created by Brian Clouser on 3/28/16.
//  Copyright © 2016 The Qwiz LLC. All rights reserved.
//

#import "WorkoutsSinceSummaryView.h"

@interface WorkoutsSinceSummaryView ()

@property (strong, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UILabel *numberOfWorkoutsLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalWorkoutTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *averageWorkoutTimeLabel;


@end

@implementation WorkoutsSinceSummaryView

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
    
    
    [[NSBundle mainBundle] loadNibNamed:@"WorkoutsSinceSummary" owner:self options:nil];
    
    [self addSubview:self.contentView];
    
    self.contentView.frame = self.bounds;
    
    
}

-(void)setWorkouts:(NSArray *)workouts
{
    _workouts = workouts;
    
    self.numberOfWorkoutsLabel.text = [NSString stringWithFormat:@"%lu workouts",workouts.count];
    
    self.totalWorkoutTimeLabel.text = @"TEST FIX THIS";
    self.averageWorkoutTimeLabel.text = @"TEST FIX THIS AS WELL";
    
    
}


@end
