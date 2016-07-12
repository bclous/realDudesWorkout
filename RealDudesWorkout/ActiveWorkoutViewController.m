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

@interface ActiveWorkoutViewController () <ExerciseDescriptionDelegate>

@property (weak, nonatomic) IBOutlet UILabel *workoutTimeLabel;
@property (weak, nonatomic) IBOutlet ExcerciseView *excerciseView;
@property (weak, nonatomic) IBOutlet UIVisualEffectView *footerView;
@property (weak, nonatomic) IBOutlet UIView *footerBackgroundView;
@property (weak, nonatomic) IBOutlet UIView *navBar;
@property (weak, nonatomic) IBOutlet UIButton *doneButton;
@property (weak, nonatomic) IBOutlet UILabel *excerciseTotalsLabel;

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

@property (strong, nonatomic) RestView2 *restView;

@property (strong, nonatomic) UIVisualEffectView *restBlurView;
@property (strong, nonatomic) NSLayoutConstraint *restBlurViewTopConstraint;
@property (strong, nonatomic) NSLayoutConstraint *restBlurViewBottomConstraint;

@property (strong, nonatomic) ExerciseDescriptionView *exerciseDescriptionView;
@property (nonatomic) BOOL descriptionViewDisplayed;
@property (strong, nonatomic) IBOutlet UITapGestureRecognizer *exerciseDescriptionTapGestureRecognizer;

@end

@implementation ActiveWorkoutViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.dataStore = [DataStore sharedDataStore];
    NSArray *workoutsInOrder = [self.dataStore.user orderedWorkoutsLIFO];
    self.workout = workoutsInOrder[0];
    self.excerciseSets = [self.workout excercisesInOrder];
    
    //initialize components
    [self initializeViewComponents];
    [self createExerciseDescriptionView];
    [self createRestView];
    [self setUpTimer];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appEnteredForeground) name:@"app entered foreground" object:nil];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [self.totalWorkoutTimer invalidate];
    [[NSNotificationCenter defaultCenter] removeObserver:@"app entered foreground"];
}

-(void)appEnteredForeground
{
    //[self countdown];
}

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

