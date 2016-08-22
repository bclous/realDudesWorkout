//
//  WorkoutOverRestView.m
//  RealDudesWorkout
//
//  Created by Brian Clouser on 8/18/16.
//  Copyright © 2016 The Qwiz LLC. All rights reserved.
//

#import "WorkoutOverRestView.h"
#import "UIColor+BDC_Color.h"

@interface WorkoutOverRestView ()

@property (strong, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *blueWidthConstraint;

@property (weak, nonatomic) IBOutlet UIImageView *checkMarkImage;
@property (weak, nonatomic) IBOutlet UIView *blueImage;
@property (weak, nonatomic) IBOutlet UILabel *bottomText;
@property (weak, nonatomic) IBOutlet UILabel *workoutFinishedLabel;

@end

@implementation WorkoutOverRestView

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
    [[NSBundle mainBundle] loadNibNamed:@"WorkoutOverRestView" owner:self options:nil];
    [self addSubview:self.contentView];
    self.contentView.frame = self.bounds;
    [self bringSubviewToFront:self.checkMarkImage];
    self.blueImage.layer.cornerRadius = 73;
    [self layoutIfNeeded];
    self.workoutFinishedLabel.textColor = [UIColor bdc_lightText1];
    self.bottomText.textColor = [UIColor bdc_lightText3];
 
}  

-(void)adjustBlueCircleOn:(BOOL)on animate:(BOOL)animate
{
    self.blueWidthConstraint.constant = on ? 146 : 0;
 
    CGFloat duration = animate ? .4 : 0;
    
   [UIView animateWithDuration:duration delay:0 options:0 animations:^{
       [self layoutIfNeeded];
   } completion:^(BOOL finished) {
       // nada
   }];
}

@end
