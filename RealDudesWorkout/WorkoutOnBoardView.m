//
//  WorkoutOnBoardView.m
//  RealDudesWorkout
//
//  Created by Brian Clouser on 5/20/16.
//  Copyright © 2016 The Qwiz LLC. All rights reserved.
//

#import "WorkoutOnBoardView.h"

@interface WorkoutOnBoardView ()

@property (strong, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UIButton *startButton;
@property (weak, nonatomic) IBOutlet UIStackView *minusLabel;
@property (weak, nonatomic) IBOutlet UILabel *plusLabel;
@property (weak, nonatomic) IBOutlet UILabel *minutesLabel;

@property (nonatomic) NSUInteger workoutLength;


@end

@implementation WorkoutOnBoardView

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
    
    
    [[NSBundle mainBundle] loadNibNamed:@"WorkoutOnBoard" owner:self options:nil];
    
    [self addSubview:self.contentView];
    
    self.contentView.frame = self.bounds;
    
    self.startButton.layer.cornerRadius = 15;
    
    self.workoutLength = 30;
    
    [self updateMinutesLabel];

    
}

- (IBAction)startButtonTapped:(id)sender
{
    [self.delegate generateWorkoutTapped];
}
- (IBAction)minusMinutesTapped:(id)sender
{
    
    if (!(self.workoutLength <= 5))
    {
        self.workoutLength = self.workoutLength - 5;
        
        [self updateMinutesLabel];
    }
    
    
}
- (IBAction)plusMinutesTapped:(id)sender
{
    
    if (self.workoutLength < 75)
    {
        self.workoutLength = self.workoutLength + 5;
        
        [self updateMinutesLabel];
    }
    
    
}

-(void)updateMinutesLabel
{
    
    self.minutesLabel.text = [NSString stringWithFormat:@"%lu", (unsigned long)self.workoutLength];
    
}

@end
