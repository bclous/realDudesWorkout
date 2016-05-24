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
    self.dateContainerCircleView.layer.cornerRadius = 30;
    
    
}

-(void)addExcercisesToScrollView
{
    
    self.stackView = [[UIStackView alloc] init];
    
    self.stackView.translatesAutoresizingMaskIntoConstraints = NO;
    
    self.stackView.distribution = UIStackViewDistributionFillEqually;
    
    [self.excercisesScrollView addSubview:self.stackView];
    
    [self.stackView.leftAnchor constraintEqualToAnchor:self.excercisesScrollView.leftAnchor].active = YES;
    [self.stackView.topAnchor constraintEqualToAnchor:self.excercisesScrollView.topAnchor].active = YES;
    [self.stackView.rightAnchor constraintEqualToAnchor:self.excercisesScrollView.rightAnchor].active = YES;
    [self.stackView.bottomAnchor constraintEqualToAnchor:self.excercisesScrollView.bottomAnchor].active = YES;
    
    [self.stackView.heightAnchor constraintEqualToAnchor:self.excercisesScrollView.heightAnchor].active = YES;
    
    //[self.stackView.widthAnchor constraintEqualToAnchor:self.excercisesScrollView.widthAnchor multiplier:10].active = YES;
    
   
    for (ExcerciseSet *excerciseSet in self.excerciseSets)
    {
        
        ExcerciseTotalView *excerciseView = [[ExcerciseTotalView alloc] init];
        
        excerciseView.excerciseSet = excerciseSet;
        
         [self.stackView addArrangedSubview:excerciseView];
        
        [excerciseView.heightAnchor constraintEqualToAnchor:self.stackView.heightAnchor].active = YES;
        [excerciseView.widthAnchor constraintEqualToAnchor:excerciseView.heightAnchor].active = YES;
        
        
    }
    
    
}

-(void)setWorkout:(Workout *)workout
{
    _workout = workout;
    
    self.excerciseSets = [self.workout excercisesInOrder];
    
//    NSLog(@"excerciseSets in first workout are: %lu", self.excerciseSets.count);
//    
//    NSLog(@"workout name is: %@", self.workout.name);
    
    [self addExcercisesToScrollView];
    
    //self.workoutNameLabel.text = self.workout.name;
}




@end
