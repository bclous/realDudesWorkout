//
//  MonthScrollView.m
//  RealDudesWorkout
//
//  Created by Brian Clouser on 8/3/16.
//  Copyright © 2016 The Qwiz LLC. All rights reserved.
//

#import "MonthScrollView.h"
#import "NSString+BDC_Utility.h"
#import "UIColor+BDC_Color.h"
#import "UIImage+BDC_Image.h"

@interface MonthScrollView () <UIScrollViewDelegate>

@property (strong, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UIStackView *monthNameStackView;
@property (weak, nonatomic) IBOutlet UIImageView *triangleImage;
@property (strong, nonatomic) NSCalendar *calendar;
@property (strong, nonatomic) NSDateComponents *components;
@property (weak, nonatomic) IBOutlet UIView *panView;
@property (nonatomic) NSUInteger currentIndex;
@property (weak, nonatomic) IBOutlet UIButton *fowardButton;
@property (weak, nonatomic) IBOutlet UIButton *backButton;


@end

@implementation MonthScrollView

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
    [[NSBundle mainBundle] loadNibNamed:@"MonthScrollView" owner:self options:nil];
    [self addSubview:self.contentView];
    self.contentView.frame = self.bounds;
    
    _calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    _components = [self.calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:[NSDate date]];
    
    [self generateMonthLabels];
    [self.panView addGestureRecognizer:self.monthScrollView.panGestureRecognizer];
    self.triangleImage.image = [self.triangleImage.image bdc_tintImageWithColor:[UIColor bdc_offblackbackgroundColor]];
    self.monthScrollView.delegate = self;
    
     NSLog(@"%f width", self.monthScrollView.frame.size.width);
    
}

#pragma mark format View

-(void)generateMonthLabels
{
    NSInteger i = -12;
    for (UILabel *label in [self.monthNameStackView arrangedSubviews])
    {
        
        if (i == -12)
        {
            label.text = @"";
        }
        else if (i == 1)
        {
            label.text = @"Last 12 Mths";
        }
        else
        {
            self.components.month = i;
            NSDate *date = [self.calendar dateByAddingComponents:self.components toDate:[NSDate date] options:0];
            label.text = [NSString monthNameFromDate:date];
        }
        
        label.textColor = [UIColor darkGrayColor];
        i++;
    }
}

-(void)setScrollViewWidth:(CGFloat)scrollViewWidth
{
    _scrollViewWidth = scrollViewWidth;
    
    [self moveScrollViewToIndex:12 animate:NO];
}

#pragma scrollView methods

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGPoint last;
    last.x = self.scrollViewWidth * 12;
    last.y = 0;
    
    if (self.currentIndex == 13)
    {
        if (scrollView.contentOffset.x > last.x)
        {
            [self.monthScrollView setContentOffset:last animated:NO];
        }
    }
   
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSUInteger chosenMonth = scrollView.contentOffset.x / self.scrollViewWidth + 1;
    
    [self moveScrollViewToIndex:chosenMonth animate:NO];
}


#pragma mark ib actions

- (IBAction)forwardOrBackTapped:(id)sender {
    
    NSInteger adjustment = ((UIButton *)sender).tag == 0 ? -1 : 1;
    
    if (self.currentIndex == 0 && adjustment == -1)
    {
        adjustment = 0;
    }
    else if (self.currentIndex == [self.monthNameStackView arrangedSubviews].count - 1 && adjustment == 1)
    {
        adjustment = 0;
    }
    
    if(adjustment !=0)
    {
        [self moveScrollViewToIndex:self.currentIndex + adjustment animate:YES];
    }
}

-(void)moveScrollViewToIndex:(NSUInteger)index animate:(BOOL)animate
{
    CGPoint indexPoint;
    indexPoint.y = 0;
    indexPoint.x = self.scrollViewWidth * (index -1);
    [self.monthScrollView setContentOffset:indexPoint animated:animate];
    [self adjustFontColorsForIndex:index];
    
    if (index != self.currentIndex)
    {
        self.currentIndex = index;
        [self.delegate newIndexChosen:index];
    }
}

-(void)adjustFontColorsForIndex:(NSInteger)index
{
    if (index == self.currentIndex)
    {
        return;
    }
    else
    {
        UILabel *oldCurrentMonthLabel = [self.monthNameStackView arrangedSubviews][self.currentIndex];
        UILabel *newCurrentMonthLabel = [self.monthNameStackView arrangedSubviews][index];
        oldCurrentMonthLabel.textColor = [UIColor darkGrayColor];
        newCurrentMonthLabel.textColor = [UIColor whiteColor];
    }
}


@end
