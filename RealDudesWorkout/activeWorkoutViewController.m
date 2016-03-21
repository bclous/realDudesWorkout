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

@interface activeWorkoutViewController ()


@property (weak, nonatomic) IBOutlet UIBarButtonItem *quitWorkoutButton;
@property (weak, nonatomic) IBOutlet UILabel *numberOfRepsLabel;
@property (weak, nonatomic) IBOutlet UILabel *excerciseNameLabel;

@property (weak, nonatomic) IBOutlet UILabel *workoutTimeLabel;


@property (weak, nonatomic) IBOutlet UIButton *excerciseCompleteButton;

@property (weak, nonatomic) IBOutlet UIImageView *excerciseImage;


@property (weak, nonatomic) IBOutlet UIButton *add30SecondsButton;

@property (weak, nonatomic) IBOutlet UIImageView *nextExcerciseImage;
@property (weak, nonatomic) IBOutlet UILabel *nextExcerciseLabel;

@property (strong, nonatomic) NSArray *excerciseSets;
@property (strong, nonatomic) ExcerciseSet *currentExcerciseSet;
@property (strong, nonatomic) ExcerciseSet *lastExcerciseSet;
@property (strong, nonatomic) ExcerciseSet *nextExcerciseSet;
@property (nonatomic) NSUInteger currentExcerciseSetIndexValue;

@property (strong, nonatomic) NSTimer *totalWorkoutTimer;
@property (nonatomic) NSTimeInterval totalWorkoutCounter;
@property (nonatomic) NSTimeInterval individualExcerciseCounter;

@property (nonatomic) NSUInteger restCountdown;





@property (weak, nonatomic) IBOutlet ExcerciseView *excerciseView;

@property (weak, nonatomic) IBOutlet RestView *effectView;






@end

@implementation activeWorkoutViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.hidesBackButton = YES;
    

    // set up the excercise array in order
    
    self.excerciseSets = [self.workout excercisesInOrder];
    
    [self initializeViewComponents];
    
    [self generateViewComponents];
    
    [self setUpTimer];
    
    self.excerciseView.alpha = 1;
    self.effectView.alpha = 1;
    
   
}


    


-(void)generateViewComponents
{
    
    // set up first excercise
    
    
    // self.currentExcerciseSet = self.excerciseSets[self.currentExcerciseSetIndexValue];
    
    self.excerciseView.excerciseImage.image = [UIImage imageNamed:self.currentExcerciseSet.excercise.pictureName];
    self.numberOfRepsLabel.text = [NSString stringWithFormat:@"%lld",self.currentExcerciseSet.numberOfRepsSuggested];
    self.excerciseNameLabel.text = self.currentExcerciseSet.excercise.name;
    
    
    BOOL lastExcercise = self.currentExcerciseSetIndexValue == self.excerciseSets.count - 1;

    
    if(lastExcercise)
    {
        [self.excerciseCompleteButton setTitle:@"Complete workout!" forState:UIControlEventAllEvents];

    }
    else
    {
        NSString *buttonTitle = [NSString stringWithFormat:@"Done with %@",self.currentExcerciseSet.excercise.name];
        
        [self.excerciseCompleteButton setTitle:buttonTitle forState:UIControlEventAllEvents];
    }

    
}

-(void)initializeViewComponents
{
    // set global counters and index values
    self.currentExcerciseSetIndexValue = 0;
    self.restCountdown = 0;
    
    // set up first excercise and second excercise
    
    self.currentExcerciseSet = self.excerciseSets[self.currentExcerciseSetIndexValue];
    
    if (self.excerciseSets.count > 1)
    {
        self.nextExcerciseSet = self.excerciseSets[self.currentExcerciseSetIndexValue + 1];
    }
}

-(void)updateExcercise
{
    self.currentExcerciseSetIndexValue++;
    
    self.currentExcerciseSet = self.excerciseSets[self.currentExcerciseSetIndexValue];
    
    BOOL lastExcercise = self.currentExcerciseSetIndexValue == self.excerciseSets.count - 1;
    
    if (!lastExcercise)
    {
        self.nextExcerciseSet = self.excerciseSets[self.currentExcerciseSetIndexValue + 1];
    }
    
}
    


- (IBAction)cancelWorkoutButtonTapped:(id)sender
{
   
    NSLog(@"this happened");
    
    self.workout.timeInSeconds = self.totalWorkoutCounter;
    
    self.workout.isFinished = YES;
    self.workout.isFinishedSuccessfully = NO;
    
    [self performSegueWithIdentifier:@"segueToSummary" sender:nil];
}




-(NSString *)generateTimeStringGivenTime:(NSTimeInterval)time
{
    
    NSInteger hours = time/3600;
    NSInteger minutes = (((NSInteger)time)%3600)/60;
    NSInteger seconds = (((NSInteger)time)%3600)%60;
    
    BOOL hasHours = hours > 0;
    BOOL hasMinutes = minutes > 0;
    
    if (hasHours)
    {
        NSString *stringWithHours = [NSString stringWithFormat:@"%luh %lum %lus",hours,minutes,seconds];
        
        return stringWithHours;
    }
    else if (hasMinutes)
    {
        NSString *stringWithMinutes = [NSString stringWithFormat:@"%lum %lus",minutes, seconds];
        
        return stringWithMinutes;
    }
    else
    {
        NSString *stringWithSeconds = [NSString stringWithFormat:@"%lus",seconds];
        
        return stringWithSeconds;
    }
    
    return @"0s";
    
}

- (IBAction)excerciseCompleteButtonTapped:(id)sender
{
    
  
    
//    //mark excercise as complete
//    
//    self.currentExcerciseSet.isComplete = YES;
//    self.currentExcerciseSet.numberofRepsActual = self.currentExcerciseSet.numberOfRepsSuggested;
//    
//    self.currentExcerciseSet.timeInSecondsActual = self.individualExcerciseCounter;
//    
//    
//    self.currentExcerciseSetIndexValue++;
//    
//    BOOL lastExcercise = self.currentExcerciseSetIndexValue == self.excercisesInOrder.count-1;
//    
//    self.currentExcerciseSet = self.excercisesInOrder[self.currentExcerciseIndexValue];
//    self.lastExcerciseSet = self.excercisesInOrder[self.currentExcerciseIndexValue - 1];
//    
//    if (!lastExcercise)
//    {
//        self.nextExcercise = self.excercisesInOrder[self.currentExcerciseIndexValue +1];
//    }
//       
//        // if new workout is rest,reset the rest timer to how much this rest should be based on it's propertry
//        BOOL isRest = [self.currentExcercise.name isEqualToString:@"Rest"];
//        
//        if (isRest)
//        {
//            self.restCountdown = self.currentExcercise.timeInSecondsSuggested;
//        }
//    
//        // update the view components
//    
//        [self updateViewComponents];
//    
//    // reset individiual workout timer
//    
//        self.individualExcerciseCounter = 0;
    

    
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




- (IBAction)add30SecondsButtonTapped:(id)sender
{
    
    self.restCountdown += 30;
}


-(void)setUpTimer
{
    self.totalWorkoutCounter = 0;
    self.individualExcerciseCounter = 0;
    
    self.totalWorkoutTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(countdown) userInfo:nil repeats:YES];
    
    [self.totalWorkoutTimer fire];
}

-(void)countdown
{
    
    self.workoutTimeLabel.text = [self generateTimeStringGivenTime:self.totalWorkoutCounter];
    
    self.totalWorkoutCounter++;
    self.individualExcerciseCounter++;
    
}





/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
