//
//  activeWorkoutViewController.m
//  RealDudesWorkout
//
//  Created by Brian Clouser on 3/10/16.
//  Copyright © 2016 The Qwiz LLC. All rights reserved.
//

#import "activeWorkoutViewController.h"

@interface activeWorkoutViewController ()





@property (weak, nonatomic) IBOutlet UIBarButtonItem *endWorkoutButton;
@property (weak, nonatomic) IBOutlet UILabel *excerciseDescriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *ExcerciseNameAndRepsLabel;
@property (weak, nonatomic) IBOutlet UIButton *workoutFinishedButton;

@property (weak, nonatomic) IBOutlet UILabel *workoutDurationTimeLabel;

@property (weak, nonatomic) IBOutlet UILabel *workoutDurationLabel;
@property (weak, nonatomic) IBOutlet UIButton *excerciseCompleteButton;

@property (weak, nonatomic) IBOutlet UIImageView *excerciseImage;

@property (strong, nonatomic) NSArray *excercises;
@property (strong, nonatomic) NSArray *excercisesInOrder;
@property (strong, nonatomic) Excercise *currentExcercise;
@property (nonatomic) NSUInteger currentExcerciseIndexValue;

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
    
    // set up and fire the timer
    
    [self setUpTimer];
    
    
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
    
    BOOL lastExcercise = self.currentExcerciseIndexValue == self.excercisesInOrder.count-1;
    
    
//    if (lastExcercise)
//    {
//        // present modally workout complete and summary
//    }
//    
//    else
//    {
    
        // change the index value and corresponding current excercise
        
        self.currentExcerciseIndexValue++;
        self.currentExcercise = self.excercisesInOrder[self.currentExcerciseIndexValue];
       
        // if is rest,reset the rest timer
        BOOL isRest = [self.currentExcercise.name isEqualToString:@"Rest"];
        
        if (isRest)
        {
            self.restCountdown = self.currentExcercise.timeInSecondsSuggested;
        }
    
        // update the view components
    
        [self updateViewComponents];
        
    
}

- (IBAction)workoutFinishedButtonTapped:(id)sender
{
    ((Excercise *)self.excercisesInOrder[self.currentExcerciseIndexValue]).timeInSecondsActual = self.individualExcerciseCounter;
    
    [self.totalWorkoutTimer invalidate];
    
    self.workout.isFinished = YES;
    
    
    //do some other stuff
}


-(void)generateOriginalViewComponents
{
    
    self.currentExcercise = self.excercisesInOrder[self.currentExcerciseIndexValue];
    
    self.ExcerciseNameAndRepsLabel.text = [self generateTopLabelText];
    self.excerciseImage.image = [UIImage imageNamed:self.currentExcercise.pictureName];
    
    
    
    self.excerciseCompleteButton.hidden = NO;
    self.workoutFinishedButton.hidden = YES;
    
    
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
       
    }
    
    // udpate 
    self.ExcerciseNameAndRepsLabel.text = [self generateTopLabelText];
   
    self.excerciseImage.image = [UIImage imageNamed:self.currentExcercise.pictureName];

    
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
        NSString *labelText = [NSString stringWithFormat:@"Rest for %lu seconds", (unsigned long)self.restCountdown];
        
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
