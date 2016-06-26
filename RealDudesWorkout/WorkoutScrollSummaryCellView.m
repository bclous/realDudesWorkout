//
//  WorkoutScrollSummaryCellView.m
//  RealDudesWorkout
//
//  Created by Brian Clouser on 5/16/16.
//  Copyright © 2016 The Qwiz LLC. All rights reserved.
//

#import "WorkoutScrollSummaryCellView.h"
#import "ExcerciseTotalView.h"

@interface WorkoutScrollSummaryCellView ()

@property (strong, nonatomic) IBOutlet UIView *contentView;

@property (weak, nonatomic) IBOutlet UIScrollView *excercisesScrollView;
@property (weak, nonatomic) IBOutlet UIView *repeatWorkoutView;
@property (weak, nonatomic) IBOutlet UIView *deleteWorkoutView;
@property (weak, nonatomic) IBOutlet UIView *containerWhiteView;
@property (weak, nonatomic) IBOutlet UIView *dateContainerCircleView;
@property (weak, nonatomic) IBOutlet UILabel *monthLabel;
@property (weak, nonatomic) IBOutlet UILabel *dayOfMonthLabel;
@property (weak, nonatomic) IBOutlet UILabel *dayOfWeekAndTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *workoutNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *workoutDurationLabel;
@property (weak, nonatomic) IBOutlet UILabel *excercisesLabel;

@property (strong, nonatomic) UIStackView *stackView;

@property (strong, nonatomic) NSArray *excerciseSets;


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
    
//    NSLog(@"in the init for the workout scroll Summary Cell View, workout name is:%@",self.workout.name);
    
    [[NSBundle mainBundle] loadNibNamed:@"WorkoutScrollSummaryCell" owner:self options:nil];
    
    [self addSubview:self.contentView];
    
    self.contentView.frame = self.bounds;
    
    self.repeatWorkoutView.layer.cornerRadius = 15;
    self.deleteWorkoutView.layer.cornerRadius = 15;
    //self.containerWhiteView.layer.cornerRadius =15;
    self.dateContainerCircleView.layer.cornerRadius = 25;
    
    
}

-(void)addExcercisesToScrollView
{
    
    self.stackView = [[UIStackView alloc] init];
    
    self.stackView.translatesAutoresizingMaskIntoConstraints = NO;
    
   
    
    [self.excercisesScrollView addSubview:self.stackView];
    
    [self.stackView.leftAnchor constraintEqualToAnchor:self.excercisesScrollView.leftAnchor].active = YES;
    [self.stackView.topAnchor constraintEqualToAnchor:self.excercisesScrollView.topAnchor].active = YES;
    [self.stackView.rightAnchor constraintEqualToAnchor:self.excercisesScrollView.rightAnchor].active = YES;
    [self.stackView.bottomAnchor constraintEqualToAnchor:self.excercisesScrollView.bottomAnchor].active = YES;
    
    [self.stackView.heightAnchor constraintEqualToAnchor:self.excercisesScrollView.heightAnchor].active = YES;
    
    //CGFloat stackViewWidth = 100;
    //NSLayoutConstraint *stackViewWidthConstraint = [self.stackView.widthAnchor constraintEqualToConstant:stackViewWidth];
    
    //stackViewWidthConstraint.active = YES;
    //stackViewWidthConstraint.priority = 800;
    
    
    
    
    
    NSLog(@"%@ adding %lu excercises to scroll view", self.workout.name, self.excerciseSets.count);

    for (ExcerciseSet *excerciseSet in self.excerciseSets)
    {
        
        NSUInteger viewNumber = 1;
        
        NSLog(@"%@ adding excerciseView: %lu", self.workout.name, viewNumber);
        
        ExcerciseTotalView *excerciseView = [[ExcerciseTotalView alloc] init];
        
        excerciseView.excerciseSet = excerciseSet;
        
         [self.stackView addArrangedSubview:excerciseView];
        
        NSLayoutConstraint *excerciseHeightConstraint = [excerciseView.heightAnchor constraintEqualToAnchor:self.excercisesScrollView.heightAnchor];
        NSLayoutConstraint *excerciseWidthConstraint = [excerciseView.widthAnchor constraintEqualToAnchor:excerciseView.heightAnchor];
        
        excerciseHeightConstraint.active = YES;
        excerciseWidthConstraint.active = YES;
        
        excerciseHeightConstraint.priority = 1000;
        excerciseWidthConstraint.priority = 1000;
        
        viewNumber ++;
        
        
    }
    
    self.stackView.spacing = 10;
    
}

-(void)setStackViewWidth
{
//    CGFloat stackViewWidth = self.excerciseSets.count * 124 - 5;
//    
//    [self.stackView.widthAnchor constraintEqualToConstant:stackViewWidth].active = YES;
    
    
//    NSLog(@"set stack view width is getting called with a width of: %f", stackViewWidth);
}

-(void)setWorkout:(Workout *)workout
{
    _workout = workout;
    
    self.excerciseSets = [self.workout completedExcercisesInOrder];
    
    //[self addExcercisesToScrollView];
    
    self.monthLabel.text = [workout workoutStartMonth];
    self.dayOfMonthLabel.text = [workout workoutStartDayOfMonth];
    
    self.dayOfWeekAndTimeLabel.text = [NSString stringWithFormat:@"%@ %@", [workout workoutStartDayOfWeek], [workout workoutStartTime]];

    self.workoutNumberLabel.text = workout.name;
    
    self.workoutDurationLabel.text = [workout stringFromTimeInterval:workout.timeInSeconds];
    
    
    BOOL oneExcercise = [workout completedExcercisesInOrder].count == 1;
    
    if (oneExcercise)
    {
        self.excercisesLabel.text = @"1 exercise >";
    }
    
    else
    {
        self.excercisesLabel.text = [NSString stringWithFormat:@"%lu exercises >",[workout completedExcercisesInOrder].count];
    }
    
                                  
    
    
}



@end
