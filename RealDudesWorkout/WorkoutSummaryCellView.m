//
//  WorkoutSummaryCellView.m
//  RealDudesWorkout
//
//  Created by Brian Clouser on 3/24/16.
//  Copyright © 2016 The Qwiz LLC. All rights reserved.
//

#import "WorkoutSummaryCellView.h"

@interface WorkoutSummaryCellView ()

@property (strong, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UILabel *workoutNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *workoutCompleteLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLeftLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateRightLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLeftLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeRightLabel;
@property (weak, nonatomic) IBOutlet UILabel *durationLeftLabel;
@property (weak, nonatomic) IBOutlet UILabel *durationRightLabel;


@end

@implementation WorkoutSummaryCellView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

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
    
    NSLog(@"the init is getting called");
    
    [[NSBundle mainBundle] loadNibNamed:@"WorkoutSummaryCell" owner:self options:nil];
    
    [self addSubview:self.contentView];
    
    self.contentView.frame = self.bounds;
    
}

-(void)setWorkout:(Workout *)workout
{
    
    NSLog(@"the workout setter is getting called");
   
    _workout = workout;
    
    self.workoutNameLabel.text = self.workout.name;
    
    self.workoutCompleteLabel.text = [self.workout excercisesCompletedStringForSummary];
    
    self.dateLeftLabel.text = @"Date";
    
    self.timeLeftLabel.text = @"Time";
    
    self.durationLeftLabel.text = @"Duration";
    
    self.dateRightLabel.text = [self.workout longDateString];
    
    self.timeRightLabel.text = [self.workout workoutStartTime];
    
    self.durationRightLabel.text = [self.workout stringFromTimeInterval:self.workout.timeInSeconds];
    
}

@end
