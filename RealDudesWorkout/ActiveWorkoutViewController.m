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
#import "UIColor+BDC_Color.h"
#import "SkipExerciseView.h"
#import "ExcerciseRestView.h"


@interface ActiveWorkoutViewController () <ExerciseDescriptionDelegate, ExcerciseRestViewDelegate, RestViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *workoutTimeLabel;
@property (weak, nonatomic) IBOutlet ExcerciseView *excerciseView;
@property (weak, nonatomic) IBOutlet UIView *footerBackgroundView;
@property (weak, nonatomic) IBOutlet UIView *footerView;
@property (weak, nonatomic) IBOutlet UIView *doneButton;
@property (strong, nonatomic) IBOutlet UITapGestureRecognizer *doneButtonTapGestureRecognizer;
@property (weak, nonatomic) IBOutlet UIView *navBar;
@property (weak, nonatomic) IBOutlet UILabel *buttonLabel;
@property (weak, nonatomic) IBOutlet UIView *headerView;
@property (weak, nonatomic) IBOutlet UILabel *upNextLabel;
@property (weak, nonatomic) IBOutlet UIProgressView *progressView;

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
@property (strong, nonatomic) NSLayoutConstraint *restViewOffLeftConstraint;
@property (strong, nonatomic) NSLayoutConstraint *restViewOnConstraint;
@property (strong, nonatomic) NSLayoutConstraint *restViewOffRightConstraint;
@property (strong, nonatomic) NSLayoutConstraint *restBlurViewTopConstraint;

@property (strong, nonatomic) UIVisualEffectView *restBlurView;


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
    
    NSString *alertTitle = [NSString stringWithFormat:@"End Workout"];
    
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:alertTitle
                                                                   message:@"Are you sure?"
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *deleteAction = [UIAlertAction actionWithTitle:@"Yes" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [self workoutFinished];
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    [alert addAction:cancelAction];
    [alert addAction:deleteAction];
    
    [self presentViewController:alert animated:YES completion:nil];
}

- (IBAction)finishButtonTapped:(id)sender
{
    if (self.restViewIsDisplayed && !self.restView.workoutOver)
    {
       
        [self restCompleted];
        [self updateExcerciseComponents];
        self.view.userInteractionEnabled = NO;
        self.upNextLabel.alpha = 0;
        [UIView animateWithDuration:.2 animations:^{
            [self adjustRestViewUp:NO];
        } completion:^(BOOL finished) {
            [self changeButtonTitle];
            self.view.userInteractionEnabled = YES;
        }];
    }
    else if (!self.restViewIsDisplayed && self.isLastExcercise)
    {
        self.restView.workoutOver = self.isLastExcercise;
        [self exerciseCompleted];
        self.currentExcerciseSetIndexValue = self.excerciseSets.count;
        self.restView.workoutOver = YES;
        self.upNextLabel.alpha = 0;
        self.view.userInteractionEnabled = NO;
        [UIView animateWithDuration:.2 animations:^{
            [self adjustRestViewUp:YES];
        } completion:^(BOOL finished) {
            self.upNextLabel.alpha = 0;
            [self updateProgressView];
            [self changeButtonTitle];
            [self updateExerciseViews];
            [self.restView.workoutOverView adjustBlueCircleOn:YES animate:YES];
            self.view.userInteractionEnabled = YES;
        }];
        
    }
    else if (self.restViewIsDisplayed && self.restView.workoutOver)
    {
        [self workoutFinished];
        [self dismissViewControllerAnimated:YES completion:nil];
        [self.restView.workoutOverView adjustBlueCircleOn:NO animate:NO];
    }
    else
    {
        [self exerciseCompleted];
        [self advanceToNextExercise];
        self.view.userInteractionEnabled = NO;
        [UIView animateWithDuration:.2 animations:^{
            [self adjustRestViewUp:YES];
        } completion:^(BOOL finished) {
            self.upNextLabel.alpha = 1;
            [self updateProgressView];
            [self changeButtonTitle];
            [self updateExerciseViews];
            [self updateScrollViewToIndex:self.currentExcerciseSetIndexValue animate:YES];
            self.view.userInteractionEnabled = YES;
        }];
    }
}

-(void)restIsOver
{
    [self restCompleted];
    [self updateExcerciseComponents];
    self.view.userInteractionEnabled = NO;
    self.upNextLabel.alpha = 0;
    [UIView animateWithDuration:.2 animations:^{
        [self adjustRestViewUp:NO];
    } completion:^(BOOL finished) {
        [self changeButtonTitle];
        self.view.userInteractionEnabled = YES;
    }];
}

-(void)exerciseCompleted
{
    [self recordExerciseDataCompleted:YES];
    [self updateTimeIntervalStartTimes];
    [self.restView updateRestViewComponentsForIndex:self.currentExcerciseSetIndexValue];
}

-(void)advanceToNextExercise
{
    if (!self.isLastExcercise)
    {
        self.currentExcerciseSetIndexValue = [self indexOfNextExerciseNotCompletedAfterIndex:self.currentExcerciseSetIndexValue];
    }
}


-(void)restCompleted
{
    [self recordRestData];
    [self updateTimeIntervalStartTimes];
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
    self.currentExcerciseSet = currentExcerciseSetIndexValue < self.excerciseSets.count ?  self.excerciseSets[currentExcerciseSetIndexValue] : [self.excerciseSets lastObject];
    self.isLastExcercise = [self indexOfNextExerciseNotCompletedAfterIndex:self.currentExcerciseSetIndexValue] == 0;
    NSLog(@"%lu",[self indexOfNextExerciseNotCompletedAfterIndex:self.currentExcerciseSetIndexValue]);
    self.upNextLabel.text = [NSString stringWithFormat:@"Up next: %@",self.currentExcerciseSet.excercise.name];

}

