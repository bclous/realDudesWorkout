//
//  StartButtonView.m
//  RealDudesWorkout
//
//  Created by Brian Clouser on 7/16/16.
//  Copyright © 2016 The Qwiz LLC. All rights reserved.
//

#import "StartButtonView.h"
#import "UIColor+BDC_Color.h"

@interface StartButtonView ()
@property (strong, nonatomic) IBOutlet UIView *contentView;



@end

@implementation StartButtonView

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
    [[NSBundle mainBundle] loadNibNamed:@"StartButtonView" owner:self options:nil];
    [self addSubview:self.contentView];
    self.contentView.frame = self.bounds;
    
    self.outLineView.layer.cornerRadius = 20;
    
//    self.outLineView.layer.masksToBounds = NO;
//    self.outLineView.layer.shadowOffset = CGSizeMake(1, 1);
//    self.outLineView.layer.shadowRadius = 5;
//    self.outLineView.layer.shadowOpacity = 0.35;
    
}
- (IBAction)buttonTapped:(id)sender
{
    [self.delegate startButtonTapped];
}

@end
