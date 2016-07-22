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
@property (weak, nonatomic) IBOutlet UIImageView *blueCircle;



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
    
    self.blueCircle.alpha = 0;
    self.doneView.layer.cornerRadius = 56;
    self.doneView.alpha = 0;
    self.checkImage.alpha = 0;
    
    
}

-(void)setExcerciseSet:(ExcerciseSet *)excerciseSet
{
    _excerciseSet = excerciseSet;
    
    self.excerciseImage.image = [UIImage imageNamed:excerciseSet.excercise.pictureName];

}

-(void)adjustFormatFinished:(BOOL)finished
{
    
    self.doneView.alpha = finished ? .7 : 0;
    self.checkImage.alpha = finished ? 1 : 0;

}

-(void)setIsNext:(BOOL)isNext
{
    _isNext = isNext;
    
    if (isNext)
    {
        self.blueCircle.alpha = 1;
        
    }
    
    else
    {
        self.blueCircle.alpha = 0;
    }
}

@end
