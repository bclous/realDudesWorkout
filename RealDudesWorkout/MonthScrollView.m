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

@interface MonthScrollView ()

@property (strong, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UIStackView *monthNameStackView;
@property (weak, nonatomic) IBOutlet UIImageView *triangleImage;
@property (strong, nonatomic) NSCalendar *calendar;
@property (strong, nonatomic) NSDateComponents *components;
@property (weak, nonatomic) IBOutlet UIView *panView;
@property (weak, nonatomic) IBOutlet UIScrollView *monthScrollView;


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
    self.triangleImage.image = [self.triangleImage.image bdc_tintImageWithColor:[UIColor darkGrayColor]];
    
}

-(void)layoutWithWidth:(CGFloat)width
{
    CGFloat totalSize = width * 4.33;
    CGFloat pageSize = width / 3;
    
}

-(void)generateMonthLabels
{
    
    NSInteger i = -11;
    for (UILabel *label in [self.monthNameStackView arrangedSubviews])
    {
        if (i == 1)
        {
            label.text = @"Last 12 Mths";
        }
        else
        {
            self.components.month = i;
            NSDate *date = [self.calendar dateByAddingComponents:self.components toDate:[NSDate date] options:0];
            label.text = [NSString monthNameFromDate:date];
        }
        
        i++;
            
    }
}


@end
