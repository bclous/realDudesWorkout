//
//  RestView2.m
//  RealDudesWorkout
//
//  Created by Brian Clouser on 5/23/16.
//  Copyright © 2016 The Qwiz LLC. All rights reserved.
//

#import "RestView2.h"
#import "ExcerciseRestView.h"


@interface RestView2 ()

@property (strong, nonatomic) IBOutlet UIView *contentView;

@property (weak, nonatomic) IBOutlet UILabel *sliderLabel;
@property (weak, nonatomic) IBOutlet UISlider *slider;

@property (weak, nonatomic) IBOutlet UILabel *timerLabel;
@property (weak, nonatomic) IBOutlet UILabel *nextWorkoutLabel;

@property (weak, nonatomic) IBOutlet ExcerciseRestView *lastExcerciseRestView;
@property (weak, nonatomic) IBOutlet ExcerciseRestView *nextExcerciseRestView;
@property (weak, nonatomic) IBOutlet ExcerciseRestView *afterExcerciseRestView;

@property (strong, nonatomic) ExcerciseSet *excerciseSetJustFinished;

@property (strong, nonatomic) NSArray *excerciseSets;

@property (strong, nonatomic) NSTimer *timer;
@property (nonatomic) NSTimeInterval timerInterval;
@property (nonatomic) NSUInteger restCountdown;

@property (nonatomic) NSTimeInterval restStartTime;

@end

@implementation RestView2

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
    [[NSBundle mainBundle] loadNibNamed:@"RestView2" owner:self options:nil];
    
    [self addSubview:self.contentView];
    
    self.contentView.frame = self.bounds;
    
    self.nextExcerciseRestView.isNext = YES;
}
- (IBAction)addThirtySecondsButtonTapped:(id)sender
{
    
    if (self.restCountdown < 3530)
    {
        self.restCountdown = self.restCountdown + 30;
        self.timerLabel.text = [self restCountDisplayFromSeconds:self.restCountdown];
    }
    
}
- (IBAction)sliderMoved:(id)sender
{
   
    NSUInteger truncatedValue =  roundf(self.slider.value);
    
    NSString *label = [NSString stringWithFormat:@"You did %lu %@",truncatedValue, self.excerciseSetJustFinished.excercise.name];
    
    self.sliderLabel.text = label;
    
    self.excerciseSetJustFinished.numberofRepsActual = truncatedValue;
}


-(void)countdown
{
    if (self.restCountdown == 0)
    {
        return;
    }
    
    if (self.restCountdown - ([[NSDate date] timeIntervalSince1970] - self.restStartTime) < -10)
    {
        self.restCountdown = 0 ;
    }
    else
    {
        self.restCountdown--;
    }
    self.timerLabel.text = [NSString timeInClockForm:self.restCountdown];
    self.restStartTime = [[NSDate date] timeIntervalSince1970];
}

-(void)setWorkout:(Workout *)workout
{
    _workout = workout;
    
    self.excerciseSets = [workout excercisesInOrder];
    
}

-(void)setIndexOfExcerciseJustFinished:(NSUInteger)indexOfExcerciseJustFinished
{
    _indexOfExcerciseJustFinished = indexOfExcerciseJustFinished;
    
    self.excerciseSetJustFinished = self.excerciseSets[indexOfExcerciseJustFinished];
    [self resetTimer];
    [self resetPicturesAndLabel];
    [self resetSliderLabel];
}

-(void)resetSliderLabel
{
    
    self.slider.continuous = YES;
    self.slider.minimumValue = 0;
    self.slider.maximumValue = 2 * self.excerciseSetJustFinished.numberOfRepsSuggested;
    self.slider.value = self.excerciseSetJustFinished.numberOfRepsSuggested;
    
    self.sliderLabel.text = [NSString stringWithFormat:@"You did %lld %@", self.excerciseSetJustFinished.numberOfRepsSuggested, self.excerciseSetJustFinished.excercise.name];
}

-(void)resetPicturesAndLabel
{
    BOOL isLastExcercise = self.indexOfExcerciseJustFinished == self.excerciseSets.count - 1;
    BOOL isNextToLastExcercise = self.indexOfExcerciseJustFinished == self.excerciseSets.count - 2;
    
    if (isLastExcercise)
    {
        
        //need to change these
        self.lastExcerciseRestView.excerciseSet = self.excerciseSets[self.indexOfExcerciseJustFinished];
        self.nextExcerciseRestView.excerciseSet = self.excerciseSets[self.indexOfExcerciseJustFinished];
        self.afterExcerciseRestView.excerciseSet = self.excerciseSets[self.indexOfExcerciseJustFinished];
        
        self.nextWorkoutLabel.text = [NSString stringWithFormat:@"you are all done champ"];
        
    }
    
    else if (isNextToLastExcercise)
    {
        self.lastExcerciseRestView.excerciseSet = self.excerciseSets[self.indexOfExcerciseJustFinished];
        self.nextExcerciseRestView.excerciseSet = self.excerciseSets[self.indexOfExcerciseJustFinished + 1];
        self.afterExcerciseRestView.excerciseSet = self.excerciseSets[self.indexOfExcerciseJustFinished + 1];
        
        ExcerciseSet *nextExcerciseSet = self.excerciseSets[self.indexOfExcerciseJustFinished + 1];
        
        self.nextWorkoutLabel.text = [NSString stringWithFormat:@"and get ready for %@",nextExcerciseSet.excercise.name];
    }
    
    else
    {
        self.lastExcerciseRestView.excerciseSet = self.excerciseSets[self.indexOfExcerciseJustFinished];
        self.nextExcerciseRestView.excerciseSet = self.excerciseSets[self.indexOfExcerciseJustFinished + 1];
        self.afterExcerciseRestView.excerciseSet = self.excerciseSets[self.indexOfExcerciseJustFinished + 2];
        
        ExcerciseSet *nextExcerciseSet = self.excerciseSets[self.indexOfExcerciseJustFinished + 1];
        
        self.nextWorkoutLabel.text = [NSString stringWithFormat:@"and get ready for %@",nextExcerciseSet.excercise.name];
    }
}

-(void)resetTimer
{
    
    self.restCountdown = self.excerciseSetJustFinished.restTimeAfterInSecondsSuggested;
    self.restStartTime = [[NSDate date] timeIntervalSince1970];
    self.timerLabel.text = [NSString timeInClockForm:self.restCountdown];
}


-(NSString *)restCountDisplayFromSeconds:(NSTimeInterval)seconds
{
    NSUInteger minutes = seconds/60;
    NSUInteger remainingSeconds = (NSUInteger)seconds%60;
    
    BOOL noMinutes = minutes == 0;
    BOOL singleDigitSeconds = remainingSeconds < 10;
    
    
    if (noMinutes && singleDigitSeconds)
    {
        NSString *timeString = [NSString stringWithFormat:@"0:0%lu",remainingSeconds];
        
        return timeString;
    }
    else if (noMinutes && !singleDigitSeconds)
    {
        NSString *timeString = [NSString stringWithFormat:@"0:%lu",remainingSeconds];
        
        return timeString;
        
    }
    else if (!noMinutes && singleDigitSeconds)
    {
        NSString *timeString = [NSString stringWithFormat:@"%lu:0%lu",minutes, remainingSeconds];
        
        return timeString;
    }
    else
    {
        NSString *timeString = [NSString stringWithFormat:@"%lu:%lu",minutes, remainingSeconds];
        
        return timeString;
    }
    
}

@end