-(void)updateProgressView
{
    
   CGFloat completed = 0;
    for (ExcerciseSet *set in self.excerciseSets)
    {
        if (set.isComplete)
        {
            completed++;
        }
    }
    
    self.progressView.progress = completed / self.excerciseSets.count;
}

-(void)updateExerciseViews
{
    for (ExcerciseRestView *restView in self.exerciseViewsArray)
    {
        [restView formatExerciseView];
    }
}

-(void)updateRestViewIndex
{
    self.restView.indexOfExcerciseJustFinished = self.currentExcerciseSetIndexValue;
}

-(void)exerciseTappedAtIndex:(NSUInteger)index
{
   
    if (self.isLastExcercise && self.restViewIsDisplayed)
    {
        [self presentAlertViewController];
    }
    else
    {
        self.currentExcerciseSetIndexValue = index;
        [self updateExerciseViews];
        [self updateScrollViewToIndex:index animate:YES];
        if (!self.restViewIsDisplayed)
        {
            [self updateExcerciseComponents];
        }
    }
}

-(void)presentAlertViewController
{
    NSString *alertTitle = [NSString stringWithFormat:@"Go Back"];
    
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:alertTitle
                                                                   message:@"Do you want to complete the exercises you skipped?"
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *deleteAction = [UIAlertAction actionWithTitle:@"Yes" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        self.currentExcerciseSetIndexValue = 0;
        [self advanceToNextExercise];
        [self restCompleted];
        [self updateExcerciseComponents];
        self.view.userInteractionEnabled = NO;
        [UIView animateWithDuration:.2 animations:^{
            [self adjustRestViewUp:NO];
        } completion:^(BOOL finished) {
            [self updateExerciseViews];
            [self updateScrollViewToIndex:self.currentExcerciseSetIndexValue animate:YES];
            [self changeButtonTitle];
            self.restView.workoutOver = NO;
            [self.restView.workoutOverView adjustBlueCircleOn:NO animate:NO];
            self.view.userInteractionEnabled = YES;
        }];
    }];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    [alert addAction:cancelAction];
    [alert addAction:deleteAction];
    
    [self presentViewController:alert animated:YES completion:nil];
}

-(NSUInteger)currentIndex
{
    return self.currentExcerciseSetIndexValue;
}

-(void)adjustRestViewUp:(BOOL)up
{
    self.restBlurViewTopConstraint.active = NO;
    self.restBlurViewTopConstraint = up ? [self.restBlurView.topAnchor constraintEqualToAnchor:self.headerView.bottomAnchor constant:-1] : [self.restBlurView.topAnchor constraintEqualToAnchor:self.footerView.bottomAnchor];
    self.restBlurViewTopConstraint.active = YES;
    self.restViewIsDisplayed = up;
    [self.view layoutIfNeeded];
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
        self.buttonLabel.text = @"Let's go";
    }
    else if (self.isLastExcercise && self.restViewIsDisplayed)
    {
        self.buttonLabel.text = @"Workout Finished";
    }
    else
    {
        self.buttonLabel.text = @"Done";
    }
}



#pragma mark View animations

-(void)updateScrollViewToIndex:(NSUInteger)index animate:(BOOL)animate
{
    CGPoint offset;
    offset.y = 0;
    offset.x = 74 * index;
    
    [self.exerciseScrollView setContentOffset:offset animated:animate];
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
    
    self.isLastExcercise = YES;
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
    self.workoutTimeLabel.textColor = [UIColor bdc_lightText1];
    self.excerciseView.alpha = 1;
    self.restView.alpha = 0;
    self.restViewIsDisplayed = NO;
    [self updateProgressView];
    
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
    
    self.restBlurView = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleDark]];;
    self.restBlurView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:.3];
    [self.view addSubview:self.restBlurView];
    self.restBlurView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.restBlurView.leftAnchor constraintEqualToAnchor:self.view.leftAnchor].active = YES;
    [self.restBlurView.rightAnchor constraintEqualToAnchor:self.view.rightAnchor].active = YES;
    [self.restBlurView.heightAnchor constraintEqualToAnchor:self.view.heightAnchor constant:-203].active = YES;
    self.restBlurViewTopConstraint = [self.restBlurView.topAnchor constraintEqualToAnchor:self.footerView.topAnchor];
    self.restBlurViewTopConstraint.active = YES;

    self.restView = [[RestView2 alloc] init];
    [self.view addSubview:self.restView];
    self.restView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.restView.widthAnchor constraintEqualToAnchor:self.restBlurView.widthAnchor].active = YES;
    [self.restView.heightAnchor constraintEqualToAnchor:self.restBlurView.heightAnchor].active = YES;
    [self.restView.centerYAnchor constraintEqualToAnchor:self.restBlurView.centerYAnchor].active = YES;
    [self.restView.centerXAnchor constraintEqualToAnchor:self.restBlurView.centerXAnchor].active = YES;
    self.restView.delegate = self;
    
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
        [excerciseView formatExerciseView];
        excerciseView.delegate = self;
        [self.exerciseStackView addArrangedSubview:excerciseView];
        [excerciseView.heightAnchor constraintEqualToAnchor:self.exerciseStackView.heightAnchor].active = YES;
        [excerciseView.widthAnchor constraintEqualToAnchor:self.exerciseStackView.heightAnchor].active = YES;
        [self.exerciseViewsArray addObject:excerciseView];
        index++;
    }
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
