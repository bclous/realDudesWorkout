//
//  CalendarDay.m
//  RealDudesWorkout
//
//  Created by Brian Clouser on 7/3/16.
//  Copyright © 2016 The Qwiz LLC. All rights reserved.
//

#import "CalendarDay.h"
#import "UIImage+BDC_Image.h"
#import "UIColor+BDC_Color.h"

@interface CalendarDay ()

@property (strong, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UILabel *dayLabel;
@property (weak, nonatomic) IBOutlet UIImageView *circleImageView;
@property (weak, nonatomic) IBOutlet UIView *backgroundView;
@property (weak, nonatomic) IBOutlet UIView *smallCircleView;

 
@end

@implementation CalendarDay

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
    [[NSBundle mainBundle] loadNibNamed:@"CalendarDay" owner:self options:nil];
    [self addSubview:self.contentView];
    self.contentView.frame = self.bounds;
    self.smallCircleView.layer.cornerRadius = 16;
}

-(void)setDay:(NSUInteger)day
{
    _day = day;
    self.dayLabel.text = [NSString stringWithFormat:@"%lu", day];
}

-(void)setRepresentsRealDay:(BOOL)representsRealDay
{
    _representsRealDay = representsRealDay;
    
    self.backgroundView.alpha = 0;
    self.dayLabel.textColor = [UIColor bdc_lightText4];
    self.smallCircleView.layer.cornerRadius = 13;
    self.smallCircleView.alpha = .35;
    self.smallCircleView.backgroundColor = [UIColor clearColor];
    self.smallCircleView.layer.borderColor = [[UIColor clearColor] CGColor];
    self.smallCircleView.layer.borderWidth = 1;
    
    if (!representsRealDay)
    {
        self.dayLabel.text = @"";
    }
}

-(void)setIsFuture:(BOOL)isFuture
{
    _isFuture = isFuture;
}

-(void)setIsToday:(BOOL)isToday
{
    _isToday = isToday;

    self.smallCircleView.layer.borderColor = isToday ? [[UIColor bdc_blueMainColor] CGColor] : [[UIColor clearColor] CGColor];
}

-(void)setDidWorkout:(BOOL)didWorkout
{
    _didWorkout = didWorkout;
    
    self.smallCircleView.backgroundColor = didWorkout ? [UIColor bdc_blueMainColor] : [UIColor clearColor];
    self.dayLabel.textColor = didWorkout ? [UIColor bdc_lightText1] : [UIColor bdc_lightText4];
}

-(void)setIsPreDownload:(BOOL)isPreDownload
{
    _isPreDownload = isPreDownload;
    
}

-(void)resetDay
{
    self.isFuture = NO;
    self.isToday = NO;
    self.isPreDownload = NO;
    self.didWorkout = NO;
    self.representsRealDay = NO;
}


@end
