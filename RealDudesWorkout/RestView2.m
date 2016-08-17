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
@property (weak, nonatomic) IBOutlet UILabel *exerciseNameLabel;
@property (weak, nonatomic) IBOutlet UISlider *slider;

@property (weak, nonatomic) IBOutlet UILabel *timerLabel;


@property (strong, nonatomic) ExcerciseSet *excerciseSetJustFinished;
@property (strong, nonatomic) NSMutableArray *exerciseViewsArray;
@property (nonatomic) NSUInteger previousIndexOfExerciseJustFinished;



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
    
    
}
- (IBAction)addThirtySecondsButtonTapped:(id)sender
{
    if (self.restCountdown < 3530)
    {
        self.restCountdown = self.restCountdown + 30;
        self.timerLabel.text = [NSString timeInClockForm:self.restCountdown];
    }
}
- (IBAction)sliderMoved:(id)sender
{
   
    NSUInteger truncatedValue =  roundf(self.slider.value);
    NSString *label = [NSString stringWithFormat:@"%lu",truncatedValue];
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

-(void)updateRestViewComponentsForIndex:(NSUInteger)index
{
    self.indexOfExcerciseJustFinished = index;
    
    [self resetTimer];
    [self resetSliderLabel];
}

-(void)resetSliderLabel
{
    
    self.slider.continuous = YES;
    self.slider.minimumValue = 0;
    self.slider.maximumValue = 2 * self.excerciseSetJustFinished.numberOfRepsSuggested;
    self.slider.value = self.excerciseSetJustFinished.numberOfRepsSuggested;
    
    self.sliderLabel.text = [NSString stringWithFormat:@"%lld", self.excerciseSetJustFinished.numberOfRepsSuggested, self.excerciseSetJustFinished.excercise.name];
    
    self.exerciseNameLabel.text = [NSString stringWithFormat:@"%@", self.excerciseSetJustFinished.excercise.name];
}

-(void)setIndexOfExerciseUpNext:(NSUInteger)indexOfExerciseUpNext
{
    _indexOfExerciseUpNext = indexOfExerciseUpNext;
    
    ExcerciseSet *nextExcerciseSet = self.excerciseSets[indexOfExerciseUpNext];
    self.nextWorkoutLabel.text = [NSString stringWithFormat:@"Up next: %@",nextExcerciseSet.excercise.name];
}

-(void)resetTimer
{
    self.restCountdown = self.excerciseSetJustFinished.restTimeAfterInSecondsSuggested;
    self.restStartTime = [[NSDate date] timeIntervalSince1970];
    self.timerLabel.text = [NSString timeInClockForm:self.restCountdown];
}

-(void)setIndexOfExcerciseJustFinished:(NSUInteger)indexOfExcerciseJustFinished
{
    _indexOfExcerciseJustFinished = indexOfExcerciseJustFinished;
    
    self.excerciseSetJustFinished = self.excerciseSets[indexOfExcerciseJustFinished];
}

@end
