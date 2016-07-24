//
//  LogoView.m
//  RealDudesWorkout
//
//  Created by Brian Clouser on 7/24/16.
//  Copyright © 2016 The Qwiz LLC. All rights reserved.
//

#import "LogoView.h"

#define BLUE_COLOR [UIColor colorWithRed: green:83.0/255.0 blue:163.0/255.0 alpha:1]
#define GRAY_COLOR [UIColor colorWithRed: green:239.0/255.0 blue:239.0/255.0 alpha:244.0/255.0]

@interface LogoView ()

@property (strong, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UIView *centerView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *centerViewHeightConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *stackViewTopConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *stackViewCenterYConstraint;
@property (weak, nonatomic) IBOutlet UIStackView *masterStackView;
@property (weak, nonatomic) IBOutlet UIStackView *stackView1;
@property (weak, nonatomic) IBOutlet UIStackView *stackView2;
@property (weak, nonatomic) IBOutlet UIStackView *stackView3;
@property (weak, nonatomic) IBOutlet UIStackView *stackView4;
@property (weak, nonatomic) IBOutlet UIStackView *stackView5;

@end

@implementation LogoView

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
    [[NSBundle mainBundle] loadNibNamed:@"LogoView" owner:self options:nil];
    [self addSubview:self.contentView];
    self.contentView.frame = self.bounds;
}





@end
