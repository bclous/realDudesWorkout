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
#import "ExcerciseView.h"


@interface ActiveWorkoutViewController ()

@property (strong, nonatomic) Workout *workout;

@property (weak, nonatomic) IBOutlet UIButton *finishButton;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *quitWorkoutButton;
@property (weak, nonatomic) IBOutlet UILabel *workoutTimeLabel;

@property (weak, nonatomic) IBOutlet ExcerciseView *excerciseView;
@property (weak, nonatomic) IBOutlet RestView *restView;

@property (strong, nonatomic) NSArray *excerciseSets;
@property (strong, nonatomic) ExcerciseSet *currentExcerciseSet;
@property (strong, nonatomic) ExcerciseSet *lastExcerciseSet;
@property (strong, nonatomic) ExcerciseSet *nextExcerciseSet;
@property (nonatomic) NSUInteger currentExcerciseSetIndexValue;

@property (strong, nonatomic) NSTimer *totalWorkoutTimer;
@property (nonatomic) NSTimeInterval totalWorkoutCounter;
@property (nonatomic) NSTimeInterval individualExcerciseCounter;
@property (nonatomic) NSTimeInterval restCounter;

@property (nonatomic) BOOL restViewIsDisplayed;
@property (nonatomic) BOOL isLastExcercise;
@property (nonatomic) BOOL isNextToLastExcercise;



@end

@implementation ActiveWorkoutViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.dataStore = [DataStore sharedDataStore];
    
    NSArray *workoutsInOrder = [self.dataStore.user orderedWorkoutsLIFO];
    
    self.workout = workoutsInOrder[0];
    
    // set up the excercise array in order
    
    self.excerciseSets = [self.workout excercisesInOrder];
    
    //initialize components
    
    [self initializeViewComponents];
    
    [self.navigationController setNavigationBarHidden:YES];
   
}


- (IBAction)finishedButtonTapped:(id)sender
{
    
    NSLog(@"%d rest view is displayed and %d is last excercise",self.restViewIsDisplayed, self.isLastExcercise);
    
    if (self.restViewIsDisplayed && !self.isLastExcercise)
    {
        
        NSLog(@"move back to excercise called");
        
        [self moveBackToExcerciseScreen];
        
    }
    else if (self.restViewIsDisplayed && self.isLastExcercise)
    {
        
        NSLog(@"the rest view knows this is the last excercise");
        // modually show the workout summary page
        
        [self.dataStore saveContext];
        
        
        
        [self workoutFinished];
        
         NSLog(@"about to save context");
        
        
        
        NSLog(@"just saved context");
        
        [self performSegueWithIdentifier:@"segueToWorkoutSummary" sender:nil];
      
        
        
        NSLog(@"end workout called");
        
    }
    else
    {
        NSLog(@"move back to rest screen called");
      
        [self moveToRestScreen];
        
        
    
    }
    
}

-(void)moveToRestScreen
{
    
    self.finishButton.enabled = NO;
    
    [self excerciseComplete];
    [self resetRestAndExcerciseCounters];
    
    [self generateRestComponents];
    [self changeButtonTitle];
    
    [UIView animateWithDuration:.5 animations:^{
        
        self.restView.alpha = 1;
        
    } completion:^(BOOL finished) {
        
        self.finishButton.enabled = YES;
        
        
    }];
    
    
    self.restViewIsDisplayed = YES;
    
    [self resetRestAndExcerciseCounters];
    
    [self.dataStore saveContext];

}

-(void)moveBackToExcerciseScreen
{
    
    
    self.finishButton.enabled = NO;
    
    self.currentExcerciseSet.restTimeAfterInSecondsActual = self.restCounter;
    
    [self resetRestAndExcerciseCounters];
    
    [self updateExcercise];
    [self generateExcerciseComponents];
    [self changeButtonTitle];
    
    
    [UIView animateWithDuration:.5 animations:^{
        self.restView.alpha = 0;
    } completion:^(BOOL finished) {
        
        self.finishButton.enabled = YES;
        
    }];
    
    self.restViewIsDisplayed = NO;
    
    NSLog(@"about to save context");
    
    [self.dataStore saveContext];
    
    [self resetRestAndExcerciseCounters];

}

-(void)excerciseComplete
{

    
    self.currentExcerciseSet.numberofRepsActual = self.currentExcerciseSet.numberOfRepsSuggested;
    
    self.currentExcerciseSet.timeInSecondsActual = self.individualExcerciseCounter;
    self.currentExcerciseSet.isComplete = YES;
    
    
}

-(void)workoutFinished
{
    
    
    self.workout.timeInSeconds = self.totalWorkoutCounter;
    self.workout.isFinished = YES;
    
    [self.totalWorkoutTimer invalidate];

    
    if (self.isLastExcercise)
    {
        self.workout.isFinishedSuccessfully = YES;
    }
    
    [self.dataStore saveContext];
    
}


