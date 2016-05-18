//
//  ExcerciseTotalView.m
//  RealDudesWorkout
//
//  Created by Brian Clouser on 5/16/16.
//  Copyright © 2016 The Qwiz LLC. All rights reserved.
//

#import "ExcerciseTotalView.h"

@interface ExcerciseTotalView ()

@property (strong, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UILabel *numberTotalLabel;
@property (weak, nonatomic) IBOutlet UIImageView *excerciseImage;
@property (weak, nonatomic) IBOutlet UILabel *excerciseNameLabel;

@end

@implementation ExcerciseTotalView

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
    
    
    [[NSBundle mainBundle] loadNibNamed:@"ExcerciseTotal" owner:self options:nil];
    
    [self addSubview:self.contentView];
    
    self.contentView.frame = self.bounds;
    
  
    
}

-(void)setExcerciseSet:(ExcerciseSet *)excerciseSet
{
    
    _excerciseSet = excerciseSet;
    
    self.numberTotalLabel.text = [NSString stringWithFormat:@"%lld",self.excerciseSet.numberofRepsActual];
    
    self.excerciseImage.image = [UIImage imageNamed:self.excerciseSet.excercise.pictureName];
    
    self.excerciseNameLabel.text = self.excerciseSet.excercise.name;
    
}

@end
