 //
//  CalendarMonth.m
//  RealDudesWorkout
//
//  Created by Brian Clouser on 7/3/16.
//  Copyright © 2016 The Qwiz LLC. All rights reserved.
//

#import "CalendarMonth.h"
#import "CalendarDay.h"
#import "DataStore.h"
#import "NSString+BDC_Utility.h"

@interface CalendarMonth ()

@property (strong, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UILabel *monthLabel;
@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *dayLabels;
@property (weak, nonatomic) IBOutlet UIStackView *monthStackView;

@property (strong, nonatomic) NSCalendar *calendar;
@property (strong, nonatomic) NSDateFormatter *formatter;
@property (strong, nonatomic) NSMutableArray *calendarDays;
@property (strong, nonatomic) DataStore *dataStore;
@property (nonatomic) NSInteger year;
@property (nonatomic) NSInteger month;
@property (nonatomic) CGFloat calendarHeight;
@property (nonatomic) CGFloat calendarWidth;
@property (nonatomic) CGFloat verticalSpacing;
@property (nonatomic) CGFloat horizontalSpacing;
@property (nonatomic) CGFloat daySize;


@end

@implementation CalendarMonth

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
    
    [[NSBundle mainBundle] loadNibNamed:@"MonthView" owner:self options:nil];
    
    [self addSubview:self.contentView];
    
    self.contentView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView.leftAnchor constraintEqualToAnchor:self.leftAnchor].active = YES;
    [self.contentView.rightAnchor constraintEqualToAnchor:self.rightAnchor].active = YES;
    [self.contentView.topAnchor constraintEqualToAnchor:self.topAnchor].active = YES;
    [self.contentView.bottomAnchor constraintEqualToAnchor:self.bottomAnchor].active = YES;

    _dataStore = [DataStore sharedDataStore];
    _calendarDays = [[NSMutableArray alloc] init];
    _calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    _formatter = [[NSDateFormatter alloc] init];
    
    [self addDaysToDaysArray];

}

-(void)addDaysToDaysArray
{
    for (UIStackView *stackView in [self.monthStackView arrangedSubviews])
    {
        for (CalendarDay *day in [stackView arrangedSubviews])
        {
            [self.calendarDays addObject:day];
        }
    }
}


-(NSInteger)weekdayOffset;
{
    NSDate *firstDayOfMonth = [self firstDayOfMonthDate];
    NSDateComponents *components = [self.calendar components:NSCalendarUnitWeekday fromDate:firstDayOfMonth];
    return components.weekday == 1 ? 6 : components.weekday - 2;
}

-(NSDate *)firstDayOfMonthDate
{
    NSDate *date = [NSDate date];
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    dateComponents.month = self.monthAdditionToNow;
    
    NSDate *oneMonthAgo = [self.calendar dateByAddingComponents:dateComponents toDate:date options:0];
    NSDateComponents *newComponents = [self.calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:oneMonthAgo];
    newComponents.day = 1;
    NSDate *firstDayOfMonth = [self.calendar dateFromComponents:newComponents];
    
    self.year = newComponents.year;
    self.month = newComponents.month;
    
    return firstDayOfMonth;
}

-(NSInteger)lastDayOfMonthInt
{
    NSDate *startMonth = [self firstDayOfMonthDate];
    NSDateComponents *components = [[NSDateComponents alloc] init];
    components.month = 1;
    components.day = -1;
    
    NSDate *lastDayOfMonthDate = [self.calendar dateByAddingComponents:components toDate:startMonth options:0];
    NSDateComponents *newComponents = [self.calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:lastDayOfMonthDate];
    
    return newComponents.day;
}

-(NSString *)yearFromDate
{
    self.formatter.dateFormat = @"YYYY";
    NSString *year = [self.formatter stringFromDate:[self firstDayOfMonthDate]];
    return year;
}

-(NSString *)monthFromDate
{
    self.formatter.dateFormat = @"MMMM";
    NSString *month = [self.formatter stringFromDate:[self firstDayOfMonthDate]];
    return month;
}

