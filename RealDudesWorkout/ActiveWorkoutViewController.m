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

@interface ActiveWorkoutViewController () <ExerciseDescriptionDelegate, SkipExerciseViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *workoutTimeLabel;
@property (weak, nonatomic) IBOutlet ExcerciseView *excerciseView;
@property (weak, nonatomic) IBOutlet UIView *footerBackgroundView;
@property (weak, nonatomic) IBOutlet UIView *footerView;
@property (weak, nonatomic) IBOutlet UIView *doneButton;
@property (strong, nonatomic) IBOutlet UITapGestureRecognizer *skipButtonTapGestureRecognizer;
@property (strong, nonatomic) IBOutlet UITapGestureRecognizer *doneButtonTapGestureRecognizer;
@property (weak, nonatomic) IBOutlet UIView *navBar;
@property (weak, nonatomic) IBOutlet UILabel *excerciseTotalsLabel;
@property (weak, nonatomic) IBOutlet UIView *skipButton;
@property (weak, nonatomic) IBOutlet UIView *backButton;
@property (weak, nonatomic) IBOutlet UILabel *buttonLabel;
@property (strong, nonatomic) IBOutlet UITapGestureRecognizer *backButtonTapGestureRecognizer;

@property (strong, nonatomic) Workout *workout;
@property (strong, nonatomic) NSArray *excerciseSets;
@property (strong, nonatomic) ExcerciseSet *currentExcerciseSet;
@property (strong, nonatomic) ExcerciseSet *lastExcerciseSet;
@property (strong, nonatomic) ExcerciseSet *nextExcerciseSet;
@property (nonatomic) NSUInteger currentExcerciseSetIndexValue;

@property (strong, nonatomic) NSTimer *totalWorkoutTimer;
@property (nonatomic) NSTimeInterval totalWorkoutBaseTimeInterval;
@property (nonatomic) NSTimeInterval individualExcerciseBaseTimeInterval;
@property (nonatomic) NSTimeInterval restBaseTimeInterval;
@property (nonatomic) NSTimeInterval currentTimeInterval;


@property (nonatomic) BOOL restViewIsDisplayed;
@property (nonatomic) BOOL isLastExcercise;
@property (nonatomic) BOOL isNextToLastExcercise;
@property (nonatomic) BOOL skipViewIsDisplayed;
@property (strong, nonatomic) RestView2 *restView;
@property (strong, nonatomic) SkipExerciseView *skipView;
@property (strong, nonatomic) UIView *skipViewBlurView;
@property (strong, nonatomic) NSLayoutConstraint *skipViewTopConstraint;

@property (strong, nonatomic) UIView *restBlurView;
@property (strong, nonatomic) NSLayoutConstraint *restBlurViewTopConstraint;
@property (strong, nonatomic) NSLayoutConstraint *restBlurViewBottomConstraint;

@property (strong, nonatomic) ExerciseDescriptionView *exerciseDescriptionView;
@property (nonatomic) BOOL descriptionViewDisplayed;
@property (strong, nonatomic) IBOutlet UITapGestureRecognizer *exerciseDescriptionTapGestureRecognizer;

@end

@implementation ActiveWorkoutViewController


#pragma mark user actions

-(void)leaveDescriptionViewTapped
{
    self.exerciseDescriptionView.alpha = 0;
    self.descriptionViewDisplayed = NO;
}

- (IBAction)excerciseDescriptionTapped:(id)sender
{
    self.exerciseDescriptionView.alpha = 1;
    self.descriptionViewDisplayed = YES;
}

- (IBAction)backButtonTapped:(id)sender
{
    
    //if on rest view
    //updateScrollViewbackwards
    //animate rest view down
    
    //if not on rest view
    //iterateeercise backwards
    //updateScrollViewbackwards no animation
    //pop restview back up
    
    //if skip view displayed
    //animate skip view down
    
}
- (IBAction)skipButtonTapped:(id)sender
{
    [self animateSkipViewUp:!self.skipViewIsDisplayed];
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
    }
}


-(void)exerciseCompleted
{
    self.restView.indexOfExcerciseJustFinished = self.currentExcerciseSetIndexValue;

    [self recordExerciseData];
    [self updateTimeIntervalStartTimes];
    [self updateExcerciseTotals];
    [self.dataStore saveContext];
    [self animateRestViewUp:YES];
}

-(void)restCompleted
{
    self.currentExcerciseSet.restTimeAfterInSecondsActual = self.currentTimeInterval - self.restBaseTimeInterval;
    
    [self updateTimeIntervalStartTimes];
    [self updateExcerciseForward];
    [self generateExcerciseComponents];
    [self.dataStore saveContext];
    
    if (self.descriptionViewDisplayed)
    {
        self.exerciseDescriptionView.alpha = 0;
        self.descriptionViewDisplayed = NO;
    }
    
    [self animateRestViewUp:NO];
}

-(void)workoutFinished
{
    self.workout.timeInSeconds = self.currentTimeInterval - self.totalWorkoutBaseTimeInterval;
    self.workout.isFinished = YES;
    self.workout.isFinishedSuccessfully = self.isLastExcercise ? YES : NO;
    [self.dataStore saveContext];
}

