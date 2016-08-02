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
}

-(void)setDay:(NSUInteger)day
{
    _day = day;
    self.dayLabel.text = [NSString stringWithFormat:@"%lu", day];
}

-(void)setRepresentsRealDay:(BOOL)representsRealDay
{
    _representsRealDay = representsRealDay;
    
    if (!representsRealDay)
    {
        self.dayLabel.text = @"";
        self.circleImageView.alpha = 0;
        self.backgroundView.alpha = 0;
    }
}

-(void)setIsFuture:(BOOL)isFuture
{
    _isFuture = isFuture;
    
    if (isFuture)
    {
        self.circleImageView.alpha = 0;
        self.backgroundView.alpha = 0;
        self.circleImageView.image = [self.circleImageView.image bdc_tintImageWithColor:[UIColor grayColor]];
    }
}

-(void)setIsToday:(BOOL)isToday
{
    _isToday = isToday;
    
    if (isToday)
    {
        self.backgroundView.alpha = 0;
        self.circleImageView.alpha = 0;
    }
}

-(void)setDidWorkout:(BOOL)didWorkout
{
    _didWorkout = didWorkout;
    
    if (!self.isFuture && !self.isPreDownload)
    {
        self.backgroundView.alpha = 1;
        self.circleImageView.alpha = 0;
        self.dayLabel.textColor = didWorkout ? [UIColor bdc_greenColor] : [UIColor bdc_redColor];
        self.backgroundView.layer.borderWidth = 2;
        self.backgroundView.layer.borderColor = didWorkout ? [[UIColor bdc_greenColor] CGColor] : [[UIColor bdc_redColor] CGColor];
        self.circleImageView.image = didWorkout ? [self.circleImageView.image bdc_tintImageWithColor:[UIColor bdc_greenColor]] : [self.circleImageView.image bdc_tintImageWithColor:[UIColor bdc_redColor]];
        self.backgroundView.backgroundColor = [UIColor clearColor];
    }
}

-(void)setIsPreDownload:(BOOL)isPreDownload
{
    _isPreDownload = isPreDownload;
    
    if (isPreDownload)
    {
        self.backgroundView.alpha = 0;
        self.circleImageView.alpha = 0;
    }
}


@end
