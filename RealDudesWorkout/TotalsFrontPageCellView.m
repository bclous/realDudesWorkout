//
//  TotalsFrontPageCellView.m
//  RealDudesWorkout
//
//  Created by Brian Clouser on 4/4/16.
//  Copyright © 2016 The Qwiz LLC. All rights reserved.
//

#import "TotalsFrontPageCellView.h"
#import "DataStore.h"

@interface TotalsFrontPageCellView ()

@property (strong, nonatomic) IBOutlet UIView *contentView;

@property (weak, nonatomic) IBOutlet UILabel *weekWorkoutsLabel;
@property (weak, nonatomic) IBOutlet UILabel *monthWorkoutsLabel;
@property (weak, nonatomic) IBOutlet UILabel *yearWorkoutsLabel;
@property (weak, nonatomic) IBOutlet UILabel *lifetimeWorkoutsLabel;
@property (weak, nonatomic) IBOutlet UILabel *weekLabel;
@property (weak, nonatomic) IBOutlet UILabel *monthLabel;
@property (weak, nonatomic) IBOutlet UILabel *yearLabel;
@property (weak, nonatomic) IBOutlet UILabel *lifetimeLabel;
@property (weak, nonatomic) IBOutlet UIView *weekView;
@property (weak, nonatomic) IBOutlet UIView *monthView;
@property (weak, nonatomic) IBOutlet UIView *yearView;
@property (weak, nonatomic) IBOutlet UIView *lifetimeView;

@property (strong, nonatomic) DataStore *dataStore;


@end

@implementation TotalsFrontPageCellView

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
    
    
    [[NSBundle mainBundle] loadNibNamed:@"TotalsFrontPageCell" owner:self options:nil];
    
    [self addSubview:self.contentView];
    
    self.contentView.frame = self.bounds;
    
    
    self.dataStore = [DataStore sharedDataStore];

    
}



- (IBAction)weekViewTapped:(id)sender
{
    
}
- (IBAction)monthViewTapped:(id)sender
{
    
}
- (IBAction)yearViewTapped:(id)sender
{
    
}
- (IBAction)lifetimeViewTapped:(id)sender
{
    
}


-(void)generateAllLabels
{
    
     NSUInteger workoutsWeek =  ((NSArray *)[self.dataStore.user workoutsLastSevenDays]).count;
     NSUInteger workoutsMonth =  ((NSArray *)[self.dataStore.user workoutsLastThirtyDays]).count;
     NSUInteger workoutsYear =  ((NSArray *)[self.dataStore.user workoutsLast365Days]).count;
    
     NSUInteger workoutsLifetime =  ((NSArray *)[self.dataStore.user orderedWorkoutsLIFO]).count;
    
    if (workoutsWeek == 1)
    {
        self.weekWorkoutsLabel.text = [NSString stringWithFormat:@"%lu workout",workoutsWeek];
    }
    else
    {
         self.weekWorkoutsLabel.text = [NSString stringWithFormat:@"%lu workouts",workoutsWeek];
    }

    
}



@end
