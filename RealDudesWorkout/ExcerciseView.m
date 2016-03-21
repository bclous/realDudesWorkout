//
//  ExcerciseView.m
//  RealDudesWorkout
//
//  Created by Brian Clouser on 3/20/16.
//  Copyright © 2016 The Qwiz LLC. All rights reserved.
//

#import "ExcerciseView.h"

@implementation ExcerciseView

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
    // do I need to do anythign in here?
    
    [[NSBundle mainBundle] loadNibNamed:@"ExcerciseView" owner:self options:nil];
    
    [self addSubview:self.ExcerciseView];
    
    self.ExcerciseView.frame = self.bounds;
    
    
}


- (IBAction)nextExcerciseButtonTapped:(id)sender
{
   
    
}
@end
