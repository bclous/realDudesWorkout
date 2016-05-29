//
//  ExcerciseTotalView.m
//  RealDudesWorkout
//
//  Created by Brian Clouser on 5/16/16.
//  Copyright © 2016 The Qwiz LLC. All rights reserved.
//

#import "ExcerciseTotalView.h"


@interface ExcerciseTotalView ()

@property (strong, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UIImageView *excerciseImage;
@property (weak, nonatomic) IBOutlet UILabel *excerciseNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *excerciseTimeLabel;

@end

@implementation ExcerciseTotalView

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
    
    
    [[NSBundle mainBundle] loadNibNamed:@"ExcerciseTotal" owner:self options:nil];
    
    [self addSubview:self.contentView];
    
    self.contentView.frame = self.bounds;
    
  
    
}

-(void)setExcerciseSet:(ExcerciseSet *)excerciseSet
{
    
    _excerciseSet = excerciseSet;
    
    self.excerciseImage.image = [UIImage imageNamed:self.excerciseSet.excercise.pictureName];
    
    self.excerciseNameLabel.text = [NSString stringWithFormat:@"%lld %@",self.excerciseSet.numberofRepsActual, self.excerciseSet.excercise.name];
    self.excerciseTimeLabel.text = [self generateTimeStringGivenTime:excerciseSet.timeInSecondsActual];
    
}

-(NSString *)generateTimeStringGivenTime:(NSTimeInterval)time
{
    
    NSInteger hours = time/3600;
    NSInteger minutes = (((NSInteger)time)%3600)/60;
    NSInteger seconds = (((NSInteger)time)%3600)%60;
    
    BOOL hasHours = hours > 0;
    BOOL hasMinutes = minutes > 0;
    
    
    if (!hasHours && !hasMinutes)
    {
        NSString *stringNoMinutesOrHours = [NSString stringWithFormat:@"0:%@",[self timeStringFromTime:seconds]];
        
        return stringNoMinutesOrHours;
    }
    
    else if (!hasHours)
    {
        NSString *stringNoHours = [NSString stringWithFormat:@"%@:%@",[self timeStringFromTime:minutes],[self timeStringFromTime:seconds]];
        
        return stringNoHours;
    }
    
    else if (hasHours)
    {
        NSString *stringWithHours = [NSString stringWithFormat:@"%@:%@:%@",[self timeStringFromTime:hours],[self timeStringFromTime:minutes],[self timeStringFromTime:seconds]];
        
        return stringWithHours;
    }
    else
    {
        return @"0:00";
    }
    
    
    
}

-(NSString *)timeStringFromTime:(NSInteger)time
{
    BOOL singleDigit = time < 10;
    
    if (singleDigit)
    {
        NSString *timeString = [NSString stringWithFormat:@"0%li",time];
        
        return timeString;
        
    }
    else
    {
        NSString *timeString = [NSString stringWithFormat:@"%li",time];
        
        return timeString;
    }
}

@end
