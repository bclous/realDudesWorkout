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
    
    [self addExcercisesToScrollView];
    
    
}

-(void)addExcercisesToScrollView
{
    
    self.stackView = [[UIStackView alloc] init];
    
    self.stackView.translatesAutoresizingMaskIntoConstraints = NO;
    
    self.stackView.distribution = UIStackViewDistributionFill;
    
    [self.excercisesScrollView addSubview:self.stackView];
    
    [self.stackView.leftAnchor constraintEqualToAnchor:self.excercisesScrollView.leftAnchor].active = YES;
    [self.stackView.topAnchor constraintEqualToAnchor:self.excercisesScrollView.topAnchor].active = YES;
    [self.stackView.rightAnchor constraintEqualToAnchor:self.excercisesScrollView.rightAnchor].active = YES;
    [self.stackView.bottomAnchor constraintEqualToAnchor:self.excercisesScrollView.bottomAnchor].active = YES;
    
    [self.stackView.heightAnchor constraintEqualToAnchor:self.excercisesScrollView.heightAnchor].active = YES;
    
    CGFloat stackViewWidth = 24 * 124 - 5;
    [self.stackView.widthAnchor constraintEqualToConstant:stackViewWidth].active = YES;
    
    self.stackView.spacing = 5;
    self.stackView.alignment = UIStackViewAlignmentFirstBaseline;
    
    
   
    for (ExcerciseSet *excerciseSet in self.excerciseSets)
    {
        
        ExcerciseTotalView *excerciseView = [[ExcerciseTotalView alloc] init];
        
        excerciseView.excerciseSet = excerciseSet;
        
         [self.stackView addArrangedSubview:excerciseView];
        
        NSLayoutConstraint *excerciseHeightConstraint = [excerciseView.heightAnchor constraintEqualToAnchor:self.stackView.heightAnchor];
        NSLayoutConstraint *excerciseWidthConstraint = [excerciseView.widthAnchor constraintEqualToAnchor:excerciseView.heightAnchor];
        
//        excerciseHeightConstraint.priority = 1000;
//        excerciseWidthConstraint.priority = 1000;
        
        excerciseHeightConstraint.active = YES;
        excerciseWidthConstraint.active = YES;
        
        
    }
    
    
    
    
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
    
    [self addExcercisesToScrollView];
    
    self.monthLabel.text = [workout workoutStartMonth];
    self.dayOfMonthLabel.text = [workout workoutStartDayOfMonth];
    
    self.dayOfWeekAndTimeLabel.text = [NSString stringWithFormat:@"%@ %@", [workout workoutStartDayOfWeek], [workout workoutStartTime]];

    self.workoutNumberLabel.text = workout.name;
                                  
    
    
}

- (IBAction)repeatWorkoutTapped:(id)sender
{
    
    [self.delegate repeatWorkoutTapped:self.workout];
    
}

- (IBAction)deleteWorkoutTapped:(id)sender
{
    [self.delegate deleteWorkoutTapped:self.workout];
}


@end
