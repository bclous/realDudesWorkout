//
//  activeWorkoutViewController.m
//  RealDudesWorkout
//
//  Created by Brian Clouser on 3/10/16.
//  Copyright © 2016 The Qwiz LLC. All rights reserved.
//

#import "activeWorkoutViewController.h"
#import <FontAwesomeKit/FontAwesomeKit.h>
#import "RestView.h"
#import "RestView2.h"
#import "ExcerciseView.h"
#import "ExerciseDescriptionView.h"
#import "NSString+BDC_Utility.h"
#import "SkipExerciseView.h"
#import "ExcerciseRestView.h"


@interface ActiveWorkoutViewController () <ExerciseDescriptionDelegate, ExcerciseRestViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *workoutTimeLabel;
@property (weak, nonatomic) IBOutlet ExcerciseView *excerciseView;
@property (weak, nonatomic) IBOutlet UIView *footerBackgroundView;
@property (weak, nonatomic) IBOutlet UIView *footerView;
@property (weak, nonatomic) IBOutlet UIView *doneButton;
@property (strong, nonatomic) IBOutlet UITapGestureRecognizer *skipButtonTapGestureRecognizer;
@property (strong, nonatomic) IBOutlet UITapGestureRecognizer *doneButtonTapGestureRecognizer;
@property (weak, nonatomic) IBOutlet UIView *navBar;
@property (weak, nonatomic) IBOutlet UILabel *buttonLabel;
@property (strong, nonatomic) IBOutlet UITapGestureRecognizer *backButtonTapGestureRecognizer;


@property (strong, nonatomic) Workout *workout;
@property (strong, nonatomic) NSArray *excerciseSets;
@property (strong, nonatomic) ExcerciseSet *currentExcerciseSet;
@property (strong, nonatomic) ExcerciseSet *lastExcerciseSet;
@property (strong, nonatomic) ExcerciseSet *nextExcerciseSet;
@property (nonatomic) NSUInteger currentExcerciseSetIndexValue;
@property (strong, nonatomic) NSMutableArray *exerciseViewsArray;

@property (strong, nonatomic) NSTimer *totalWorkoutTimer;
@property (nonatomic) NSTimeInterval totalWorkoutBaseTimeInterval;
@property (nonatomic) NSTimeInterval individualExcerciseBaseTimeInterval;
@property (nonatomic) NSTimeInterval restBaseTimeInterval;
@property (nonatomic) NSTimeInterval currentTimeInterval;
@property (strong, nonatomic) IBOutlet UITapGestureRecognizer *infoTap;
@property (strong, nonatomic) IBOutlet UITapGestureRecognizer *exerciseDescriptionTapGestureRecognizer;

@property (nonatomic) BOOL restViewIsDisplayed;
@property (nonatomic) BOOL isLastExcercise;
@property (nonatomic) BOOL isNextToLastExcercise;
@property (nonatomic) BOOL differentExericiseChosenInRestView;
@property (nonatomic) NSUInteger indexChosenFromRestView;

@property (weak, nonatomic) IBOutlet UIScrollView *exerciseScrollView;
@property (strong, nonatomic) UIStackView *exerciseStackView;

@property (strong, nonatomic) RestView2 *restView;

@property (strong, nonatomic) UIView *restBlurView;
@property (strong, nonatomic) NSLayoutConstraint *restBlurViewTopConstraint;
@property (strong, nonatomic) NSLayoutConstraint *restBlurViewBottomConstraint;

@property (strong, nonatomic) ExerciseDescriptionView *exerciseDescriptionView;
@property (nonatomic) BOOL descriptionViewDisplayed;


@end

@implementation ActiveWorkoutViewController


#pragma mark user actions

-(void)leaveDescriptionViewTapped
{
    [self excerciseDescriptionTapped:nil];
}

- (IBAction)excerciseDescriptionTapped:(id)sender
{
    self.descriptionViewDisplayed = !self.descriptionViewDisplayed;
    self.exerciseDescriptionView.alpha = self.descriptionViewDisplayed;
}

