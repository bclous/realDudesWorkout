//
//  GenerateWorkoutExcerciseView.m
//  RealDudesWorkout
//
//  Created by Brian Clouser on 5/21/16.
//  Copyright © 2016 The Qwiz LLC. All rights reserved.
//

#import "GenerateWorkoutExcerciseView.h"

@interface GenerateWorkoutExcerciseView ()

@property (strong, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UILabel *excerciseNameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *excerciseImageView;
@property (weak, nonatomic) IBOutlet UIView *outerCircleView;
@property (weak, nonatomic) IBOutlet UIView *innerCircleView;


@end

@implementation GenerateWorkoutExcerciseView

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
    
    [[NSBundle mainBundle] loadNibNamed:@"GenerateWorkoutExcercise" owner:self options:nil];
    
    [self addSubview:self.contentView];
    
    self.contentView.frame = self.bounds;
    
    self.outerCircleView.layer.cornerRadius = 80;
    self.innerCircleView.layer.cornerRadius = 79;
    
}

-(void)setExcerciseSet:(ExcerciseSet *)excerciseSet
{
    _excerciseSet = excerciseSet;
    
    self.excerciseNameLabel.text = [NSString stringWithFormat:@"%lld %@",excerciseSet.numberOfRepsSuggested, excerciseSet.excercise.name];
    
    self.excerciseImageView.image = [UIImage imageNamed:excerciseSet.excercise.pictureName];
}




@end
