//
//  SkipExerciseView.m
//  RealDudesWorkout
//
//  Created by Brian Clouser on 7/22/16.
//  Copyright © 2016 The Qwiz LLC. All rights reserved.
//

#import "SkipExerciseView.h"

@interface SkipExerciseView ()

@property (strong, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UIButton *button1;
@property (weak, nonatomic) IBOutlet UIButton *button2;
@property (weak, nonatomic) IBOutlet UIButton *button3;
@property (weak, nonatomic) IBOutlet UIButton *button4;

@end

@implementation SkipExerciseView

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
    
    [[NSBundle mainBundle] loadNibNamed:@"SkipExercise" owner:self options:nil];
    
    [self addSubview:self.contentView];
    
    self.contentView.frame = self.bounds;
    
    self.button1.layer.cornerRadius = 3;
    self.button2.layer.cornerRadius = 3;
    self.button3.layer.cornerRadius = 3;
    self.button4.layer.cornerRadius = 3;
    
}

- (IBAction)buttonTapped:(id)sender
{
    [self.delegate buttonTapped:((UIButton *)sender).tag];
}


@end
