//
//  WorkoutDetailView.m
//  RealDudesWorkout
//
//  Created by Brian Clouser on 5/26/16.
//  Copyright © 2016 The Qwiz LLC. All rights reserved.
//

#import "WorkoutDetailView.h"
#import "ExcerciseTotalView.h"

@interface WorkoutDetailView ()

@property (strong, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UIScrollView *excercisesScrollView;
@property (strong, nonatomic) UIStackView *excercisesStackView;
@property (weak, nonatomic) IBOutlet UIView *smallerContentView;
@property (weak, nonatomic) IBOutlet UIView *repeatButton;
@property (weak, nonatomic) IBOutlet UIView *deleteButton;
@property (weak, nonatomic) IBOutlet UILabel *workoutDayAndTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *workoutNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *workoutDurationLabel;


@end

@implementation WorkoutDetailView



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
    
    [[NSBundle mainBundle] loadNibNamed:@"WorkoutDetail" owner:self options:nil];
    
    [self addSubview:self.contentView];
    
    self.contentView.frame = self.bounds;
    
    self.smallerContentView.layer.cornerRadius = 15;
    self.repeatButton.layer.cornerRadius = 15;
    self.deleteButton.layer.cornerRadius = 15;
    
    
}

-(void)setWorkout:(Workout *)workout
{
    
    _workout = workout;
    
    [self createStackView];
    
    [self addExcercisesToStackView];
    
    [self setLabels];

    
}

- (IBAction)leaveViewButtonTapped:(id)sender
{
    
    [self.delegate leaveWorkoutDetailButtonTapped];
    
}

-(void)setLabels
{
    
//    self.monthLabel.text = [workout workoutStartMonth];
//    self.dayOfMonthLabel.text = [workout workoutStartDayOfMonth];
    
    self.workoutDayAndTimeLabel.text = [NSString stringWithFormat:@"%@ %@", [self.workout workoutStartDayOfWeek], [self.workout workoutStartTime]];
    
    self.workoutNameLabel.text = self.workout.name;
    
    self.workoutDurationLabel.text = [self.workout stringFromTimeInterval:self.workout.timeInSeconds];
    
//    self.excercisesLabel.text = [NSString stringWithFormat:@"%lu excercises >",[workout completedExcercisesInOrder].count];
}

-(void)createStackView
{
    self.excercisesStackView = [[UIStackView alloc] init];
    
    self.excercisesStackView.translatesAutoresizingMaskIntoConstraints = NO;
    
    self.excercisesStackView.distribution = UIStackViewDistributionFillEqually;
    
    [self.excercisesScrollView addSubview:self.excercisesStackView];
    
    [self.excercisesStackView.leftAnchor constraintEqualToAnchor:self.excercisesScrollView.leftAnchor].active = YES;
    [self.excercisesStackView.rightAnchor constraintEqualToAnchor:self.excercisesScrollView.rightAnchor].active = YES;
    [self.excercisesStackView.topAnchor constraintEqualToAnchor:self.excercisesScrollView.topAnchor].active = YES;
    [self.excercisesStackView.bottomAnchor constraintEqualToAnchor:self.excercisesScrollView.bottomAnchor].active = YES;
    
    [self.excercisesStackView.heightAnchor constraintEqualToAnchor:self.excercisesScrollView.heightAnchor].active = YES;
    
    self.excercisesStackView.spacing = 5;
    
}

-(void)addExcercisesToStackView
{
    
    for (ExcerciseSet *excerciseSet in self.workout.completedExcercisesInOrder)
    {
        
        ExcerciseTotalView *newView = [[ExcerciseTotalView alloc] init];
        
        newView.excerciseSet = excerciseSet;
        
        [self.excercisesStackView addArrangedSubview:newView];
        
        [newView.heightAnchor constraintEqualToConstant:180].active = YES;
        [newView.widthAnchor constraintEqualToAnchor:newView.heightAnchor].active = YES;
        
        
        
    }
    
}



@end
