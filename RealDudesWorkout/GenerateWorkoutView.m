//
//  GenerateWorkoutView.m
//  RealDudesWorkout
//
//  Created by Brian Clouser on 5/21/16.
//  Copyright © 2016 The Qwiz LLC. All rights reserved.
//

#import "GenerateWorkoutView.h"
#import "ExcerciseTotalView.h"
#import "GenerateWorkoutExcerciseView.h"


@interface GenerateWorkoutView ()

@property (strong, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UIScrollView *excerciseScrollView;
@property (weak, nonatomic) IBOutlet UIButton *startButton;
@property (weak, nonatomic) IBOutlet UILabel *workoutNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *workoutDateAndTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *workoutEstimatedTimeLabel;

@property (strong, nonatomic) UIStackView *excercisesStackView;


@end

@implementation GenerateWorkoutView

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
    
    
    [[NSBundle mainBundle] loadNibNamed:@"GenerateWorkout" owner:self options:nil];
    
    [self addSubview:self.contentView];
    
    self.contentView.frame = self.bounds;
    
    self.startButton.layer.cornerRadius = 15;
    
    self.excerciseViews = [[NSMutableArray alloc] init];
    
    
}

- (IBAction)startButtonTapped:(id)sender
{
    
    [self.delegate startWorkoutTapped];
    
}

-(void)setWorkout:(Workout *)workout
{
   
    _workout = workout;
    
    [self createStackView];
    
    [self generateExcercises];
    
    [self createLabels];
    
}

-(void)createStackView
{
    self.excercisesStackView = [[UIStackView alloc] init];
    
    self.excercisesStackView.translatesAutoresizingMaskIntoConstraints = NO;
    
    self.excercisesStackView.distribution = UIStackViewDistributionFillEqually;
    
    [self.excerciseScrollView addSubview:self.excercisesStackView];
    
    [self.excercisesStackView.leftAnchor constraintEqualToAnchor:self.excerciseScrollView.leftAnchor].active = YES;
    [self.excercisesStackView.rightAnchor constraintEqualToAnchor:self.excerciseScrollView.rightAnchor].active = YES;
    [self.excercisesStackView.topAnchor constraintEqualToAnchor:self.excerciseScrollView.topAnchor].active = YES;
    [self.excercisesStackView.bottomAnchor constraintEqualToAnchor:self.excerciseScrollView.bottomAnchor].active = YES;
    
    [self.excercisesStackView.heightAnchor constraintEqualToAnchor:self.excerciseScrollView.heightAnchor].active = YES;

}

-(void)generateExcercises
{
    
    for (ExcerciseSet *excerciseSet in self.workout.excercisesInOrder)
    {
        
        GenerateWorkoutExcerciseView *excerciseTotalView = [[GenerateWorkoutExcerciseView alloc] init];
        
        excerciseTotalView.excerciseSet = excerciseSet;
        
        [self.excercisesStackView addArrangedSubview:excerciseTotalView];
        
        [excerciseTotalView.heightAnchor constraintEqualToAnchor:self.excercisesStackView.heightAnchor].active = YES;
        
        [excerciseTotalView.widthAnchor constraintEqualToAnchor:excerciseTotalView.heightAnchor].active = YES;
        
        
        
    }
}

-(void)createLabels
{
    
    self.workoutNameLabel.text = self.workout.name;
    self.workoutDateAndTimeLabel.text = [NSString stringWithFormat:@"%@ %@", [self.workout longDateString], [self.workout workoutStartTime] ];
    self.workoutEstimatedTimeLabel.text = [NSString stringWithFormat:@"Estimated time: %lld minutes", self.workout.targetTimeInSeconds];
     
    
    
}

@end