- (IBAction)cancelborderViewTapped:(id)sender
{
    self.workout.timeInSeconds = self.currentTimeInterval - self.totalWorkoutBaseTimeInterval;
    self.workout.isFinished = YES;
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)finishButtonTapped:(id)sender
{
   
    if (self.restViewIsDisplayed && !self.isLastExcercise)
    {
        [self restCompleted];
        [self animateRestViewUp:NO];
    }
    else if (self.restViewIsDisplayed && self.isLastExcercise)
    {
        [self workoutFinished];
        self.workout.isFinishedSuccessfully = YES;
        [self.dataStore saveContext];
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    else
    {
        [self exerciseCompleted];
        [self animateRestViewUp:YES];
    }
}


-(void)exerciseCompleted
{
    //[self updateProgressBar];
    [self recordExerciseDataCompleted:YES];
    self.restView.indexOfExerciseUpNext = [self indexOfNextExerciseNotCompletedAfterIndex:self.currentExcerciseSetIndexValue];
    [self updateTimeIntervalStartTimes];
    [self.restView updateRestViewComponentsForIndex:self.currentExcerciseSetIndexValue];
}

-(void)restCompleted
{
    [self recordRestData];
    [self updateTimeIntervalStartTimes];
    self.currentExcerciseSetIndexValue = self.differentExericiseChosenInRestView ? self.indexChosenFromRestView : [self indexOfNextExerciseNotCompletedAfterIndex:self.currentExcerciseSetIndexValue];
    self.differentExericiseChosenInRestView = NO;
}

-(void)workoutFinished
{
    self.workout.timeInSeconds = self.currentTimeInterval - self.totalWorkoutBaseTimeInterval;
    self.workout.isFinished = YES;
    self.workout.isFinishedSuccessfully = self.isLastExcercise ? YES : NO;
    [self.dataStore saveContext];
}

-(void)setCurrentExcerciseSetIndexValue:(NSUInteger)currentExcerciseSetIndexValue
{
    _currentExcerciseSetIndexValue = currentExcerciseSetIndexValue;
    self.currentExcerciseSet = self.excerciseSets[currentExcerciseSetIndexValue];
    [self updateExcerciseComponents];
    self.isLastExcercise = currentExcerciseSetIndexValue == self.excerciseSets.count - 1;
    
}

-(void)updateRestViewIndex
{
    self.restView.indexOfExcerciseJustFinished = self.currentExcerciseSetIndexValue;
}

-(void)exerciseTappedAtIndex:(NSUInteger)index
{
    if (self.restViewIsDisplayed)
    {
        self.differentExericiseChosenInRestView = YES;
        self.indexChosenFromRestView = index;
        [self updateIndex:index fromOldIndex:[self indexOfNextExerciseNotCompletedAfterIndex:self.currentExcerciseSetIndexValue]];
        self.restView.indexOfExerciseUpNext = index;
        
    }
    else
    {
        [self updateIndex:index fromOldIndex:self.currentExcerciseSetIndexValue];
        self.currentExcerciseSetIndexValue = index;
    }
}



#pragma mark update exercise methods

-(void)setRestViewIsDisplayed:(BOOL)restViewIsDisplayed
{
    _restViewIsDisplayed = restViewIsDisplayed;
    
    self.infoTap.enabled = !restViewIsDisplayed;
}

-(void)updateTimeIntervalStartTimes;
{
    self.individualExcerciseBaseTimeInterval = [[NSDate date] timeIntervalSince1970];
    self.restBaseTimeInterval = [[NSDate date] timeIntervalSince1970];
}


-(void)recordExerciseDataCompleted:(BOOL)completed
{
    
    self.currentExcerciseSet.timeInSecondsActual = completed ? self.currentTimeInterval - self.individualExcerciseBaseTimeInterval : 0;
    self.currentExcerciseSet.numberofRepsActual = completed ? self.currentExcerciseSet.numberOfRepsSuggested : 0;
    self.currentExcerciseSet.isComplete = completed;
    
    [self.dataStore saveContext];
}

-(void)recordRestData
{
    self.currentExcerciseSet.restTimeAfterInSecondsActual = self.currentTimeInterval - self.restBaseTimeInterval;
}

-(void)changeButtonTitle
{
    if (self.restViewIsDisplayed)
    {
        self.buttonLabel.text = @"Done";
    }
    else if (self.isLastExcercise)
    {
        self.buttonLabel.text = @"Workout Finished";
    }
    else
    {
        self.buttonLabel.text = @"Let's go";
    }
}



#pragma mark View animations

-(void)animateRestViewUp:(BOOL)up
{
    self.restView.nextWorkoutLabel.alpha = 0;
    self.view.userInteractionEnabled = NO;
    self.restBlurViewTopConstraint.active = NO;
    self.restBlurViewTopConstraint = up ? [self.restBlurView.topAnchor constraintEqualToAnchor:self.view.topAnchor constant:70] : [self.restBlurView.topAnchor constraintEqualToAnchor:self.view.bottomAnchor];
    self.restBlurViewTopConstraint.active = YES;
    [self updateScrollViewToIndex:self.currentExcerciseSetIndexValue animate:YES];
    
    [UIView animateWithDuration:.2
                     animations:^{
                         [self.view layoutIfNeeded];
                     } completion:^(BOOL finished) {
                         [self changeButtonTitle];
                         self.restViewIsDisplayed = up;
                         
                         [UIView animateWithDuration:0 delay:.4 options:0 animations:^{
                             self.restView.nextWorkoutLabel.alpha = up;
                         } completion:^(BOOL finished) {
                             // nada
                         }];
                    
                         if (self.descriptionViewDisplayed)
                         {
                             [self excerciseDescriptionTapped:nil];
                         }
                         if (up)
                         {
                             [self updateForExerciseFinishedAtIndex:self.currentExcerciseSetIndexValue];
                         }
                         
                         self.view.userInteractionEnabled = YES;
                     }];
}

-(void)updateForExerciseFinishedAtIndex:(NSUInteger)index
{
    CGFloat delay = .2;
    CGFloat duration = .05;
    
    [UIView animateWithDuration:duration delay:delay options:0 animations:^{
        [self updateExerciseViewAtIndex:index status:2];
    } completion:^(BOOL finished) {
        [self updateScrollViewToIndex:[self indexOfNextExerciseNotCompletedAfterIndex:index] animate:YES];
        
    }];
}

-(void)updateIndex:(NSUInteger)index fromOldIndex:(NSUInteger)oldIndex
{
    ((ExcerciseRestView *)self.exerciseViewsArray[oldIndex]).status = 0;
    [self updateScrollViewToIndex:index animate:YES];
    ((ExcerciseRestView *)self.exerciseViewsArray[index]).status = 1;
   
}

-(void)updateScrollViewToIndex:(NSUInteger)index animate:(BOOL)animate
{
    CGPoint offset;
    offset.y = 0;
    offset.x = 74 * index;
    
    [self.exerciseScrollView setContentOffset:offset animated:animate];
}

-(void)updateExerciseViewAtIndex:(NSUInteger)index status:(NSUInteger)status
{
    ExcerciseRestView *exerciseView = self.exerciseViewsArray[index];
    exerciseView.status = status;
    if (self.exerciseViewsArray[[self indexOfNextExerciseNotCompletedAfterIndex:index]] != 0)
    {
        ExcerciseRestView *exerciseView = self.exerciseViewsArray[[self indexOfNextExerciseNotCompletedAfterIndex:index]];
        exerciseView.status = 1;
    }
    
}

-(NSUInteger)indexOfNextExerciseNotCompletedAfterIndex:(NSUInteger)index
{
    for (NSUInteger i = index+1; i < self.excerciseSets.count; i++)
    {
        ExcerciseSet *excerciseSetAtIndex = self.excerciseSets[i];
        if (!excerciseSetAtIndex.isComplete)
        {
            return i;
        }
    }
    
    return 0;
}


#pragma format view components

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

-(void)formatViewComponents
{
    
    self.currentExcerciseSetIndexValue = 0;
    self.excerciseView.alpha = 1;
    self.restView.alpha = 0;
    self.restViewIsDisplayed = NO;
    
    self.doneButton.layer.cornerRadius = 20;
    [self initializeExcerciseTotals];
    
    // set up first excercise and second excercise and set isLastWorkout BOOL
    self.currentExcerciseSet = self.excerciseSets[self.currentExcerciseSetIndexValue];
    
    BOOL oneExcerciseInWorkout = self.excerciseSets.count == 1;
    BOOL twoExcercisesInWorkout = self.excerciseSets.count == 2;
    
    if (oneExcerciseInWorkout)
    {
        self.isLastExcercise = YES;
        self.isNextToLastExcercise = NO;
        
    }
    
    else if (twoExcercisesInWorkout)
    {
        self.isLastExcercise = NO;
        self.isNextToLastExcercise = YES;
        self.nextExcerciseSet = self.excerciseSets[self.currentExcerciseSetIndexValue + 1];
    }
    
    else
    {
        self.isLastExcercise = NO;
        self.isNextToLastExcercise = NO;
        self.nextExcerciseSet = self.excerciseSets[self.currentExcerciseSetIndexValue + 1];
    }
    
    [self updateExcerciseComponents];
    
}

-(void)updateExcerciseComponents
{
    self.excerciseView.excerciseSet = self.currentExcerciseSet;
    self.exerciseDescriptionView.excerciseSet = self.currentExcerciseSet;
    
}

-(void)generateRestComponents
{
    self.restView.workout = self.workout;
    self.restView.indexOfExcerciseJustFinished = 0;
}

-(void)initializeExcerciseTotals
{
    //self.excerciseTotalsLabel.text = [NSString stringWithFormat:@"0%%"];
}


#pragma mark createViews

-(void)createExerciseDescriptionView
{
    self.descriptionViewDisplayed = NO;
    self.exerciseDescriptionView = [[ExerciseDescriptionView alloc] init];
    self.exerciseDescriptionView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:self.exerciseDescriptionView];
    self.exerciseDescriptionView.delegate = self;
    [self.exerciseDescriptionView.centerXAnchor constraintEqualToAnchor:self.excerciseView.centerXAnchor].active = YES;
    [self.exerciseDescriptionView.centerYAnchor constraintEqualToAnchor:self.excerciseView.centerYAnchor].active = YES;
    [self.exerciseDescriptionView.widthAnchor constraintEqualToAnchor:self.excerciseView.widthAnchor].active = YES;
    [self.exerciseDescriptionView.heightAnchor constraintEqualToAnchor:self.excerciseView.heightAnchor].active = YES;
    self.exerciseDescriptionView.alpha = 0;
    self.exerciseDescriptionView.excerciseSet = self.currentExcerciseSet;
}

