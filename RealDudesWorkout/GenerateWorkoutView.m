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


@interface GenerateWorkoutView () <UIScrollViewDelegate>

@property (strong, nonatomic) IBOutlet UIView *contentView;
@property (strong, nonatomic) UIScrollView *excerciseScrollView;
@property (weak, nonatomic) IBOutlet UIButton *startButton;
@property (weak, nonatomic) IBOutlet UILabel *workoutNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *workoutDateAndTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *workoutEstimatedTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *numberOfExcercisesLabel;
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
    
    self.startButton.layer.cornerRadius = 20;
    self.excerciseViews = [[NSMutableArray alloc] init];
    [self createScrollView];
    [self createStackView];
    [self setAllLabels];
}

- (IBAction)startButtonTapped:(id)sender
{
    [self.delegate startWorkoutTapped];
}

-(void)setWorkout:(Workout *)workout
{
    _workout = workout;
    
    [self generateExcercises];
    [self createLabels];
}

-(void)createLabels
{
    self.workoutNameLabel.text = self.workout.name;
    self.workoutDateAndTimeLabel.text = [NSString stringWithFormat:@"%@ %@", [self.workout longDateString], [self.workout workoutStartTime] ];
    self.workoutEstimatedTimeLabel.text = [NSString stringWithFormat:@"Estimated time: %lld minutes", self.workout.targetTimeInSeconds / 60];
    self.numberOfExcercisesLabel.text = [NSString stringWithFormat:@"Excercises: %lu", self.workout.excercisesInOrder.count];
}

-(void)setAllLabels
{
    self.workoutNameLabel.alpha = 0;
    self.workoutDateAndTimeLabel.alpha = 0;
    self.workoutEstimatedTimeLabel.alpha = 0;
    self.numberOfExcercisesLabel.alpha = 0;
    self.startButton.alpha = 0;
    self.startButton.enabled = NO;
}

-(void)updateAllLabels
{
    
    [UIView animateWithDuration:.2 delay:.1 options:NO animations:^{
        
        self.workoutNameLabel.alpha = 1;
        self.workoutDateAndTimeLabel.alpha = 1;
        self.workoutEstimatedTimeLabel.alpha = 1;
        self.numberOfExcercisesLabel.alpha = 1;
        
    } completion:^(BOOL finished) {
        self.startButton.alpha = 1;
        self.startButton.enabled = YES;
    }];

}

-(void)createScrollView
{
    
    self.excerciseScrollView = [[UIScrollView alloc] init];
    [self addSubview:self.excerciseScrollView];
    self.excerciseScrollView.delegate = self;
    self.excerciseScrollView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.excerciseScrollView.centerYAnchor constraintEqualToAnchor:self.centerYAnchor constant:40].active = YES;
    [self.excerciseScrollView.heightAnchor constraintEqualToConstant: 180].active = YES;
    [self.excerciseScrollView.widthAnchor constraintEqualToAnchor:self.widthAnchor].active = YES;
    [self.excerciseScrollView.centerXAnchor constraintEqualToAnchor:self.centerXAnchor].active = YES;
   
}

-(void)createStackView
{
    self.excercisesStackView = [[UIStackView alloc] init];
    self.excercisesStackView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.excerciseScrollView addSubview:self.excercisesStackView];
    
    [self.excercisesStackView.leftAnchor constraintEqualToAnchor:self.excerciseScrollView.leftAnchor].active = YES;
    [self.excercisesStackView.rightAnchor constraintEqualToAnchor:self.excerciseScrollView.rightAnchor].active = YES;
    [self.excercisesStackView.topAnchor constraintEqualToAnchor:self.excerciseScrollView.topAnchor].active = YES;
    [self.excercisesStackView.bottomAnchor constraintEqualToAnchor:self.excerciseScrollView.bottomAnchor].active = YES;
    
    [self.excercisesStackView.heightAnchor constraintEqualToAnchor:self.excerciseScrollView.heightAnchor].active = YES;
    self.excercisesStackView.spacing = 5;

}

-(void)generateExcercises
{
    UIView *fillerView = [[UIView alloc] init];
    [self.excercisesStackView addArrangedSubview:fillerView];
    fillerView.backgroundColor = [UIColor clearColor];
    [fillerView.heightAnchor constraintEqualToAnchor:self.excerciseScrollView.heightAnchor multiplier:1].active = YES;
    [fillerView.widthAnchor constraintEqualToAnchor:self.widthAnchor multiplier:.5 constant:-95].active = YES;
    
    for (ExcerciseSet *excerciseSet in self.workout.excercisesInOrder)
    {
        GenerateWorkoutExcerciseView *excerciseTotalView = [[GenerateWorkoutExcerciseView alloc] init];
        excerciseTotalView.excerciseSet = excerciseSet;
        [self.excercisesStackView addArrangedSubview:excerciseTotalView];
        [excerciseTotalView.heightAnchor constraintEqualToAnchor:self.excercisesStackView.heightAnchor].active = YES;
        [excerciseTotalView.widthAnchor constraintEqualToAnchor:self.excercisesStackView.heightAnchor].active = YES;

    }
    
    [self layoutIfNeeded];
    [self updateAllLabels];
    
}


-(void)stopAllAnimationsInView:(UIView *)view;
{
    [view.layer removeAllAnimations];
    NSArray *subviews = [view subviews];
    
    for (UIView *subView in subviews)
    {
        [subView.layer removeAllAnimations];
        [self stopAllAnimationsInView:subView];
    }
}



@end
