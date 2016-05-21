//
//  GenerateWorkoutView.m
//  RealDudesWorkout
//
//  Created by Brian Clouser on 5/21/16.
//  Copyright © 2016 The Qwiz LLC. All rights reserved.
//

#import "GenerateWorkoutView.h"
#import "ExcerciseTotalView.h"

@interface GenerateWorkoutView ()

@property (strong, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UIScrollView *excerciseScrollView;
@property (weak, nonatomic) IBOutlet UIButton *startButton;

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
    
}

- (IBAction)startButtonTapped:(id)sender
{
    
    
    
}

-(void)setWorkout:(Workout *)workout
{
   
    _workout = workout;
    
    [self createStackView];
    
    [self generateExcercises];
    
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
        
        ExcerciseTotalView *excerciseTotalView = [[ExcerciseTotalView alloc] init];
        
        excerciseTotalView.excerciseSet = excerciseSet;
        
        [self.excercisesStackView addArrangedSubview:excerciseTotalView];
        
        [excerciseTotalView.heightAnchor constraintEqualToAnchor:self.excercisesStackView.heightAnchor].active = YES;
        
        [excerciseTotalView.widthAnchor constraintEqualToAnchor:excerciseTotalView.heightAnchor].active = YES;
    }
}

@end
