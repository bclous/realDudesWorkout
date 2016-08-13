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
    self.dayLabel.textColor = [UIColor bdc_lightText2];
    self.backgroundView.layer.borderWidth = 0;
    self.smallCircleView.alpha = 0;
    self.smallCircleView.layer.cornerRadius = 16;
    self.smallCircleView.layer.borderWidth = 1;
    
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
        self.dayLabel.textColor = [UIColor bdc_lightText2];
//        self.backgroundView.layer.borderColor = [[[UIColor lightGrayColor] colorWithAlphaComponent:.3] CGColor];
//        self.backgroundView.layer.borderWidth = 1;
    }
}

-(void)setIsToday:(BOOL)isToday
{
    _isToday = isToday;
    
    if (isToday)
    {
//        self.backgroundView.layer.borderWidth = 1;
//        self.backgroundView.layer.borderColor = [[UIColor lightGrayColor] CGColor];
        self.smallCircleView.layer.cornerRadius = 0;
        
    }
}

-(void)setDidWorkout:(BOOL)didWorkout
{
    _didWorkout = didWorkout;
    
    if (!self.isFuture && !self.isPreDownload)
    {
        self.smallCircleView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:.2];
        self.dayLabel.textColor = didWorkout ? [UIColor bdc_greenColor] : [UIColor bdc_redColor];
        self.smallCircleView.alpha = 1;
        
        self.smallCircleView.layer.borderColor = didWorkout ? [[[UIColor bdc_greenColor] colorWithAlphaComponent:.5] CGColor] : [[[UIColor bdc_redColor] colorWithAlphaComponent:.5] CGColor];
    
    }
}

-(void)setIsPreDownload:(BOOL)isPreDownload
{
    _isPreDownload = isPreDownload;
    
    if (isPreDownload)
    {
        
        self.smallCircleView.alpha = 0;
//        //self.backgroundView.alpha = 0;
//        self.dayLabel.textColor = [UIColor bdc_lightText1];
//        self.backgroundView.layer.borderColor = [[UIColor clearColor] CGColor];
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
