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
    
    
}

@end
