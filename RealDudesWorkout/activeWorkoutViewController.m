//
//  activeWorkoutViewController.m
//  RealDudesWorkout
//
//  Created by Brian Clouser on 3/10/16.
//  Copyright © 2016 The Qwiz LLC. All rights reserved.
//

#import "activeWorkoutViewController.h"
#import <FontAwesomeKit/FontAwesomeKit.h>

@interface activeWorkoutViewController ()





@property (weak, nonatomic) IBOutlet UIBarButtonItem *endWorkoutButton;
@property (weak, nonatomic) IBOutlet UILabel *excerciseDescriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *ExcerciseNameAndRepsLabel;
@property (weak, nonatomic) IBOutlet UIButton *workoutFinishedButton;

@property (weak, nonatomic) IBOutlet UILabel *workoutDurationTimeLabel;

@property (weak, nonatomic) IBOutlet UILabel *workoutDurationLabel;
@property (weak, nonatomic) IBOutlet UIButton *excerciseCompleteButton;

@property (weak, nonatomic) IBOutlet UIImageView *excerciseImage;
@property (weak, nonatomic) IBOutlet UIButton *add30SecondsButton;

@property (strong, nonatomic) NSArray *excercises;
@property (strong, nonatomic) NSArray *excercisesInOrder;
@property (strong, nonatomic) Excercise *currentExcercise;
@property (strong, nonatomic) Excercise *lastExcercise;
@property (strong, nonatomic) Excercise *nextExcercise;
@property (nonatomic) NSUInteger currentExcerciseIndexValue;
@property (weak, nonatomic) IBOutlet UIImageView *nextExcerciseImage;
@property (weak, nonatomic) IBOutlet UILabel *nextExcerciseLabel;


@property (strong, nonatomic) NSTimer *totalWorkoutTimer;
@property (nonatomic) NSTimeInterval totalWorkoutCounter;
@property (nonatomic) NSTimeInterval individualExcerciseCounter;

@property (nonatomic) NSUInteger restCountdown;




@end

@implementation activeWorkoutViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // set up the excercise array in order
    
    self.excercises = [self.workout.excercises allObjects];
    
    [self orderExcercises];
    
    
    // set global counters and index values
    self.currentExcerciseIndexValue = 0;
    self.restCountdown = 0;
    
    // set up the original screen
    
    [self generateOriginalViewComponents];
    
    FAKFontAwesome *nextExcercise = [FAKFontAwesome caretRightIconWithSize:50];
    
    NSAttributedString *nextExcerciseString = [nextExcercise attributedString];
    
    [self.excerciseCompleteButton setAttributedTitle:nextExcerciseString forState:0];
    
    // set up and fire the timer
    
    [self setUpTimer];
    
    
}

- (IBAction)cancelWorkoutButtonTapped:(id)sender
{
   
    NSLog(@"this happened");
    
    self.workout.timeInSeconds = self.totalWorkoutCounter;
    
    self.workout.isFinished = YES;
    self.workout.isFinishedSuccessfully = NO;
    
    [self performSegueWithIdentifier:@"segueToSummary" sender:nil];
}

-(void)countdown
{
    
    self.workoutDurationTimeLabel.text = [self generateTimeStringGivenTime:self.totalWorkoutCounter];
    
    BOOL isRest = [self.currentExcercise.name isEqualToString:@"Rest"];
    
    if (isRest)
    {
        self.ExcerciseNameAndRepsLabel.text = [self generateTopLabelText];
        
        BOOL isRestCounterAtZero = self.restCountdown == 0;
        
        if (!isRestCounterAtZero)
        {
            self.restCountdown--;
        }
    }
    
    // update top label if resting
    //self.excerciseTimeLabel.text = [self generateTimeStringGivenTime:self.individualExcerciseCounter];
    
    self.totalWorkoutCounter++;
    self.individualExcerciseCounter++;
    
    
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
    
  
    
    //mark excercise as complete
    
    self.currentExcercise.isComplete = YES;
    self.currentExcercise.numberOfRepsActual = self.currentExcercise.numberOfRepsSuggested;
    
    self.currentExcercise.timeInSecondsActual = self.individualExcerciseCounter;
    
    
    self.currentExcerciseIndexValue++;
    
    BOOL lastExcercise = self.currentExcerciseIndexValue == self.excercisesInOrder.count-1;
    
    self.currentExcercise = self.excercisesInOrder[self.currentExcerciseIndexValue];
    self.lastExcercise = self.excercisesInOrder[self.currentExcerciseIndexValue - 1];
    
    if (!lastExcercise)
    {
        self.nextExcercise = self.excercisesInOrder[self.currentExcerciseIndexValue +1];
    }
       
        // if new workout is rest,reset the rest timer to how much this rest should be based on it's propertry
        BOOL isRest = [self.currentExcercise.name isEqualToString:@"Rest"];
        
        if (isRest)
        {
            self.restCountdown = self.currentExcercise.timeInSecondsSuggested;
        }
    
        // update the view components
    
        [self updateViewComponents];
    
    // reset individiual workout timer
    
        self.individualExcerciseCounter = 0;
    
    
}

