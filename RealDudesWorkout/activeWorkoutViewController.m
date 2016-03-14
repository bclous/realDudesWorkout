//
//  activeWorkoutViewController.m
//  RealDudesWorkout
//
//  Created by Brian Clouser on 3/10/16.
//  Copyright © 2016 The Qwiz LLC. All rights reserved.
//

#import "activeWorkoutViewController.h"

@interface activeWorkoutViewController ()


@property (weak, nonatomic) IBOutlet UIButton *finishedButton;
@property (weak, nonatomic) IBOutlet UIImageView *excerciseImage;
@property (weak, nonatomic) IBOutlet UILabel *topLabel;
@property (weak, nonatomic) IBOutlet UIButton *endWorkoutButton;


@property (weak, nonatomic) IBOutlet UILabel *thisExcerciseLabel;
@property (weak, nonatomic) IBOutlet UILabel *excerciseTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalWorkoutLabel;
@property (weak, nonatomic) IBOutlet UILabel *workoutTimeLabel;

@property (weak, nonatomic) IBOutlet UILabel *lastExcerciseLabel;


@property (strong, nonatomic) NSArray *excercises;
@property (strong, nonatomic) NSArray *excercisesInOrder;
@property (strong, nonatomic) Excercise *currentExcercise;
@property (nonatomic) NSUInteger currentExcerciseIndexValue;

@property (strong, nonatomic) NSTimer *totalWorkoutTimer;
@property (nonatomic) NSTimeInterval totalWorkoutCounter;
@property (nonatomic) NSTimeInterval individualExcerciseCounter;




@end

@implementation activeWorkoutViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // set up the excercise array in order
    
    self.excercises = [self.workout.excercises allObjects];
    
    [self orderExcercises];
    
    self.currentExcerciseIndexValue = 0;
    
    // set up the original screen
    
    [self generateOriginalViewComponents];
    
    // set up and fire the timer
    
    [self setUpTimer];
    
    
}


-(void)countdown
{
    
    self.workoutTimeLabel.text = [self generateTimeStringGivenTime:self.totalWorkoutCounter];
    self.excerciseTimeLabel.text = [self generateTimeStringGivenTime:self.individualExcerciseCounter];
    
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

- (IBAction)excerciseFinishedButtonTapped:(id)sender
{
    BOOL lastExcercise = self.currentExcerciseIndexValue == self.excercisesInOrder.count-1;

    
    if (lastExcercise)
    {
        // present modally workout complete and summary
    }
    
    else
    {
        // update how long it took the do the excercise and assign it to that instance of the excercise;
        
        [self updateIndividualWorkoutTimer];
        
        self.currentExcerciseIndexValue++;
        
        [self updateViewComponents];
        
    }
    
}

- (IBAction)endWorkoutButtonTapped:(id)sender
{
    ((Excercise *)self.excercisesInOrder[self.currentExcerciseIndexValue]).timeInSecondsActual = self.individualExcerciseCounter;
    
    [self.totalWorkoutTimer invalidate];
    
    self.workout.isFinished = YES;
    
    
    //do some other stuff
}

-(void)updateIndividualWorkoutTimer
{

    ((Excercise *)self.excercisesInOrder[self.currentExcerciseIndexValue]).timeInSecondsActual = self.individualExcerciseCounter;
    
    self.individualExcerciseCounter = 0;
    
}

-(void)generateOriginalViewComponents
{
    self.currentExcercise = self.excercisesInOrder[self.currentExcerciseIndexValue];
    
    self.topLabel.text = [self generateTopLabelText];
    self.excerciseImage.image = [UIImage imageNamed:self.currentExcercise.pictureName];
    
    self.thisExcerciseLabel.text = [self generateExcerciseClockLabel];
    
    self.finishedButton.hidden = NO;
    self.endWorkoutButton.hidden = YES;
    self.lastExcerciseLabel.hidden =  YES;
    
    
    
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
    

    if (isLastExcercise)
    {
        self.finishedButton.hidden = YES;
        self.endWorkoutButton.hidden = NO;
        self.lastExcerciseLabel.hidden = NO;
        
        self.lastExcerciseLabel.text = @"Last excercise!";
    }
    
    
    
    
    self.currentExcercise = self.excercisesInOrder[self.currentExcerciseIndexValue];
    
    self.topLabel.text = [self generateTopLabelText];
    self.thisExcerciseLabel.text = [self generateExcerciseClockLabel];
    self.totalWorkoutLabel.text = @"Total Workout:";
   
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
        NSString *labelText = [NSString stringWithFormat:@"Rest for %lli seconds", self.currentExcercise.timeInSecondsSuggested];
        
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
