//
//  WorkoutTotalsTopCellView.m
//  RealDudesWorkout
//
//  Created by Brian Clouser on 5/25/16.
//  Copyright © 2016 The Qwiz LLC. All rights reserved.
//

#import "WorkoutTotalsTopCellView.h"
#import "WorkoutTotalIndividualView.h"
#import "WeeklyWorkoutTotalsView.h"
#import "MonthlyWorkoutCalendarTopCellView.h"

@interface WorkoutTotalsTopCellView () <UIScrollViewDelegate>

@property (strong, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UIView *circle1;
@property (weak, nonatomic) IBOutlet UIView *circle2;
@property (weak, nonatomic) IBOutlet UIView *circle3;
@property (weak, nonatomic) IBOutlet UIView *circle4;

@property (weak, nonatomic) IBOutlet UIVisualEffectView *blurView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (weak, nonatomic) IBOutlet MonthlyWorkoutCalendarTopCellView *firstMonthView;
@property (weak, nonatomic) IBOutlet MonthlyWorkoutCalendarTopCellView *lastMonthView;
@property (weak, nonatomic) IBOutlet WeeklyWorkoutTotalsView *last12MonthsView;

@property (nonatomic) BOOL onPage1;
@property (nonatomic) BOOL onPage2;
@property (nonatomic) BOOL onPage3;
@property (nonatomic) BOOL onPage4;

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
    
    self.circle1.layer.cornerRadius =4;
    self.circle2.layer.cornerRadius =4;
    self.circle3.layer.cornerRadius =4;
    self.circle4.layer.cornerRadius =4;
    
    self.blurView.alpha = 0;
    
    self.scrollView.delegate = self;
    
    self.page = 0;
    self.firstMonthView.monthOffset = 0;
    self.lastMonthView.monthOffset = -1;
    
    _onPage1 = YES;
    _onPage2 = NO;
    _onPage3 = NO;
    _onPage4 = NO;
    
    [self.firstMonthView transitionToScrollingView];
    [self.lastMonthView transitionToScrollingView];
    [self.last12MonthsView transitionToScrollingView];
}

-(void)updateDataAndScrollToPage:(NSInteger)page
{
    self.firstMonthView.monthOffset = 0;
    self.lastMonthView.monthOffset = -1;
    [self.last12MonthsView formatView];
    
    //scroll to page logic here?
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (self.onPage2)
    {
        [self.firstMonthView transitionToScrollingView];
    }
    else if (self.onPage3)
    {
        [self.lastMonthView transitionToScrollingView];
    }
    else if (self.onPage4)
    {
        [self.last12MonthsView transitionToScrollingView];
    }
    
    [self turnOnPageBoolsOff];
    
    CGFloat widthOfFrame = self.frame.size.width;
    CGFloat offset = self.scrollView.contentOffset.x;
    
    if (offset > 0)
    {
        if (offset / widthOfFrame > 1)
        {
            self.blurView.alpha = 1;
        }
        else
        {
            self.blurView.alpha = offset / widthOfFrame * 1;
        }
    }
    
    self.page = offset / widthOfFrame;
    
    [self setCircleColorsFromPage:self.page];
}

-(void)setCircleColorsFromPage:(CGFloat)page
{
    BOOL onLandingPage = page == 0.0 || page == 1.0 || page == 2.0 || page == 3.0;
    
    if (!onLandingPage)
    {
        return;
    }
    
    [self resetCircleColors];
    [self updateBoolsForPage:page];
    [self updateCircleColors];

    if (page == 1.0)
    {
        [self.firstMonthView transitionToStaticView];
    }
    else if (page == 2.0)
    {
        [self.lastMonthView transitionToStaticView];
    }
    else if (page == 3.0)
    {
        [self.last12MonthsView transitionToStaticView];
    }
}

-(void)resetCircleColors
{
    self.circle1.backgroundColor = [UIColor whiteColor];
    self.circle2.backgroundColor = [UIColor whiteColor];
    self.circle3.backgroundColor = [UIColor whiteColor];
    self.circle4.backgroundColor = [UIColor whiteColor];
}

-(void)turnOnPageBoolsOff
{
    self.onPage1 = NO;
    self.onPage2 = NO;
    self.onPage3 = NO;
    self.onPage4 = NO;
}

-(void)updateBoolsForPage:(CGFloat)page
{
    self.onPage1 = page == 0.0 ? YES : NO;
    self.onPage2 = page == 1.0 ? YES : NO;
    self.onPage3 = page == 2.0 ? YES : NO;
    self.onPage4 = page == 3.0 ? YES : NO;
}

-(void)updateCircleColors
{
    self.circle1.backgroundColor = self.onPage1 ? [UIColor colorWithRed:83.0/255.0 green:164.0/255.5 blue:1 alpha:1] : [UIColor whiteColor];
    self.circle2.backgroundColor = self.onPage2 ? [UIColor colorWithRed:83.0/255.0 green:164.0/255.5 blue:1 alpha:1] : [UIColor whiteColor];
    self.circle3.backgroundColor = self.onPage3 ? [UIColor colorWithRed:83.0/255.0 green:164.0/255.5 blue:1 alpha:1] : [UIColor whiteColor];
    self.circle4.backgroundColor = self.onPage4 ? [UIColor colorWithRed:83.0/255.0 green:164.0/255.5 blue:1 alpha:1] : [UIColor whiteColor];
}

@end