- (IBAction)workoutFinishedButtonTapped:(id)sender
{
    self.currentExcercise.isComplete = YES;
    self.currentExcercise.numberOfRepsActual = self.currentExcercise.numberOfRepsSuggested;
    self.currentExcercise.timeInSecondsActual = self.individualExcerciseCounter;
    
    ((Excercise *)self.excercisesInOrder[self.currentExcerciseIndexValue]).timeInSecondsActual = self.individualExcerciseCounter;
    
    self.workout.timeInSeconds = self.totalWorkoutCounter;
    
    self.workout.isFinished = YES;
    self.workout.isFinishedSuccessfully = YES;
    
    [self.totalWorkoutTimer invalidate];
    
    [self performSegueWithIdentifier:@"segueToSummary" sender:nil];
    
    
    
    
    
    
    //do some other stuff
}


-(void)generateOriginalViewComponents
{
    
    self.add30SecondsButton.hidden = YES;
    self.nextExcerciseImage.hidden = YES;
    self.currentExcercise = self.excercisesInOrder[self.currentExcerciseIndexValue];
    self.nextExcercise = self.excercisesInOrder[self.currentExcerciseIndexValue +1];
    
    self.ExcerciseNameAndRepsLabel.text = [self generateTopLabelText];
    self.excerciseImage.image = [UIImage imageNamed:self.currentExcercise.pictureName];
    self.excerciseDescriptionLabel.text = self.currentExcercise.excerciseDescription;
    
    self.nextExcerciseLabel.hidden = YES;
    
    
    self.excerciseCompleteButton.hidden = NO;
    self.workoutFinishedButton.hidden = YES;
    
    
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

-(void)updateViewComponents
{
   //update clock components
    
    
    BOOL isLastExcercise = self.currentExcerciseIndexValue == self.excercisesInOrder.count-1;
    BOOL isRest = [self.currentExcercise.name isEqualToString:@"Rest"];
    

    if (isLastExcercise)
    {
        self.excerciseCompleteButton.hidden = YES;
        self.workoutFinishedButton.hidden = NO;
        
        self.excerciseDescriptionLabel.hidden = NO;
        self.add30SecondsButton.hidden = YES;
        
        self.nextExcerciseImage.hidden = YES;
        self.nextExcerciseLabel.hidden = YES;
        
        
        self.ExcerciseNameAndRepsLabel.text = [self generateTopLabelText];
        self.excerciseDescriptionLabel.text = self.currentExcercise.excerciseDescription;
        self.excerciseImage.image = [UIImage imageNamed:self.currentExcercise.pictureName];
        
        
        
        //self.endWorkoutButton. = YES;
       
    }
    
    if (isRest)
    {
        self.excerciseDescriptionLabel.hidden = YES;
        self.add30SecondsButton.hidden = NO;
        
        
        self.excerciseImage.hidden = YES;
        
        self.nextExcerciseImage.hidden = NO;
        self.nextExcerciseImage.image = [UIImage imageNamed:self.nextExcercise.pictureName];
        
        self.nextExcerciseLabel.hidden = NO;
        self.nextExcerciseLabel.text = [NSString stringWithFormat:@"and get ready for %@",self.nextExcercise.name];
        
        self.ExcerciseNameAndRepsLabel.text = [self generateTopLabelText];
        self.excerciseDescriptionLabel.text = self.currentExcercise.excerciseDescription;
        self.excerciseImage.image = [UIImage imageNamed:self.currentExcercise.pictureName];
        
    }
    else
    {
        self.excerciseDescriptionLabel.hidden = NO;
        self.add30SecondsButton.hidden = YES;
        
        self.excerciseImage.hidden = NO;
        
        self.nextExcerciseImage.hidden = YES;
        self.nextExcerciseLabel.hidden = YES;
    // udpate top label, description lable, and image
    self.ExcerciseNameAndRepsLabel.text = [self generateTopLabelText];
    self.excerciseDescriptionLabel.text = self.currentExcercise.excerciseDescription;
    self.excerciseImage.image = [UIImage imageNamed:self.currentExcercise.pictureName];
    }

    
}

-(void)orderExcercises
{
    
    
    NSSortDescriptor *sortByIndexValueDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"indexInWorkoutNumber" ascending:YES];
    
    self.excercisesInOrder = [self.excercises sortedArrayUsingDescriptors:@[sortByIndexValueDescriptor]];
    
    
    
}

-(NSString *)generateTopLabelText
{
    
    BOOL isRest = [self.currentExcercise.name isEqualToString:@"Rest"];
    
    if (isRest)
    {
        
        NSString *formattedRestTime = [self generateTimeStringGivenTime:self.restCountdown];
        
        NSString *labelText = [NSString stringWithFormat:@"Rest for %@", formattedRestTime];
        
        return labelText;
    }
    
    else
    {
        NSString *labelText = [NSString stringWithFormat:@"%@ - %lli reps",self.currentExcercise.name, self.currentExcercise.numberOfRepsSuggested];
        
        return labelText;
    }
    
}



-(NSString *)generateExcerciseClockLabel
{
    
    BOOL isRest = [self.currentExcercise.name isEqualToString:@"Rest"];
    
    if (isRest)
    {
        NSString *clockLabel = [NSString stringWithFormat:@"Rest for %lli seconds", self.currentExcercise.timeInSecondsSuggested];
        
        return clockLabel;
    }
    
    else
    {
        NSString *clockLabel = @"This Excercise";
        
        return clockLabel;
    }
    
    
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
