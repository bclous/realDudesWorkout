//
//  ExcerciseView.m
//  RealDudesWorkout
//
//  Created by Brian Clouser on 3/20/16.
//  Copyright © 2016 The Qwiz LLC. All rights reserved.
//

#import "ExcerciseView.h"

@interface ExcerciseView ()

@property (weak, nonatomic) IBOutlet UILabel *numberOfRepsLabel;
@property (weak, nonatomic) IBOutlet UILabel *excerciseNameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *excerciseImage;
@property (strong, nonatomic) IBOutlet UIView *excerciseView;


@end

@implementation ExcerciseView

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
    // do I need to do anythign in here?
    
    [[NSBundle mainBundle] loadNibNamed:@"ExcerciseView" owner:self options:nil];
    
    [self addSubview:self.excerciseView];
    
    self.excerciseView.frame = self.bounds;
    
    
}

-(void)setExcerciseSet:(ExcerciseSet *)excerciseSet
{
    _excerciseSet = excerciseSet;
    
    [self updateUI];
}

-(void)updateUI
{
    self.numberOfRepsLabel.text = [NSString stringWithFormat:@"%lld",self.excerciseSet.numberOfRepsSuggested];
    self.excerciseNameLabel.text = self.excerciseSet.excercise.name;
    self.excerciseImage.image = [UIImage imageNamed:self.excerciseSet.excercise.pictureName];
    
}


@end
