//
//  ExcerciseCellView.m
//  RealDudesWorkout
//
//  Created by Brian Clouser on 3/24/16.
//  Copyright © 2016 The Qwiz LLC. All rights reserved.
//

#import "ExcerciseCellView.h"
#import "Excercise.h"

@interface ExcerciseCellView ()

@property (strong, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UIImageView *excerciseImage;
@property (weak, nonatomic) IBOutlet UILabel *excerciseRepsAndName;
@property (weak, nonatomic) IBOutlet UILabel *durationLabel;


@end

@implementation ExcerciseCellView

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
    [[NSBundle mainBundle] loadNibNamed:@"ExcerciseCell" owner:self options:nil];
    
    [self addSubview:self.contentView];
    
    self.contentView.frame = self.bounds;
    
}

-(void)setExcerciseSet:(ExcerciseSet *)excerciseSet
{
    _excerciseSet = excerciseSet;
    
    self.excerciseImage.image = [UIImage imageNamed:self.excerciseSet.excercise.pictureName];
    
    self.excerciseRepsAndName.text = [NSString stringWithFormat:@"%lld %@",self.excerciseSet.numberofRepsActual, self.excerciseSet.excercise.name];
    
    self.durationLabel.text = [self.excerciseSet generateExcerciseDurationTimeString];
    
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
