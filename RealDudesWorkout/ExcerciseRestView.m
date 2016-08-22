//
//  ExcerciseRestView.m
//  RealDudesWorkout
//
//  Created by Brian Clouser on 5/23/16.
//  Copyright © 2016 The Qwiz LLC. All rights reserved.
//

#import "ExcerciseRestView.h"

@interface ExcerciseRestView ()

@property (strong, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UIImageView *excerciseImage;
@property (weak, nonatomic) IBOutlet UIView *doneBlackView;
@property (weak, nonatomic) IBOutlet UIView *doneGreenBlackView;
@property (weak, nonatomic) IBOutlet UIImageView *blueCircleView;




@end

@implementation ExcerciseRestView

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
    
    [[NSBundle mainBundle] loadNibNamed:@"ExcerciseRestView" owner:self options:nil];
    
    [self addSubview:self.contentView];
    
    self.contentView.frame = self.bounds;
    
    self.doneView.layer.cornerRadius = 29;
    self.doneGreenBlackView.layer.cornerRadius = 3;
    self.doneBlackView.layer.cornerRadius = 6;
    self.doneView.alpha = 0;
    self.doneGreenBlackView.alpha = 0;
    self.doneBlackView.alpha = 0;
    [self formatExerciseView];
}

-(void)setExcerciseSet:(ExcerciseSet *)excerciseSet
{
    _excerciseSet = excerciseSet;
    
    self.excerciseImage.image = [UIImage imageNamed:excerciseSet.excercise.pictureName];
}

-(void)formatExerciseView
{
    BOOL isCurrentExercise = self.index == [self.delegate currentIndex];
    BOOL isComplete = self.excerciseSet.isComplete;
    
    if(isCurrentExercise)
    {
        self.doneView.alpha = .0;
        self.doneBlackView.alpha = .0;
        self.doneGreenBlackView.alpha = 0;
        self.blueCircleView.alpha = 1;
    }
    else if (isComplete)
    {
        self.doneView.alpha = .7;
        //self.doneBlackView.alpha = 1;
        //self.doneGreenBlackView.alpha = 1;
        self.blueCircleView.alpha = 0;
        //self.doneGreenBlackView.backgroundColor = [UIColor colorWithRed:83.0/255.0 green:163.0/255.0 blue:1 alpha:1];
        self.userInteractionEnabled = NO;
    }
    else
    {
        self.doneView.alpha = 0;
        self.doneBlackView.alpha = 0;
        self.doneGreenBlackView.alpha = 0;
        self.blueCircleView.alpha = 0;
    }
    
}

- (IBAction)exerciseTapped:(id)sender {
    
    [self.delegate exerciseTappedAtIndex:self.index];
}


@end
