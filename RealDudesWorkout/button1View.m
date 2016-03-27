//
//  button1View.m
//  RealDudesWorkout
//
//  Created by Brian Clouser on 3/26/16.
//  Copyright © 2016 The Qwiz LLC. All rights reserved.
//

#import "button1View.h"

@interface button1View ()

@property (strong, nonatomic) IBOutlet UIView *contentView;


@end


@implementation button1View

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

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
    
    
    [[NSBundle mainBundle] loadNibNamed:@"Button" owner:self options:nil];
    
    [self addSubview:self.contentView];
    
    self.contentView.frame = self.bounds;
    
    
    
    
}


@end