-(void)createRestView
{
    
    self.restBlurView = [[UIView alloc] init];
    [self.view addSubview:self.restBlurView];
    self.restBlurView.translatesAutoresizingMaskIntoConstraints = NO;
    self.restBlurView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:.9];
    [self.restBlurView.leftAnchor constraintEqualToAnchor:self.view.leftAnchor].active = YES;
    [self.restBlurView.rightAnchor constraintEqualToAnchor:self.view.rightAnchor].active = YES;
    [self.restBlurView.heightAnchor constraintEqualToAnchor:self.view.heightAnchor constant:-210].active = YES;
    self.restBlurViewTopConstraint = [self.restBlurView.topAnchor constraintEqualToAnchor:self.view.bottomAnchor];
    self.restBlurViewTopConstraint.active = YES;
    
    self.restView = [[RestView2 alloc] init];
    [self.restBlurView addSubview:self.restView];
    self.restView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.restView.leftAnchor constraintEqualToAnchor:self.restBlurView.leftAnchor].active = YES;
    [self.restView.rightAnchor constraintEqualToAnchor:self.restBlurView.rightAnchor].active = YES;
    [self.restView.topAnchor constraintEqualToAnchor:self.restBlurView.topAnchor].active = YES;
    [self.restView.bottomAnchor constraintEqualToAnchor:self.restBlurView.bottomAnchor].active = YES;
    
    self.restView.workout = self.workout;
    self.restView.indexOfExcerciseJustFinished = 0;
    
}

