//
//  WeeklyWorkoutTotalsView.m
//  RealDudesWorkout
//
//  Created by Brian Clouser on 6/27/16.
//  Copyright © 2016 The Qwiz LLC. All rights reserved.
//

#import "WeeklyWorkoutTotalsView.h"

@interface WeeklyWorkoutTotalsView ()

@property (strong, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UIStackView *weekCircleStackView;


@end

@implementation WeeklyWorkoutTotalsView


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
    
    [[NSBundle mainBundle] loadNibNamed:@"WeeklyWorkoutTotals" owner:self options:nil];
    
    [self addSubview:self.contentView];
    
    self.contentView.frame = self.bounds;
    
    for (UIView *view in [self.weekCircleStackView subviews])
    {
        view.layer.cornerRadius = view.bounds.size.height / 2;
    }
    
}


@end
