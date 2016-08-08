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
@property (weak, nonatomic) IBOutlet UIStackView *monthStackView;

@property (strong, nonatomic) NSCalendar *calendar;
@property (strong, nonatomic) NSDateFormatter *formatter;
@property (strong, nonatomic) NSMutableArray *calendarDays;
@property (strong, nonatomic) NSDateComponents *dayComponents;
@property (strong, nonatomic) NSDateComponents *todaysComponents;
@property (strong, nonatomic) NSDateComponents *downloadComponents;
@property (strong, nonatomic) NSOrderedSet *workoutDates;
@property (strong, nonatomic) DataStore *dataStore;
@property (strong, nonatomic) NSDate *downloadDate;
@property (nonatomic) NSInteger year;
@property (nonatomic) NSInteger month;
@property (nonatomic) CGFloat calendarHeight;
@property (nonatomic) CGFloat calendarWidth;
@property (nonatomic) CGFloat verticalSpacing;
@property (nonatomic) CGFloat horizontalSpacing;
@property (nonatomic) CGFloat daySize;
@property (nonatomic) NSUInteger firstNonDayIndex;
@property (nonatomic) NSUInteger weeksToShowForView;


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
    [self.dataStore fetchData];
    _calendarDays = [[NSMutableArray alloc] init];
    _calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    _formatter = [[NSDateFormatter alloc] init];
    _dayComponents = [[NSDateComponents alloc] init];
    _todaysComponents = [self.calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:[NSDate date]];
    _downloadDate = [NSDate dateWithTimeIntervalSince1970:self.dataStore.user.downloadDate];
    _downloadComponents = [self.calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:self.downloadDate];
    _workoutDates = [self.dataStore.user orderedSetOfWorkoutDates];
    
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
    self.dayComponents.month = self.month;
    self.dayComponents.year = self.year;
    self.dayComponents.hour = 0;
    self.dayComponents.minute = 0;
    self.dayComponents.second = 1;
    
    
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
    
    //self.monthLabel.text = [[self monthFromDate] uppercaseString];
    //self.yearLabel.text = [self yearFromDate];
    
    [self formatCalendarDays];
}

-(void)formatCalendarDays
{
    self.firstNonDayIndex = 0;
    BOOL foundFirstDay = NO;
    NSUInteger firstIndex = [self weekdayOffset];
    NSUInteger lastIndex = [self lastDayOfMonthInt] - 1 + firstIndex;
    
    NSUInteger index = 0;
    NSUInteger dayOfMonth = 1;
    
    for (CalendarDay *day in self.calendarDays)
    {
        BOOL isDay = index >= firstIndex && index <= lastIndex;
        
        if (isDay)
        {
            foundFirstDay = YES;
            [day resetDay];
            day.representsRealDay = YES;
            day.day = dayOfMonth;
            [self formatDay:day];
            dayOfMonth++;
        }
        else
        {
            if (self.firstNonDayIndex == 0 && foundFirstDay)
            {
                self.firstNonDayIndex = index;
                self.weeksToShowForView = ((index - 1) / 7) + 1;
            }
            day.representsRealDay = NO;
        }
        
        index++;
        
    }
}

-(NSUInteger)weeksToShow
{
    return self.weeksToShowForView;
}


-(void)formatDay:(CalendarDay *)day
{
    self.dayComponents.day = day.day;
    
    NSDate *calendarDayDate = [self.calendar dateFromComponents:self.dayComponents];
   
    NSString *dateString = [NSString stringWithFormat:@"%lu%lu%lu", self.dayComponents.month, self.dayComponents.day, self.dayComponents.year];
    
    BOOL yearMatches = self.dayComponents.year == self.downloadComponents.year;
    BOOL monthMatches = self.dayComponents.month == self.downloadComponents.month;
    BOOL isPreDownload = (self.dayComponents.year < self.downloadComponents.year) || (yearMatches && (self.dayComponents.month < self.downloadComponents.month)) || (yearMatches && monthMatches && (self.dayComponents.day < self.downloadComponents.day));
    
    if (isPreDownload)
    {
        day.isPreDownload = YES;
        return;
    }
    else if(calendarDayDate.timeIntervalSinceNow > 0 && !day.isToday)
    {
        day.isFuture = YES;
        return;
    }
    else {
        day.didWorkout = [self.workoutDates containsObject:dateString];
        day.isToday = self.todaysComponents.year == self.dayComponents.year && self.todaysComponents.month == self.dayComponents.month && self.todaysComponents.day == self.dayComponents.day;
    }
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