-(void)setMonthAdditionToNow:(NSInteger)monthAdditionToNow
{
    _monthAdditionToNow = monthAdditionToNow;
    
    self.monthLabel.text = [self monthFromDate];
    //self.yearLabel.text = [self yearFromDate];
    
    [self formatCalendarDays];
}

-(void)formatCalendarDays
{
    NSUInteger firstIndex = [self weekdayOffset];
    NSUInteger lastIndex = [self lastDayOfMonthInt] - 1 + firstIndex;
    
    NSUInteger index = 0;
    NSUInteger dayOfMonth = 1;
    
    for (CalendarDay *day in self.calendarDays)
    {
        BOOL isDay = index >= firstIndex && index <= lastIndex;
        
        if (isDay)
        {
            day.representsRealDay = YES;
            day.day = dayOfMonth;
            [self formatDay:day];
            dayOfMonth++;
        }
        else
        {
            day.representsRealDay = NO;
        }
        
        index++;
    }
}


-(void)formatDay:(CalendarDay *)day
{
    NSDateComponents *components = [[NSDateComponents alloc] init];
    components.year = self.year;
    components.month = self.month;
    components.day = day.day;
    components.hour = 0;
    components.minute = 0;
    components.second = 1;
    
    NSDate *calendarDayDate = [self.calendar dateFromComponents:components];
    
    NSDateComponents *todaysComponents = [self.calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:[NSDate date]];
    
    NSString *dateString = [NSString stringWithFormat:@"%lu%lu%lu", components.month, components.day, components.year];
    
    NSDate *downloadDate = [NSDate dateWithTimeIntervalSince1970:self.dataStore.user.downloadDate];
    NSDateComponents *downloadComponents = [self.calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:downloadDate];
    

    BOOL yearMatches = components.year == downloadComponents.year;
    BOOL monthMatches = components.month == downloadComponents.month;
    BOOL isPreDownload = (components.year < downloadComponents.year) || (yearMatches && (components.month < downloadComponents.month)) || (yearMatches && monthMatches && (components.day < downloadComponents.day));
    
    day.isPreDownload = isPreDownload;
    day.isToday = todaysComponents.year == components.year && todaysComponents.month == components.month && todaysComponents.day == components.day;
    day.isFuture  = calendarDayDate.timeIntervalSinceNow > 0 && !day.isToday;
    day.didWorkout = [[self.dataStore.user orderedSetOfWorkoutDates] containsObject:dateString];
    
}

-(NSArray *)workoutsInThisMonth
{
    NSMutableArray *workoutsInThisMonth = [[NSMutableArray alloc] init];
    
    NSDateComponents *newComponents = [self.calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:[self firstDayOfMonthDate]];
    
    for (Workout *workout in [self.dataStore.user orderedWorkoutsLIFO])
    {
        NSDate *workoutDate = [NSDate dateWithTimeIntervalSince1970:workout.date];
        
        NSDateComponents *compareComponents = [self.calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:workoutDate];
        
        if (newComponents.year == compareComponents.year && newComponents.month == compareComponents.month)
        {
            [workoutsInThisMonth addObject:workout];
        }
    }
    
    return workoutsInThisMonth;
}

-(NSString *)numberOfWorkoutsLabel
{
    if ([self workoutsInThisMonth].count ==1)
    {
        return @"1 Workout";
    }
    else
    {
        return [NSString stringWithFormat:@"%lu Workouts", [self workoutsInThisMonth].count];
    }

}

-(NSString *)totalTimeLabel
{
    NSTimeInterval totalTime = 0;
    
    for (Workout *workout in [self workoutsInThisMonth])
    {
        totalTime = totalTime + workout.timeInSeconds;
    }
    
    return [NSString timeInSentenceForm:totalTime includSecondsAlways:NO includeSecondsWhenUnderOneHour:YES abbreviate:YES];

}

-(BOOL)monthIsSquare
{
    return self.monthStackView.frame.size.height >= .85 *self.monthStackView.frame.size.width;
}

@end
