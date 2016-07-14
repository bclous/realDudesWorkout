//
//  CalendarDay.m
//  RealDudesWorkout
//
//  Created by Brian Clouser on 7/3/16.
//  Copyright © 2016 The Qwiz LLC. All rights reserved.
//

#import "CalendarDay.h"

@interface CalendarDay ()

@property (strong, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UILabel *dayLabel;
@property (weak, nonatomic) IBOutlet UIView *circleView;

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

-(void)roundCornersWithWidth:(CGFloat)width
{
    self.circleView.layer.cornerRadius = width / 2;
}

-(void)setRepresentsRealDay:(BOOL)representsRealDay
{
    _representsRealDay = representsRealDay;
    
    if (!representsRealDay)
    {
        self.circleView.backgroundColor = [UIColor clearColor];
        self.dayLabel.text = @"";
    }
}

-(void)setIsFuture:(BOOL)isFuture
{
    _isFuture = isFuture;
    
    if (isFuture)
    {
        self.circleView.backgroundColor = [UIColor clearColor];
    }
}

-(void)setIsToday:(BOOL)isToday
{
    _isToday = isToday;
    
    if (isToday)
    {
        self.circleView.layer.cornerRadius = 0;
    }
}

-(void)setDidWorkout:(BOOL)didWorkout
{
    _didWorkout = didWorkout;
    
    if (!self.isFuture && !self.isPreDownload)
    {
        self.circleView.backgroundColor = didWorkout ? [UIColor colorWithRed:60.0/255.0 green:196.0/255.0 blue:94.0/255.0 alpha:1] : [UIColor redColor];
    }
}

-(void)setIsPreDownload:(BOOL)isPreDownload
{
    _isPreDownload = isPreDownload;
    
    if (isPreDownload)
    {

        self.circleView.backgroundColor = [UIColor clearColor];

    }
}


@end
