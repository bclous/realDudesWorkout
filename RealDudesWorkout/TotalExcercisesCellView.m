//
//  TotalExcercisesCellView.m
//  RealDudesWorkout
//
//  Created by Brian Clouser on 4/2/16.
//  Copyright © 2016 The Qwiz LLC. All rights reserved.
//

#import "TotalExcercisesCellView.h"

@interface TotalExcercisesCellView ()

@property (strong, nonatomic) IBOutlet UIView *contentView;

@end

@implementation TotalExcercisesCellView

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
    
    
    [[NSBundle mainBundle] loadNibNamed:@"TotalExcercisesCell" owner:self options:nil];
    
    [self addSubview:self.contentView];
    
    self.contentView.frame = self.bounds;
    
}


@end
