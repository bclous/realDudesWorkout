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
    
    self.backgroundView.backgroundColor = [UIColor clearColor];
    self.blueCircle.layer.cornerRadius = 2.5;
    self.dayLabel.textColor = [UIColor bdc_lightText4];
    self.backgroundView.layer.borderWidth = 0;
    self.smallCircleView.layer.cornerRadius = 18;
     self.blueCircle.alpha = 0;
    self.smallCircleView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:.1];
    self.smallCircleView.alpha = 0;
    
    if (!representsRealDay)
    {
        self.dayLabel.text = @"";
        self.backgroundView.alpha = 0;
        self.smallCircleView.alpha = 0;
       
    }
    else
    {
        self.backgroundView.alpha = 1;
        self.smallCircleView.alpha = 1;
        
    }
}

-(void)setIsFuture:(BOOL)isFuture
{
    _isFuture = isFuture;
    
    if (isFuture)
    {
        self.smallCircleView.alpha = 0;
    }
}

-(void)setIsToday:(BOOL)isToday
{
    _isToday = isToday;
    
    self.smallCircleView.backgroundColor = isToday ? [[UIColor whiteColor] colorWithAlphaComponent:.08] : [UIColor clearColor];

}

-(void)setDidWorkout:(BOOL)didWorkout
{
    _didWorkout = didWorkout;
    
    if (!self.isFuture && !self.isPreDownload)
    {
        self.smallCircleView.backgroundColor = [UIColor clearColor];
        self.blueCircle.alpha = didWorkout ? 1 : 1;
        self.blueCircle.backgroundColor = didWorkout ? [UIColor bdc_blueMainColor] : [[UIColor blackColor] colorWithAlphaComponent:.5];
        self.dayLabel.textColor = [UIColor bdc_lightText1];
    }
}

-(void)setIsPreDownload:(BOOL)isPreDownload
{
    _isPreDownload = isPreDownload;
    
    if (isPreDownload)
    {
        self.smallCircleView.alpha = 0;
    }
}

-(void)resetDay
{
    self.representsRealDay = NO;
    self.isFuture = NO;
    self.isToday = NO;
    self.isPreDownload = NO;
    self.didWorkout = NO;
}


@end
