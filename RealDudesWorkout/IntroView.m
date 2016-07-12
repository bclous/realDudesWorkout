//
//  IntroView.m
//  RealDudesWorkout
//
//  Created by Brian Clouser on 7/11/16.
//  Copyright © 2016 The Qwiz LLC. All rights reserved.
//

#import "IntroView.h"

@interface IntroView ()

@property (strong, nonatomic) IBOutlet UIView *contentView;

@end

@implementation IntroView

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
    
    [[NSBundle mainBundle] loadNibNamed:@"IntroView" owner:self options:nil];
    
    [self addSubview:self.contentView];
    
    self.contentView.frame = self.bounds;
    
}



@end
