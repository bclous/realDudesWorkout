//
//  Last12Months.m
//  RealDudesWorkout
//
//  Created by Brian Clouser on 8/13/16.
//  Copyright © 2016 The Qwiz LLC. All rights reserved.
//

#import "Last12Months.h"
#import "DRCircularProgressView.h"
#import "WeeklyWorkoutTotalsView.h"
#import "DataStore.h"
#import "UIColor+BDC_Color.h"
#import "GenerateWorkoutExcerciseView.h"


@interface Last12Months ()

@property (strong, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet WeeklyWorkoutTotalsView *monthlyGraphView;
@property (weak, nonatomic) IBOutlet UIScrollView *exerciseScrollView;
@property (strong, nonatomic) DataStore *datastore;
@property (strong, nonatomic) NSArray *workoutsInLast12Months;
@property (strong, nonatomic) NSArray *exerciseImageNames;
@property (strong, nonatomic) NSArray *exerciseNameAndQuantities;
@property (strong, nonatomic) UIStackView *excercisesStackView;
@property (weak, nonatomic) IBOutlet UILabel *totalWorkoutsLabel;
@property (weak, nonatomic) IBOutlet UILabel *goalLabel;
@property (weak, nonatomic) IBOutlet UILabel *exerciseTotalsLabel;
@property (weak, nonatomic) IBOutlet UIImageView *leftChevronImage;
@property (weak, nonatomic) IBOutlet UIImageView *rightChevronImage;
@property (weak, nonatomic) IBOutlet UILabel *noWorkoutsLabel;

@end

@implementation Last12Months

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
    [[NSBundle mainBundle] loadNibNamed:@"Last12Months" owner:self options:nil];
    [self addSubview:self.contentView];
    self.contentView.frame = self.bounds;
    
    _datastore = [DataStore sharedDataStore];
    _workoutsInLast12Months = [self.datastore.user workoutsLast365Days];
    _exerciseImageNames = [self.datastore.user excercisePictureNamesSortedGivenWorkouts:self.workoutsInLast12Months];
    _exerciseNameAndQuantities = [self.datastore.user excerciseNameAndQuantitySortedGivenWorkouts:self.workoutsInLast12Months];
  
    [self createStackView];
    [self formatView];

}

-(void)formatView
{
    BOOL noWorkouts = self.workoutsInLast12Months.count == 0;
    self.totalWorkoutsLabel.textColor = [UIColor bdc_lightText1];
    self.goalLabel.textColor = [UIColor bdc_lightText1];
    self.exerciseTotalsLabel.textColor = [UIColor bdc_lightText1];
    
    self.noWorkoutsLabel.hidden = !noWorkouts;
    self.totalWorkoutsLabel.hidden = noWorkouts;
    self.goalLabel.hidden = noWorkouts;
    self.monthlyGraphView.hidden = noWorkouts;
    self.leftChevronImage.hidden = noWorkouts;
    self.exerciseTotalsLabel.hidden = noWorkouts;
    self.rightChevronImage.hidden = noWorkouts;
    self.exerciseScrollView.hidden = noWorkouts;
    self.noWorkoutsLabel.textColor = [UIColor bdc_lightText4];
   
    
}


-(void)createStackView
{
    self.excercisesStackView = [[UIStackView alloc] init];
    self.excercisesStackView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.exerciseScrollView addSubview:self.excercisesStackView];
    [self.excercisesStackView.leftAnchor constraintEqualToAnchor:self.exerciseScrollView.leftAnchor].active = YES;
    [self.excercisesStackView.rightAnchor constraintEqualToAnchor:self.exerciseScrollView.rightAnchor].active = YES;
    [self.excercisesStackView.topAnchor constraintEqualToAnchor:self.exerciseScrollView.topAnchor].active = YES;
    [self.excercisesStackView.bottomAnchor constraintEqualToAnchor:self.exerciseScrollView.bottomAnchor].active = YES;
    [self.excercisesStackView.heightAnchor constraintEqualToAnchor:self.exerciseScrollView.heightAnchor].active = YES;
    self.excercisesStackView.spacing = 2;
    
}

-(void)generateExercises
{
    UIView *fillerView = [[UIView alloc] init];
    [self.excercisesStackView addArrangedSubview:fillerView];
    fillerView.backgroundColor = [UIColor clearColor];
    [fillerView.heightAnchor constraintEqualToAnchor:self.exerciseScrollView.heightAnchor multiplier:1].active = YES;
    [fillerView.widthAnchor constraintEqualToAnchor:self.widthAnchor multiplier:.5 constant:(-self.exerciseScrollView.frame.size.height / 2) + 2].active = YES;

    NSUInteger index = 0;
    for (NSString *string in self.exerciseImageNames)
    {
        NSString *firstNumber = [string substringToIndex:0];
        if (![firstNumber isEqualToString:@"0"])
        {
            GenerateWorkoutExcerciseView *excerciseTotalView = [[GenerateWorkoutExcerciseView alloc] init];
            excerciseTotalView.excerciseNameLabel.text = self.exerciseNameAndQuantities[index];
            excerciseTotalView.excerciseImageView.image = [UIImage imageNamed:self.exerciseImageNames[index]];
            [self.excercisesStackView addArrangedSubview:excerciseTotalView];
            [excerciseTotalView.heightAnchor constraintEqualToAnchor:self.excercisesStackView.heightAnchor].active = YES;
            [excerciseTotalView.widthAnchor constraintEqualToAnchor:self.excercisesStackView.heightAnchor].active = YES;
        }
        index++;
        
    }
    [self layoutIfNeeded];
}


-(void)updateViewToOn:(BOOL)on animate:(BOOL)animate
{
    CGFloat duration = animate ? .2 : 0;
    CGPoint home;
    home.x = 0;
    home.y = 0;
    [UIView animateWithDuration:duration animations:^{
        
        if(on)
        {
            [self.monthlyGraphView setAllMonthsToAdjustedHeight];
        }
        else
        {
            [self.monthlyGraphView setAllMonthsToHeightZero];
            [self.exerciseScrollView setContentOffset:home animated:NO];
        }
    }];
}

-(void)updateViewForWorkouts
{
    [self.datastore fetchData];
    self.workoutsInLast12Months = [self.datastore.user workoutsLast365Days];
    [self formatView];
    self.exerciseImageNames = [self.datastore.user excercisePictureNamesSortedGivenWorkouts:self.workoutsInLast12Months];
    self.exerciseNameAndQuantities = [self.datastore.user excerciseNameAndQuantitySortedGivenWorkouts:self.workoutsInLast12Months];
    [self.excercisesStackView removeFromSuperview];
    [self createStackView];
    [self generateExercises];
    [self.monthlyGraphView formatView];
    
}


@end
