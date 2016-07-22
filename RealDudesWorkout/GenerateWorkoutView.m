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
@property (weak, nonatomic) IBOutlet UILabel *generatingWorkoutLabel;

@property (strong, nonatomic) UIStackView *excercisesStackView;

@property (strong, nonatomic) NSLayoutConstraint *scrollViewCenterXConstraint;




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
    
    [self.excercisesStackView.widthAnchor constraintEqualToConstant:[workout excercisesInOrder].count * 190 - 10];
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
    self.generatingWorkoutLabel.alpha = 1;
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
        self.generatingWorkoutLabel.alpha = 0;
        
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
    self.scrollViewCenterXConstraint = [self.excerciseScrollView.centerXAnchor constraintEqualToAnchor:self.centerXAnchor constant:600];
    self.scrollViewCenterXConstraint.active = YES;
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
    self.excercisesStackView.spacing = 5;
    self.excercisesStackView.distribution = UIStackViewDistributionFillEqually;

}

-(void)generateExcercises
{
    for (ExcerciseSet *excerciseSet in self.workout.excercisesInOrder)
    {
        
        GenerateWorkoutExcerciseView *excerciseTotalView = [[GenerateWorkoutExcerciseView alloc] init];
        excerciseTotalView.excerciseSet = excerciseSet;
        [excerciseTotalView.heightAnchor constraintEqualToConstant:180].active = YES;
        [excerciseTotalView.widthAnchor constraintEqualToConstant:180].active = YES;
        [self.excercisesStackView addArrangedSubview:excerciseTotalView];
    }
    
    [self layoutIfNeeded];
    [self animateInExcercices];
}

-(void)animateInExcercices
{
    CGFloat length = self.workout.excercisesInOrder.count * 190 - 10;
    CGPoint offset;
    offset.x = length - 100;
    offset.y = 0;
    CGPoint home;
    home.x = 0;
    home.y = 0;
    
    self.scrollViewCenterXConstraint.active = NO;
    self.scrollViewCenterXConstraint = [self.excerciseScrollView.centerXAnchor constraintEqualToAnchor:self.centerXAnchor];
    self.scrollViewCenterXConstraint.active = YES;
    
    [UIView animateWithDuration:2 delay:.2 options:NO animations:^{
        [self layoutIfNeeded];
        
    } completion:^(BOOL finished) {
    
        [UIView animateWithDuration:5 delay:0 options:NO animations:^{
    
            [self.excerciseScrollView setContentOffset:offset animated:NO];
            [self layoutIfNeeded];
            
        } completion:^(BOOL finished) {
            
            [UIView animateWithDuration:1 animations:^{
                
                [self.excerciseScrollView setContentOffset:home animated:NO];
                [self layoutIfNeeded];
                
            } completion:^(BOOL finished) {
                
                [self updateAllLabels];
            }];
        }];
    }];
    
}

-(void)resetView
{

    [self stopAllAnimationsInView:self];

    self.scrollViewCenterXConstraint.active = NO;
    self.scrollViewCenterXConstraint = [self.excerciseScrollView.centerXAnchor constraintEqualToAnchor:self.centerXAnchor constant:600];
    self.scrollViewCenterXConstraint.active = YES;
    
    CGPoint home;
    home.x = 0;
    home.y = 0;
    [self.excerciseScrollView setContentOffset:home animated:NO];
    
    [self setAllLabels];
    
//    [UIView performWithoutAnimation:^{
//        [self layoutIfNeeded];
//    }];
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