-(void)createExerciseStackView
{
    self.exerciseStackView = [[UIStackView alloc] init];
    
    self.exerciseStackView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.exerciseScrollView addSubview:self.exerciseStackView];
    [self.exerciseStackView.leftAnchor constraintEqualToAnchor:self.exerciseScrollView.leftAnchor].active = YES;
    [self.exerciseStackView.rightAnchor constraintEqualToAnchor:self.exerciseScrollView.rightAnchor].active = YES;
    [self.exerciseStackView.topAnchor constraintEqualToAnchor:self.exerciseScrollView.topAnchor].active = YES;
    [self.exerciseStackView.bottomAnchor constraintEqualToAnchor:self.exerciseScrollView.bottomAnchor].active = YES;
    [self.exerciseStackView.heightAnchor constraintEqualToAnchor:self.exerciseScrollView.heightAnchor].active = YES;
    self.exerciseStackView.spacing = 2;
}

-(void)generateExercises
{
    
    UIView *fillerView = [[UIView alloc] init];
    [self.exerciseStackView addArrangedSubview:fillerView];
    [fillerView.heightAnchor constraintEqualToAnchor:self.exerciseStackView.heightAnchor].active = YES;
    [fillerView.widthAnchor constraintEqualToAnchor:self.exerciseScrollView.widthAnchor multiplier:.5 constant:-36].active = YES;
    fillerView.backgroundColor = [UIColor clearColor];
    
    self.exerciseViewsArray = [NSMutableArray new];
    
    NSUInteger index = 0;
    for (ExcerciseSet *excerciseSet in self.excerciseSets)
    {
        ExcerciseRestView *excerciseView = [[ExcerciseRestView alloc] init];
        excerciseView.excerciseSet = excerciseSet;
        excerciseView.index = index;
        excerciseView.delegate = self;
        [self.exerciseStackView addArrangedSubview:excerciseView];
        [excerciseView.heightAnchor constraintEqualToAnchor:self.exerciseStackView.heightAnchor].active = YES;
        [excerciseView.widthAnchor constraintEqualToAnchor:self.exerciseStackView.heightAnchor].active = YES;
        [self.exerciseViewsArray addObject:excerciseView];
        index++;
    }
    
    ((ExcerciseRestView *)self.exerciseViewsArray[0]).status = 1;
    
    
}


