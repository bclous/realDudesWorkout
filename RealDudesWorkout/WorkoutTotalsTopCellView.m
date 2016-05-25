//
//  WorkoutTotalsTopCellView.m
//  RealDudesWorkout
//
//  Created by Brian Clouser on 5/25/16.
//  Copyright © 2016 The Qwiz LLC. All rights reserved.
//

#import "WorkoutTotalsTopCellView.h"

@interface WorkoutTotalsTopCellView ()

@property (strong, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UIView *circle1;
@property (weak, nonatomic) IBOutlet UIView *circle2;
@property (weak, nonatomic) IBOutlet UIView *circle3;
@property (weak, nonatomic) IBOutlet UIView *circle4;


@end

@implementation WorkoutTotalsTopCellView

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
    
    
    [[NSBundle mainBundle] loadNibNamed:@"WorkoutTotalsTopCell" owner:self options:nil];
    
    [self addSubview:self.contentView];
    
    self.contentView.frame = self.bounds;
    
    self.circle1.layer.cornerRadius =5;
    self.circle2.layer.cornerRadius =5;
    self.circle3.layer.cornerRadius =5;
    self.circle4.layer.cornerRadius =5;
    
    
}

@end