- (IBAction)workoutFinishedButtonTapped:(id)sender
{
    self.currentExcerciseSet.isComplete = YES;
    self.currentExcerciseSet.numberofRepsActual = self.currentExcerciseSet.numberOfRepsSuggested;
    self.currentExcerciseSet.timeInSecondsActual = self.individualExcerciseCounter;
    
    ((ExcerciseSet *)self.excerciseSets[self.currentExcerciseSetIndexValue]).timeInSecondsActual = self.individualExcerciseCounter;
    
    self.workout.timeInSeconds = self.totalWorkoutCounter;
    
    self.workout.isFinished = YES;
    self.workout.isFinishedSuccessfully = YES;
    
    [self.totalWorkoutTimer invalidate];
    
    [self performSegueWithIdentifier:@"segueToSummary" sender:nil];
    
    
    
    
    
    
    //do some other stuff
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
    
    NSLog(@"%d is what update excercise says about last excercise", self.isLastExcercise);
}






-(void)changeButtonTitle
{
    if (self.restViewIsDisplayed && self.isLastExcercise)
    {
        [self.finishButton setTitle:@"Finish workout!" forState:UIControlStateNormal];
    }
    else if (self.restViewIsDisplayed)
    {
        [self.finishButton setTitle:@"Done" forState:UIControlStateNormal];
    }
    else if (self.isLastExcercise)
    {
        [self.finishButton setTitle:@"Workout summary" forState:UIControlStateNormal];
    }
    else
    {
         [self.finishButton setTitle:@"Let's go" forState:UIControlStateNormal];
    }
        
}



-(void)generateExcerciseComponents
{
    self.excerciseView.excerciseSet = self.currentExcerciseSet;
}

-(void)generateRestComponents
{
    self.restView.excerciseSetJustFinished = self.currentExcerciseSet;
    
    if (self.nextExcerciseSet)
    {
        self.restView.excerciseSetUpNext = self.nextExcerciseSet;
    }
    
    self.restView.currentWorkout = self.workout;
}


-(void)initializeViewComponents
{
    
    self.navigationItem.hidesBackButton = YES;
    
    [self setUpTimer];
    
    // set global counters and index values and set restViewDisplayedBool
    self.currentExcerciseSetIndexValue = 0;
    //self.restCountdown = 0;
    
    // set up views to show excercise to start
    
    self.excerciseView.alpha = 1;
    self.restView.alpha = 0;
    
    self.restViewIsDisplayed = NO;
    
    [self.finishButton setTitle:@"Done" forState:UIControlStateNormal];
    
    
    
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
    
    [self generateRestComponents];
    
}

-(void)setUpTimer
{
    self.totalWorkoutCounter = 0;
    self.individualExcerciseCounter = 0;
    self.restCounter = 0;
    
    self.totalWorkoutTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(countdown) userInfo:nil repeats:YES];
    
    [self.totalWorkoutTimer fire];
}

-(void)countdown
{
    
    self.workoutTimeLabel.text = [self generateTimeStringGivenTime:self.totalWorkoutCounter];
    
    self.totalWorkoutCounter++;
    self.individualExcerciseCounter++;
    self.restCounter++;
    
    self.workout.timeInSeconds = self.totalWorkoutCounter;
    [self.dataStore saveContext];
    
}
-(void)resetRestAndExcerciseCounters
{
    self.individualExcerciseCounter = 0;
    self.restCounter = 0;
}

-(NSString *)generateTimeStringGivenTime:(NSTimeInterval)time
{
    
    NSInteger hours = time/3600;
    NSInteger minutes = (((NSInteger)time)%3600)/60;
    NSInteger seconds = (((NSInteger)time)%3600)%60;
    
    BOOL hasHours = hours > 0;
    BOOL hasMinutes = minutes > 0;
   
    
    if (!hasHours && !hasMinutes)
    {
        NSString *stringNoMinutesOrHours = [NSString stringWithFormat:@"0:%@",[self timeStringFromTime:seconds]];
        
        return stringNoMinutesOrHours;
    }
    
    else if (!hasHours)
    {
        NSString *stringNoHours = [NSString stringWithFormat:@"%@:%@",[self timeStringFromTime:minutes],[self timeStringFromTime:seconds]];
        
        return stringNoHours;
    }
    
    else if (hasHours)
    {
        NSString *stringWithHours = [NSString stringWithFormat:@"%@:%@:%@",[self timeStringFromTime:hours],[self timeStringFromTime:minutes],[self timeStringFromTime:seconds]];
        
        return stringWithHours;
    }
    else
    {
        return @"0:00";
    }
    
    
    
}

-(NSString *)timeStringFromTime:(NSInteger)time
{
    BOOL singleDigit = time < 10;
    
    if (singleDigit)
    {
        NSString *timeString = [NSString stringWithFormat:@"0%li",time];
        
        return timeString;
        
    }
    else
    {
        NSString *timeString = [NSString stringWithFormat:@"%li",time];
        
        return timeString;
    }
}


//
//// In a storyboard-based application, you will often want to do a little preparation before navigation
//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
//{
//    NSLog(@"prepare for segue getting called");
//    
//    WorkoutSummaryTableViewController *destinationVC = segue.destinationViewController;
//    
//    destinationVC.workout = self.workout;
//    
//    
//    // Get the new view controller using [segue destinationViewController].
//    // Pass the selected object to the new view controller.
//}


@end
