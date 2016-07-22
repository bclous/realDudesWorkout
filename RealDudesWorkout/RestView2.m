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
@property (weak, nonatomic) IBOutlet UILabel *nextWorkoutLabel;
@property (weak, nonatomic) IBOutlet UIStackView *exerciseStackView;
@property (weak, nonatomic) IBOutlet UIScrollView *exerciseScrollView;

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
    
    //self.nextExcerciseRestView.isNext = YES;
    
    _exerciseViewsArray = [[NSMutableArray alloc] init];
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
    
    [self generateExerciseStackView];
    
}

-(void)generateExerciseStackView
{
    
    UIView *fillerView = [[UIView alloc] init];
    [self.exerciseStackView addArrangedSubview:fillerView];
    [fillerView.heightAnchor constraintEqualToAnchor:self.exerciseStackView.heightAnchor].active = YES;
    [fillerView.widthAnchor constraintEqualToAnchor:self.widthAnchor multiplier:.5 constant:-70].active = YES;
    fillerView.backgroundColor = [UIColor clearColor];
    
    for (ExcerciseSet *excerciseSet in self.excerciseSets)
    {
        ExcerciseRestView *excerciseView = [[ExcerciseRestView alloc] init];
        excerciseView.excerciseSet = excerciseSet;
        [self.exerciseStackView addArrangedSubview:excerciseView];
        [excerciseView.heightAnchor constraintEqualToAnchor:self.exerciseStackView.heightAnchor].active = YES;
        [excerciseView.widthAnchor constraintEqualToAnchor:self.exerciseStackView.heightAnchor].active = YES;
        [self.exerciseViewsArray addObject:excerciseView];
    }
}

-(void)setIndexOfExcerciseJustFinished:(NSUInteger)indexOfExcerciseJustFinished
{
    self.preservesSuperviewLayoutMargins = self.indexOfExcerciseJustFinished;
    
    _indexOfExcerciseJustFinished = indexOfExcerciseJustFinished;
    
    self.excerciseSetJustFinished = self.excerciseSets[indexOfExcerciseJustFinished];
    [self resetTimer];
    [self resetPicturesAndLabel];
    [self resetSliderLabel];
    
    [self layoutIfNeeded];

}
//
//-(void)updateScrollView
//{
//    ExcerciseRestView *justFinishedView = self.exerciseViewsArray[self.indexOfExcerciseJustFinished];
//    
//    [UIView animateWithDuration:.02 delay:.2 options:nil
//                     animations:^{
//                         [justFinishedView adjustFormatFinished:YES];
//                     
//                     } completion:^(BOOL finished) {
//                         CGPoint offset;
//                         offset.y = 0;
//                         offset.x = self.exerciseScrollView.contentOffset.x + 130;
//                         
//                         [self.exerciseScrollView setContentOffset:offset animated:YES];
//                     }];
//}

-(void)updateScrollViewAnimate:(BOOL)animate
{
    CGPoint offset;
    offset.y = 0;
    offset.x = 130 * self.indexOfExcerciseJustFinished + 130;
    
    BOOL forwards = self.indexOfExcerciseJustFinished > self.previousIndexOfExerciseJustFinished;
    CGFloat delay = animate ? .2 : 0;
    CGFloat duration = animate ? .02 : 0;
    
    
    if (forwards)
    {
       [UIView animateWithDuration:duration delay:delay options:nil animations:^{
           ExcerciseRestView *justFinishedView = self.exerciseViewsArray[self.indexOfExcerciseJustFinished];
           [justFinishedView adjustFormatFinished:YES];
       } completion:^(BOOL finished) {
           [self.exerciseScrollView setContentOffset:offset animated:animate];
       }];
    }
    
    else
    {
        [self.exerciseScrollView setContentOffset:offset animated:animate];
        ExcerciseRestView *reversed = self.exerciseViewsArray[self.previousIndexOfExerciseJustFinished];
        [reversed adjustFormatFinished:NO];
    
    }

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

-(void)resetPicturesAndLabel
{
    BOOL isLastExcercise = self.indexOfExcerciseJustFinished == self.excerciseSets.count - 1;
    BOOL isNextToLastExcercise = self.indexOfExcerciseJustFinished == self.excerciseSets.count - 2;
    
    if (isLastExcercise)
    {
        
        //need to change these
//        self.lastExcerciseRestView.excerciseSet = self.excerciseSets[self.indexOfExcerciseJustFinished];
//        self.nextExcerciseRestView.excerciseSet = self.excerciseSets[self.indexOfExcerciseJustFinished];
//        self.afterExcerciseRestView.excerciseSet = self.excerciseSets[self.indexOfExcerciseJustFinished];
        
        self.nextWorkoutLabel.text = [NSString stringWithFormat:@"you are all done champ"];
        
    }
    
    else if (isNextToLastExcercise)
    {
//        self.lastExcerciseRestView.excerciseSet = self.excerciseSets[self.indexOfExcerciseJustFinished];
//        self.nextExcerciseRestView.excerciseSet = self.excerciseSets[self.indexOfExcerciseJustFinished + 1];
//        self.afterExcerciseRestView.excerciseSet = self.excerciseSets[self.indexOfExcerciseJustFinished + 1];
        
        ExcerciseSet *nextExcerciseSet = self.excerciseSets[self.indexOfExcerciseJustFinished + 1];
        
        self.nextWorkoutLabel.text = [NSString stringWithFormat:@"and get ready for %@",nextExcerciseSet.excercise.name];
    }
    
    else
    {
//        self.lastExcerciseRestView.excerciseSet = self.excerciseSets[self.indexOfExcerciseJustFinished];
//        self.nextExcerciseRestView.excerciseSet = self.excerciseSets[self.indexOfExcerciseJustFinished + 1];
//        self.afterExcerciseRestView.excerciseSet = self.excerciseSets[self.indexOfExcerciseJustFinished + 2];
        
        ExcerciseSet *nextExcerciseSet = self.excerciseSets[self.indexOfExcerciseJustFinished + 1];
        
        self.nextWorkoutLabel.text = [NSString stringWithFormat:@"Up next: %@",nextExcerciseSet.excercise.name];
    }
}

-(void)resetTimer
{
    self.restCountdown = self.excerciseSetJustFinished.restTimeAfterInSecondsSuggested;
    self.restStartTime = [[NSDate date] timeIntervalSince1970];
    self.timerLabel.text = [NSString timeInClockForm:self.restCountdown];
}

@end
