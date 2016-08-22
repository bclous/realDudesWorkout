//
//  ExerciseDescriptionView.m
//  RealDudesWorkout
//
//  Created by Brian Clouser on 6/6/16.
//  Copyright © 2016 The Qwiz LLC. All rights reserved.
//

#import "ExerciseDescriptionView.h"

@interface ExerciseDescriptionView ()

@property (strong, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UITextView *exerciseDescriptionTextField;
@property (weak, nonatomic) IBOutlet UILabel *exerciseNameLabel;
@property (weak, nonatomic) IBOutlet UIVisualEffectView *blurView;



@end

@implementation ExerciseDescriptionView

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

    
    [[NSBundle mainBundle] loadNibNamed:@"ExerciseDescription" owner:self options:nil];
    
    [self addSubview:self.contentView];
    
    self.contentView.frame = self.bounds;
}

-(void)setExcerciseSet:(ExcerciseSet *)excerciseSet
{
    _excerciseSet = excerciseSet;
    
    self.exerciseDescriptionTextField.text = excerciseSet.excercise.excerciseDescription;
    self.exerciseNameLabel.text = [excerciseSet.excercise.name capitalizedString];
    self.exerciseDescriptionTextField.textColor = [UIColor grayColor];
    [self.exerciseDescriptionTextField.font fontWithSize:80];
    
}

- (IBAction)screenTapped:(id)sender
{
    
    [self.delegate leaveDescriptionViewTapped];
    
}

@end
