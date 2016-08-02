//
//  LogoView.m
//  RealDudesWorkout
//
//  Created by Brian Clouser on 7/24/16.
//  Copyright © 2016 The Qwiz LLC. All rights reserved.
//

#import "LogoView.h"

#define BLUE_COLOR [UIColor colorWithRed:83.0/255.0 green:163.0/255.0 blue:1 alpha:1]
#define BLUE_COLOR2 [UIColor colorWithRed:84.0/255.0 green:163.0/255.0 blue:1 alpha:1]
#define GRAY_COLOR [UIColor colorWithRed:239.0/255.0 green:239.0/255.0 blue:244.0/255.0 alpha:1]
#define GRAY_COLOR2 [UIColor colorWithRed:240.0/255.0 green:239.0/255.0 blue:244.0/255.0 alpha:1]

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
@property (strong, nonatomic) NSArray *stackViewArray;
@property (weak, nonatomic) IBOutlet UILabel *generatingWorkoutLabel;
@property (strong, nonatomic) IBOutletCollection(UIView) NSArray *blueViews;
@property (strong, nonatomic) IBOutletCollection(UIView) NSArray *grayViews;
@property (strong, nonatomic) NSMutableArray *blueViewsArray;
@property (strong, nonatomic) NSMutableArray *grayViewsArray;

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
    
    self.stackViewArray = @[self.stackView1, self.stackView2, self.stackView3, self.stackView4, self.stackView5];
    self.generatingWorkoutLabel.alpha = 0;
    
    [self createArrays];
    [self shuffleArrays];

}

-(void)createArrays
{
    _blueViewsArray = [NSMutableArray new];
    _grayViewsArray = [NSMutableArray new];
    
    
    NSUInteger index = 1;
    for (UIView *view in self.blueViews)
    {
        [self.blueViewsArray addObject:view];
        
        index++;
    }
    
    for (UIView *view in self.grayViews)
    {
        [self.grayViewsArray addObject:view];
    }
}

-(void)shuffleArrays
{
    for (NSUInteger i = self.blueViewsArray.count; i > 1; i--)
    {
        [self.blueViewsArray exchangeObjectAtIndex:i-1 withObjectAtIndex:arc4random_uniform((u_int32_t)i)];
    }
    for (NSUInteger i = self.grayViewsArray.count; i > 1; i--)
    {
        [self.grayViewsArray exchangeObjectAtIndex:i-1 withObjectAtIndex:arc4random_uniform((u_int32_t)i)];
    }
}

-(void)moveAndResizeLogoToMiddle:(BOOL)toMiddle
{
    self.centerViewHeightConstraint.active = NO;
    self.stackViewTopConstraint.active = NO;
    self.stackViewCenterYConstraint.active = NO;
    self.centerViewHeightConstraint = toMiddle ? [self.centerView.heightAnchor constraintEqualToAnchor:self.widthAnchor multiplier:.1] : [self.centerView.heightAnchor constraintEqualToConstant:6];
    self.centerViewHeightConstraint.active = YES;
    self.stackViewTopConstraint.active = !toMiddle;
    self.stackViewCenterYConstraint.active = toMiddle;

    [self layoutIfNeeded];
}

-(void)updateLabelShow:(BOOL)show
{
    self.generatingWorkoutLabel.alpha = show;
}

-(void)revertToHomeColors
{
    for (UIView *view in self.blueViews)
    {
       view.backgroundColor = BLUE_COLOR;
    }
    
    for (UIView *view in self.grayViews)
    {
        view.backgroundColor = GRAY_COLOR;
    }
}

-(UIColor *)otherColor:(NSString *)color forView:(UIView *)view
{
    if ([color isEqualToString:@"blue"])
    {
        return [view.backgroundColor isEqual:BLUE_COLOR] ? BLUE_COLOR2 : BLUE_COLOR;
    }
    else
    {
        return [view.backgroundColor isEqual:GRAY_COLOR] ? GRAY_COLOR2 : GRAY_COLOR;
    }
}

-(void)convertViewToRandomColor:(UIView *)view
{
    int random = arc4random_uniform(101);
    BOOL even = random % 2 == 0;
    
    view.backgroundColor = even ? [self otherColor:@"blue" forView:view] : [self otherColor:@"gray" forView:view];

}

-(void)adjustlogoColorsPercentComplete:(CGFloat)complete
{
    CGFloat blueIndex = 0;
    CGFloat grayIndex = 0;
    
    for (UIView *view in self.blueViewsArray)
    {
        CGFloat percent = (blueIndex +1.0) / 16.0;
        NSLog(@"blue percent: %.2f complete: %.2f random: %d", percent, complete, complete < percent);
        
       if (complete >= percent)
       {
           view.backgroundColor = [self otherColor:@"blue" forView:view];
        }
        else
        {
            [self convertViewToRandomColor:view];
        }
        
        blueIndex = blueIndex + 1;
    }
    
    for (UIView *view in self.grayViewsArray)
    {
        CGFloat percent = (grayIndex + 1.0) / 9.0;
         NSLog(@"gray percent: %.2f complete: %.2f random: %d", percent, complete, complete < percent);
        
        if (complete >= percent)
        {
             view.backgroundColor = [self otherColor:@"gray" forView:view];

        }
        else
        {
            [self convertViewToRandomColor:view];
        }
  
        grayIndex = grayIndex + 1;
    }
}

-(void)performGenerateWorkoutAnimation
{
    
    [UIView animateWithDuration:.5 delay:.5 options:UIViewAnimationOptionCurveEaseIn  animations:^{
        
        [self moveAndResizeLogoToMiddle:YES];
        
    } completion:^(BOOL finished) {
        
        [self updateLabelShow:YES];
        
        CGFloat duration = 4.0;
        CGFloat animations = 50;
        CGFloat durationOfEachAnimation = duration / animations;
        
        [UIView animateKeyframesWithDuration:duration delay:.5 options:UIViewKeyframeAnimationOptionCalculationModeLinear animations:^{
            
            for (CGFloat animationKeyFrameIndex = 0; animationKeyFrameIndex < animations; animationKeyFrameIndex++)
            {
                [UIView addKeyframeWithRelativeStartTime:(animationKeyFrameIndex * durationOfEachAnimation)/duration relativeDuration:durationOfEachAnimation/duration animations:^{
                    NSLog(@"\nstart time: %.2f, duration: %.2f", animationKeyFrameIndex * durationOfEachAnimation, durationOfEachAnimation);
                    [self adjustlogoColorsPercentComplete:(animationKeyFrameIndex + 1.0)  /  animations];
                }];
            }

        } completion:^(BOOL finished) {
            
           //[self revertToHomeColors];
            
            [UIView animateWithDuration:.2 animations:^{
                self.generatingWorkoutLabel.text = @"";
            } completion:^(BOOL finished) {
                
                
                [UIView animateWithDuration:.5 delay:1 options:UIViewAnimationOptionCurveEaseOut animations:^{
                    [self moveAndResizeLogoToMiddle:NO];
                    [self updateLabelShow:NO];
                } completion:^(BOOL finished) {
                    
                    [self shuffleArrays];
                    self.generatingWorkoutLabel.text = @"Generating workout...";
                    [self.delegate animationComplete];
                    
                }];

            }];
        }];
    }];
}



@end
