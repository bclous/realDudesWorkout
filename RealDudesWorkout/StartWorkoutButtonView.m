//
//  StartWorkoutButtonView.m
//  RealDudesWorkout
//
//  Created by Brian Clouser on 5/18/16.
//  Copyright © 2016 The Qwiz LLC. All rights reserved.
//

#import "StartWorkoutButtonView.h"

@interface StartWorkoutButtonView ()

@property (strong, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UIVisualEffectView *blurView;


@end

@implementation StartWorkoutButtonView

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
    
    
    [[NSBundle mainBundle] loadNibNamed:@"StartWorkoutButton" owner:self options:nil];
    
    [self addSubview:self.contentView];
    
    self.contentView.frame = self.bounds;
    
    self.blurView.layer.cornerRadius = 30;

    
}


- (IBAction)buttonTapped:(id)sender
{
    
    
}

@end