-(void)updateExcerciseForward
{
    self.currentExcerciseSetIndexValue++;
    
    self.currentExcerciseSet = self.excerciseSets[self.currentExcerciseSetIndexValue];
    
    self.isLastExcercise = self.currentExcerciseSetIndexValue == self.excerciseSets.count - 1;
    self.isNextToLastExcercise = self.currentExcerciseSetIndexValue == self.excerciseSets.count - 2;
    
    if (!self.isLastExcercise)
    {
        self.nextExcerciseSet = self.excerciseSets[self.currentExcerciseSetIndexValue + 1];
    }
}

-(void)updateExerciseBackward
{
    
    
    
}


#pragma mark update exercise methods


-(void)updateTimeIntervalStartTimes;
{
    self.individualExcerciseBaseTimeInterval = [[NSDate date] timeIntervalSince1970];
    self.restBaseTimeInterval = [[NSDate date] timeIntervalSince1970];
}

-(void)updateExcerciseTotals
{
    NSUInteger totalExcercises = self.excerciseSets.count;
    NSUInteger currentExcercise = self.currentExcerciseSetIndexValue + 1;
    NSUInteger percentage = currentExcercise * 100 / totalExcercises;
    self.excerciseTotalsLabel.text = [NSString stringWithFormat:@"%lu%%", (unsigned long)percentage];
}

-(void)recordExerciseData
{
    self.currentExcerciseSet.timeInSecondsActual = self.currentTimeInterval - self.individualExcerciseBaseTimeInterval;
    self.currentExcerciseSet.numberofRepsActual = self.currentExcerciseSet.numberOfRepsSuggested;
    self.currentExcerciseSet.isComplete = YES;
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

-(void)animateSkipViewUp:(BOOL)up
{
    self.view.userInteractionEnabled = NO;
    self.skipViewTopConstraint.active = NO;
    self.skipViewTopConstraint = up ? [self.skipViewBlurView.topAnchor constraintEqualToAnchor:self.view.topAnchor constant:70] :  [self.skipViewBlurView.topAnchor constraintEqualToAnchor:self.view.bottomAnchor];
    self.skipViewTopConstraint.active = YES;
    
    [UIView animateWithDuration:.2 animations:^{
        [self.view layoutIfNeeded];
    } completion:^(BOOL finished) {
        self.skipViewIsDisplayed = up;
        self.view.userInteractionEnabled = YES;
    }];
}

-(void)animateRestViewUp:(BOOL)up
{
    self.view.userInteractionEnabled = NO;
    self.restBlurViewTopConstraint.active = NO;
    self.restBlurViewTopConstraint = up ? [self.restBlurView.topAnchor constraintEqualToAnchor:self.view.topAnchor constant:70] : [self.restBlurView.topAnchor constraintEqualToAnchor:self.view.bottomAnchor];
    self.restBlurViewTopConstraint.active = YES;
    
    [UIView animateWithDuration:.2 animations:^{
        [self.view layoutIfNeeded];
    } completion:^(BOOL finished) {
        [self changeButtonTitle];
        self.restViewIsDisplayed = up;
        self.view.userInteractionEnabled = YES;
        [self.restView updateScrollViewAnimate:up]; // need to fix this;
    }];
    
    
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
    
    self.doneButton.layer.cornerRadius = 3;
    self.skipButton.layer.cornerRadius = 3;
    self.backButton.layer.cornerRadius = 3;
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
    
    [self generateExcerciseComponents];
    
}

-(void)generateExcerciseComponents
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
    self.excerciseTotalsLabel.text = [NSString stringWithFormat:@"0%%"];
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

-(void)createSkipView
{
    
    self.skipViewBlurView = [[UIView alloc] init];
    [self.view addSubview:self.skipViewBlurView];
    self.skipViewBlurView.translatesAutoresizingMaskIntoConstraints = NO;
    self.skipViewBlurView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:.9];
    [self.skipViewBlurView.leftAnchor constraintEqualToAnchor:self.view.leftAnchor].active = YES;
    [self.skipViewBlurView.rightAnchor constraintEqualToAnchor:self.view.rightAnchor].active = YES;
    [self.skipViewBlurView.heightAnchor constraintEqualToAnchor:self.view.heightAnchor constant:-210].active = YES;
    self.skipViewTopConstraint = [self.skipViewBlurView.topAnchor constraintEqualToAnchor:self.view.bottomAnchor];
    self.skipViewTopConstraint.active = YES;
    
    self.skipView = [[SkipExerciseView alloc] init];
    [self.view addSubview:self.skipView];
    self.skipView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.skipView.leftAnchor constraintEqualToAnchor:self.skipViewBlurView.leftAnchor].active = YES;
    [self.skipView.rightAnchor constraintEqualToAnchor:self.skipViewBlurView.rightAnchor].active = YES;
    [self.skipView.topAnchor constraintEqualToAnchor:self.skipViewBlurView.topAnchor].active = YES;
    [self.skipView.bottomAnchor constraintEqualToAnchor:self.skipViewBlurView.bottomAnchor].active = YES;
    self.skipView.delegate = self;
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
    [self createSkipView];
    [self setUpTimer];
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