#pragma mark timer

-(void)setUpTimer
{
    _totalWorkoutTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(countdown) userInfo:nil repeats:YES];
    _totalWorkoutBaseTimeInterval = [[NSDate date] timeIntervalSince1970];
    _individualExcerciseBaseTimeInterval = [[NSDate date] timeIntervalSince1970];
    _restBaseTimeInterval = [[NSDate date] timeIntervalSince1970];
    _currentTimeInterval = [[NSDate date] timeIntervalSince1970];
    [self.totalWorkoutTimer fire];
}

-(void)countdown
{
    self.currentTimeInterval = [[NSDate date] timeIntervalSince1970];
    self.workoutTimeLabel.text = [NSString timeInClockForm:self.currentTimeInterval - self.totalWorkoutBaseTimeInterval];
    self.workout.timeInSeconds = self.currentTimeInterval - self.totalWorkoutBaseTimeInterval;
    
    if (self.restViewIsDisplayed)
    {
        [self.restView countdown];
    }
    
}

#pragma mark View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.dataStore = [DataStore sharedDataStore];
    NSArray *workoutsInOrder = [self.dataStore.user orderedWorkoutsLIFO];
    self.workout = workoutsInOrder[0];
    self.excerciseSets = [self.workout excercisesInOrder];
    
    //initialize components
    [self formatViewComponents];
    [self createExerciseDescriptionView];
    [self createRestView];
    [self setUpTimer];
    [self createExerciseStackView];
    [self generateExercises];
    [self.view bringSubviewToFront:self.footerBackgroundView];
    [self.view bringSubviewToFront:self.footerView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appEnteredForeground) name:@"app entered foreground" object:nil];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [self.totalWorkoutTimer invalidate];
    [[NSNotificationCenter defaultCenter] removeObserver:@"app entered foreground"];
}

-(void)appEnteredForeground
{
    [self countdown];
}




@end
