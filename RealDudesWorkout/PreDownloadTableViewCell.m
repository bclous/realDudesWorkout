//
//  PreDownloadTableViewCell.m
//  RealDudesWorkout
//
//  Created by Brian Clouser on 8/15/16.
//  Copyright © 2016 The Qwiz LLC. All rights reserved.
//

#import "PreDownloadTableViewCell.h"
#import "DataStore.h"

@interface PreDownloadTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *noWorkoutsLabel;
@property (nonatomic) BOOL isPreDownload;
@property (nonatomic) BOOL isCurrentMonth;

@end

@implementation PreDownloadTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)configureCell
{
    if(self.isPreDownload)
    {
        self.noWorkoutsLabel.text = @"Pre Download";
    }
    else
    {
        self.noWorkoutsLabel.text = @"Current Month";
    }

}

-(void)setMonthAdditionToNow:(NSInteger)monthAdditionToNow
{
    _monthAdditionToNow = monthAdditionToNow;
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDate *today = [NSDate date];
    NSDate *downloadDate = [NSDate dateWithTimeIntervalSince1970:[DataStore sharedDataStore].user.downloadDate];
    NSDateComponents *todayComponents = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:today];
    NSDateComponents *downloadComponents = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:downloadDate];
    
    NSInteger adjustedYear = todayComponents.month + self.monthAdditionToNow < 1 ? todayComponents.year - 1 : todayComponents.year;
    NSInteger adjustedMonth = todayComponents.month + self.monthAdditionToNow < 1 ? todayComponents.month + self.monthAdditionToNow + 12 : todayComponents.month + self.monthAdditionToNow;
    
    self.isPreDownload = (adjustedYear < downloadComponents.year) || (adjustedMonth < downloadComponents.month && (adjustedYear == downloadComponents.year));
    
    self.isCurrentMonth = monthAdditionToNow == 0;
    
    [self configureCell];
}

@end
