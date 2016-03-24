//
//  RestView.m
//  RealDudesWorkout
//
//  Created by Brian Clouser on 3/20/16.
//  Copyright © 2016 The Qwiz LLC. All rights reserved.
//

#import "RestView.h"
#import <Math.h>

@interface RestView ()

@property (strong, nonatomic) IBOutlet UIView *restView;

@property (weak, nonatomic) IBOutlet UILabel *excerciseRepsLabel;
@property (weak, nonatomic) IBOutlet UILabel *restCountdownLabel;
@property (weak, nonatomic) IBOutlet UILabel *getReadyLabel;
@property (weak, nonatomic) IBOutlet UISlider *slider;

@property (strong, nonatomic) NSTimer *restTimer;
@property (nonatomic) NSTimeInterval timer;
@property (nonatomic) NSUInteger restCountdown;
@property (weak, nonatomic) IBOutlet UILabel *workoutCompleteLabel;

@property (weak, nonatomic) IBOutlet UIButton *addThirtySecondsButton;
@property (weak, nonatomic) IBOutlet UILabel *addThirtySecondsLabel;
@property (weak, nonatomic) IBOutlet UILabel *restForLabel;

@end

@implementation RestView

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
   
    
    [[NSBundle mainBundle] loadNibNamed:@"RestView" owner:self options:nil];
    
    [self addSubview:self.restView];
    
    self.restView.frame = self.bounds;
    
    [self setUpTimer];
    
    
}

-(void)setExcerciseSetJustFinished:(ExcerciseSet *)excerciseSetJustFinished
{
    _excerciseSetJustFinished = excerciseSetJustFinished;
    
    //[self updateExcerciseJustFinishedUI];
    
}

-(void)setExcerciseSetUpNext:(ExcerciseSet *)excerciseSetUpNext
{
    _excerciseSetUpNext = excerciseSetUpNext;
    
    [self updateExcerciseJustFinishedUI];
}

-(void)updateExcerciseJustFinishedUI
{
    
    BOOL isLastExcercise = [self.excerciseSetJustFinished.excercise.name isEqualToString:self.excerciseSetUpNext.excercise.name];
    
    if (isLastExcercise)
    {
        
        NSLog(@"is last excercise, just finished is %@ and next up is %@", self.excerciseSetJustFinished.excercise.name, self.excerciseSetUpNext.excercise.name);
        
        self.restCountdownLabel.hidden = YES;
        self.getReadyLabel.hidden = YES;
        self.restCountdownLabel.hidden = YES;
        
        self.workoutCompleteLabel.hidden = NO;
        
        self.addThirtySecondsButton.enabled = NO;
        self.addThirtySecondsButton.hidden = YES;
        self.addThirtySecondsLabel.hidden = YES;
        self.restForLabel.hidden = YES;
        
        self.excerciseRepsLabel.text = [NSString stringWithFormat:@"I did %lld %@",self.excerciseSetJustFinished.numberOfRepsSuggested, self.excerciseSetJustFinished.excercise.name];
        
        self.slider.continuous = YES;
        self.slider.minimumValue = 0;
        self.slider.maximumValue = 2 * self.excerciseSetJustFinished.numberOfRepsSuggested;
        self.slider.value = self.excerciseSetJustFinished.numberOfRepsSuggested;
        

        
        
        
    }
    else
    {
        NSLog(@"getting into not last excercise");
        
        self.workoutCompleteLabel.hidden = YES;
        
        self.restCountdownLabel.text = [self restCountDisplayFromSeconds:self.excerciseSetJustFinished.restTimeAfterInSecondsSuggested];
        
        self.excerciseRepsLabel.text = [NSString stringWithFormat:@"I did %lld %@",self.excerciseSetJustFinished.numberOfRepsSuggested, self.excerciseSetJustFinished.excercise.name];
        
        self.getReadyLabel.text = [NSString stringWithFormat:@"and get ready for %@",self.excerciseSetUpNext.excercise.name];
        
        self.restCountdown = self.excerciseSetJustFinished.restTimeAfterInSecondsSuggested;
        
        self.slider.continuous = YES;
        self.slider.minimumValue = 0;
        self.slider.maximumValue = 2 * self.excerciseSetJustFinished.numberOfRepsSuggested;
        self.slider.value = self.excerciseSetJustFinished.numberOfRepsSuggested;
    }
    
    
    
  
    
    

    self.timer = 0;
    
    
    
}

- (IBAction)sliderMoved:(id)sender
{
    
    NSUInteger truncatedValue =  roundf(self.slider.value);
    
    NSString *label = [NSString stringWithFormat:@"I did %lu %@",truncatedValue, self.excerciseSetJustFinished.excercise.name];
    
    self.excerciseRepsLabel.text = label;
    
    self.excerciseSetJustFinished.numberofRepsActual = truncatedValue;
    
    NSLog(@")number of reps for %@ was set to: %lld",self.excerciseSetJustFinished.excercise.name, self.excerciseSetJustFinished.numberofRepsActual);
    
    
}



- (IBAction)addThirtySecondsTapped:(id)sender
{
    if (self.restCountdown < 3530)
    {
    
        self.restCountdown = self.restCountdown + 30;
        self.restCountdownLabel.text = [self restCountDisplayFromSeconds:self.restCountdown];
    }
    
}


- (IBAction)subtractThirtySecondsTapped:(id)sender
{
    if (self.restCountdown > 30)
    {
        self.restCountdown = self.restCountdown - 30;
        self.restCountdownLabel.text = [self restCountDisplayFromSeconds:self.restCountdown];
    }
}

-(void)setUpTimer
{
    self.timer = 0;
 
    self.restTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(countdown) userInfo:nil repeats:YES];
    
    [self.restTimer fire];
}

-(void)countdown
{
    
    if (self.restCountdown > 0)
    {
        self.restCountdown--;
    }
    
    self.restCountdownLabel.text = [self restCountDisplayFromSeconds:self.restCountdown];

    
    self.timer++;
    
  
    
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
