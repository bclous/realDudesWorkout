//
//  RestView.m
//  RealDudesWorkout
//
//  Created by Brian Clouser on 3/20/16.
//  Copyright © 2016 The Qwiz LLC. All rights reserved.
//

#import "RestView.h"

@interface RestView ()

@property (strong, nonatomic) IBOutlet UIView *restView;

@property (weak, nonatomic) IBOutlet UILabel *excerciseRepsLabel;
@property (weak, nonatomic) IBOutlet UILabel *restCountdownLabel;
@property (weak, nonatomic) IBOutlet UILabel *getReadyLabel;
@property (weak, nonatomic) IBOutlet UISlider *slider;

@property (strong, nonatomic) NSTimer *restTimer;
@property (nonatomic) NSTimeInterval timer;
@property (nonatomic) NSUInteger restCountdown;

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
    
    [self updateExcerciseJustFinishedUI];
}

-(void)setExcerciseSetUpNext:(ExcerciseSet *)excerciseSetUpNext
{
    _excerciseSetUpNext = excerciseSetUpNext;
    
    [self updateExcerciseJustFinishedUI];
}

-(void)updateExcerciseJustFinishedUI
{
    self.restCountdownLabel.text = [NSString stringWithFormat:@"%lld",self.excerciseSetJustFinished.restTimeAfterInSecondsSuggested];
    
    self.excerciseRepsLabel.text = [NSString stringWithFormat:@"I did %lld %@",self.excerciseSetJustFinished.numberOfRepsSuggested, self.excerciseSetJustFinished.excercise.name];
    
    self.getReadyLabel.text = [NSString stringWithFormat:@"and get ready for %@",self.excerciseSetUpNext.excercise.name];
    
    self.restCountdown = self.excerciseSetJustFinished.restTimeAfterInSecondsSuggested;
    
    self.timer = 0;
    
    
    
}


- (IBAction)addThirtySecondsTapped:(id)sender
{
    if (self.restCountdown < 3530)
    {
    
        self.restCountdown = self.restCountdown + 30;
    }
    
}

- (IBAction)subtractThirtySecondsTapped:(id)sender
{
    if (self.restCountdown > 30)
    {
        self.restCountdown = self.restCountdown - 30;
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
    self.restCountdownLabel.text = [self restCountDisplayFromSeconds:self.restCountdown];
    
    if (self.restCountdown > 0)
    {
        self.restCountdown--;
    }
    
    self.timer ++;
    
    self.excerciseSetJustFinished.restTimeAfterInSecondsActual = self.timer;
    
    
    
}

-(NSString *)restCountDisplayFromSeconds:(NSTimeInterval)seconds
{
    NSUInteger minutes = seconds/60;
    NSUInteger remainingSeconds = (NSUInteger)seconds%60;
    
    BOOL noMinutes = minutes == 0;
    BOOL singleDigitSeconds = remainingSeconds < 10;
    
    
    if (noMinutes && singleDigitSeconds)
    {
        NSString *timeString = [NSString stringWithFormat:@"%lu",remainingSeconds];
        
        return timeString;
    }
    else if (noMinutes && !singleDigitSeconds)
    {
        NSString *timeString = [NSString stringWithFormat:@"%lu",remainingSeconds];
        
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