-(void)initializeViewComponents
{
    
    self.currentExcerciseSetIndexValue = 0;
    self.excerciseView.alpha = 1;
    self.restView.alpha = 0;
    self.restViewIsDisplayed = NO;
    [self.doneButton setTitle:@"Done" forState:UIControlStateNormal];
    self.doneButton.layer.cornerRadius = 15;
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

- (IBAction)finishButtonTapped:(id)sender
{
    if (self.restViewIsDisplayed && !self.isLastExcercise)
    {
         [self moveBackToExcerciseScreen];
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
        [self moveToRestScreen];
        [self growRestView];
    }
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

-(void)moveToRestScreen
{
    // set restViewExcercise
    self.restView.indexOfExcerciseJustFinished = self.currentExcerciseSetIndexValue;
    
    // excercise complete stuff
    [self excerciseComplete];
    
    // updateTimeIntervals
    [self updateTimeIntervalStartTimes];
    
    //update excercise totals
    [self updateExcerciseTotals];
    
    //[self generateRestComponents];
    [self changeButtonTitle];
    
    
    self.restViewIsDisplayed = YES;
    
    [self.dataStore saveContext];
    
    [self growRestView];
    
    [self.view layoutIfNeeded];
    
}

-(void)moveBackToExcerciseScreen
{

    self.currentExcerciseSet.restTimeAfterInSecondsActual = self.currentTimeInterval - self.restBaseTimeInterval;
    
    [self updateTimeIntervalStartTimes];
    [self updateExcercise];
    [self generateExcerciseComponents];
    [self changeButtonTitle];
    
    self.restViewIsDisplayed = NO;
    
    [self.dataStore saveContext];
    
    if (self.descriptionViewDisplayed)
    {
        self.exerciseDescriptionView.alpha = 0;
        
        self.descriptionViewDisplayed = NO;
    }
    
    [self shrinkRestView];
}

-(void)excerciseComplete
{
    self.currentExcerciseSet.timeInSecondsActual = self.currentTimeInterval - self.individualExcerciseBaseTimeInterval;
    self.currentExcerciseSet.numberofRepsActual = self.currentExcerciseSet.numberOfRepsSuggested;
    self.currentExcerciseSet.isComplete = YES;
}

-(void)initializeExcerciseTotals
{
    self.excerciseTotalsLabel.text = [NSString stringWithFormat:@"0%%"];
}

-(void)updateExcerciseTotals
{
    NSUInteger totalExcercises = self.excerciseSets.count;
    NSUInteger currentExcercise = self.currentExcerciseSetIndexValue + 1;
    NSUInteger percentage = currentExcercise * 100 / totalExcercises;
    self.excerciseTotalsLabel.text = [NSString stringWithFormat:@"%lu%%", (unsigned long)percentage];
}

-(void)workoutFinished
{
    self.workout.timeInSeconds = self.currentTimeInterval - self.totalWorkoutBaseTimeInterval;
    self.workout.isFinished = YES;
    self.workout.isFinishedSuccessfully = self.isLastExcercise ? YES : NO;
    [self.dataStore saveContext];
}


-(void)updateExcercise
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

-(void)changeButtonTitle
{
    if (self.restViewIsDisplayed && self.isLastExcercise)
    {
        [self.doneButton setTitle:@"Done" forState:UIControlStateNormal];
    }
    else if (self.restViewIsDisplayed)
    {
        [self.doneButton setTitle:@"Done" forState:UIControlStateNormal];
    }
    else if (self.isLastExcercise)
    {
        [self.doneButton setTitle:@"Workout finished" forState:UIControlStateNormal];
    }
    else
    {
         [self.doneButton setTitle:@"Let's go" forState:UIControlStateNormal];
    }
        
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

- (IBAction)cancelborderViewTapped:(id)sender
{
    self.workout.timeInSeconds = self.currentTimeInterval - self.totalWorkoutBaseTimeInterval;
    self.workout.isFinished = YES;
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)updateTimeIntervalStartTimes;
{
    self.individualExcerciseBaseTimeInterval = [[NSDate date] timeIntervalSince1970];
    self.restBaseTimeInterval = [[NSDate date] timeIntervalSince1970];
}


#pragma mark Rest View methods

-(void)createRestView
{
    
    self.restBlurView = [[UIVisualEffectView alloc] init];
    
    [self.view addSubview:self.restBlurView];
    
    self.restBlurView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.restBlurView.leftAnchor constraintEqualToAnchor:self.view.leftAnchor].active = YES;
    [self.restBlurView.rightAnchor constraintEqualToAnchor:self.view.rightAnchor].active = YES;
    
    self.restBlurViewTopConstraint = [self.restBlurView.topAnchor constraintEqualToAnchor:self.view.bottomAnchor];
    
    self.restBlurViewBottomConstraint = [self.restBlurView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor constant: 400];
    
    self.restBlurViewTopConstraint.active = YES;
    self.restBlurViewBottomConstraint.active = YES;
    
    self.restBlurView.effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    
    self.restView = [[RestView2 alloc] init];
    
    [self.restBlurView.contentView addSubview:self.restView];
    
    self.restView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.restView.leftAnchor constraintEqualToAnchor:self.restBlurView.contentView.leftAnchor].active = YES;
    [self.restView.rightAnchor constraintEqualToAnchor:self.restBlurView.contentView.rightAnchor].active = YES;
    [self.restView.topAnchor constraintEqualToAnchor:self.restBlurView.contentView.topAnchor].active = YES;
    [self.restView.bottomAnchor constraintEqualToAnchor:self.restBlurView.contentView.bottomAnchor].active = YES;
    
    self.restBlurView.clipsToBounds = YES;
    
    [self.view bringSubviewToFront:self.footerBackgroundView];
    [self.view bringSubviewToFront:self.footerView];
    
    self.restView.workout = self.workout;
    self.restView.indexOfExcerciseJustFinished = 0;

}

-(void)growRestView
{
    
    self.doneButton.enabled = NO;
    
    [UIView animateWithDuration:.3 animations:^{
        
        
        self.restBlurViewTopConstraint.active = NO;
        self.restBlurViewBottomConstraint.active = NO;
        
        self.restBlurViewTopConstraint = [self.restBlurView.topAnchor constraintEqualToAnchor:self.view.topAnchor];
        self.restBlurViewBottomConstraint = [self.restBlurView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor constant:-150];
        
        self.restBlurViewTopConstraint.active = YES;
        self.restBlurViewBottomConstraint.active = YES;
        
        [self.view layoutIfNeeded];
        
    } completion:^(BOOL finished) {
        
        self.restViewIsDisplayed = YES;
        self.doneButton.enabled = YES;
    }];
}

-(void)shrinkRestView
{
    self.doneButton.enabled = NO;
    
    [UIView animateWithDuration:.3 animations:^{
        

        self.restBlurViewTopConstraint.active = NO;
        self.restBlurViewBottomConstraint.active = NO;
        
        self.restBlurViewTopConstraint = [self.restBlurView.topAnchor constraintEqualToAnchor:self.view.bottomAnchor];
        self.restBlurViewBottomConstraint = [self.restBlurView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor constant: 400];
        
        self.restBlurViewTopConstraint.active = YES;
        self.restBlurViewBottomConstraint.active = YES;
        
        [self.view layoutIfNeeded];
        
    } completion:^(BOOL finished) {
        
        self.restViewIsDisplayed = NO;
        self.doneButton.enabled = YES;
        
    }];
    
}

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



@end
