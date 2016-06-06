//
//  WorkoutTotalsTopCellView.m
//  RealDudesWorkout
//
//  Created by Brian Clouser on 5/25/16.
//  Copyright © 2016 The Qwiz LLC. All rights reserved.
//

#import "WorkoutTotalsTopCellView.h"
#import "WorkoutTotalIndividualView.h"

@interface WorkoutTotalsTopCellView () <UIScrollViewDelegate>

@property (strong, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UIView *circle1;
@property (weak, nonatomic) IBOutlet UIView *circle2;
@property (weak, nonatomic) IBOutlet UIView *circle3;
@property (weak, nonatomic) IBOutlet UIView *circle4;

@property (weak, nonatomic) IBOutlet UIVisualEffectView *blurView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet WorkoutTotalIndividualView *weekView;
@property (weak, nonatomic) IBOutlet WorkoutTotalIndividualView *monthView;
@property (weak, nonatomic) IBOutlet WorkoutTotalIndividualView *yearView;

@property (nonatomic) CGFloat page;

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
    
    self.circle1.layer.cornerRadius =5;
    self.circle2.layer.cornerRadius =5;
    self.circle3.layer.cornerRadius =5;
    self.circle4.layer.cornerRadius =5;
    
    self.blurView.alpha = 0;
    
    self.scrollView.delegate = self;
    
    self.page = 0;
    
    self.weekView.timePeriod = @"week";
    self.monthView.timePeriod = @"month";
    self.yearView.timePeriod = @"year";
    
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSLog(@"scroll view scrolled called with content offset of :%f and view size of: %f", self.scrollView.contentOffset.x
          , self.frame.size.width);
    
    CGFloat widthOfFrame = self.frame.size.width;
    CGFloat offset = self.scrollView.contentOffset.x;
    
    if (offset > 0)
    {
        
        if (offset / widthOfFrame > 1)
        {
            self.blurView.alpha = .6;
        }
        else
        {
            self.blurView.alpha = offset / widthOfFrame * .6;
        }
        
    }
    
    self.page = offset / widthOfFrame;
    
    [self resetLabels];
    
    [self setCircleColorsFromPage:self.page];

    
}

-(void)setCircleColorsFromPage:(CGFloat)page
{
    

    if (page == 0.0)
    {
        [self resetCircleColors];
        self.circle1.backgroundColor = [UIColor colorWithRed:83.0/255.0 green:164.0/255.5 blue:1 alpha:1];

    }
    
    else if (page == 1.0)
    {
         [self resetCircleColors];
        self.circle2.backgroundColor = [UIColor colorWithRed:83.0/255.0 green:164.0/255.5 blue:1 alpha:1];
        
        self.weekView.totalTimeLabel.alpha = 1;
        self.weekView.averageTimeLabel.alpha = 1;
        self.weekView.workoutTotalSmileFaceImageView.alpha = 1;
        
    }
    else if (page == 2.0)
    {
       [self resetCircleColors];
        self.circle3.backgroundColor = [UIColor colorWithRed:83.0/255.0 green:164.0/255.5 blue:1 alpha:1];
        
        self.monthView.totalTimeLabel.alpha = 1;
        self.monthView.averageTimeLabel.alpha = 1;
        self.monthView.workoutTotalSmileFaceImageView.alpha = 1;
       
    }
    else if (page == 3.0)
    {
        [self resetCircleColors];
        self.circle4.backgroundColor = [UIColor colorWithRed:83.0/255.0 green:164.0/255.5 blue:1 alpha:1];
        
        self.yearView.totalTimeLabel.alpha = 1;
        self.yearView.averageTimeLabel.alpha = 1;
        self.yearView.workoutTotalSmileFaceImageView.alpha = 1;
        
    }
    
}

-(void)resetCircleColors
{
    self.circle1.backgroundColor = [UIColor whiteColor];
    self.circle2.backgroundColor = [UIColor whiteColor];
    self.circle3.backgroundColor = [UIColor whiteColor];
    self.circle4.backgroundColor = [UIColor whiteColor];
}

-(void)resetLabels
{
    
    self.weekView.totalTimeLabel.alpha = 0;
    self.weekView.averageTimeLabel.alpha = 0;
    self.weekView.workoutTotalSmileFaceImageView.alpha = 0;
    
    self.monthView.totalTimeLabel.alpha = 0;
    self.monthView.averageTimeLabel.alpha = 0;
    self.monthView.workoutTotalSmileFaceImageView.alpha = 0;
    
    self.yearView.totalTimeLabel.alpha = 0;
    self.yearView.averageTimeLabel.alpha = 0;
    self.yearView.workoutTotalSmileFaceImageView.alpha = 0;
    
}





@end
