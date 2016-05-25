//
//  WorkoutOnBoardView.m
//  RealDudesWorkout
//
//  Created by Brian Clouser on 5/20/16.
//  Copyright © 2016 The Qwiz LLC. All rights reserved.
//

#import "WorkoutOnBoardView.h"

@interface WorkoutOnBoardView () <AccessoryOnBoardDelegate>

@property (strong, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UIButton *startButton;
@property (weak, nonatomic) IBOutlet UIStackView *minusLabel;
@property (weak, nonatomic) IBOutlet UILabel *plusLabel;
@property (weak, nonatomic) IBOutlet UILabel *minutesLabel;

@property (weak, nonatomic) IBOutlet AccessoryOnBoardView *accessory1;
@property (weak, nonatomic) IBOutlet AccessoryOnBoardView *accessory2;
@property (weak, nonatomic) IBOutlet AccessoryOnBoardView *accessory3;
@property (weak, nonatomic) IBOutlet AccessoryOnBoardView *accessory4;
@property (weak, nonatomic) IBOutlet AccessoryOnBoardView *accessory5;
@property (weak, nonatomic) IBOutlet AccessoryOnBoardView *accessory6;

@property (strong, nonatomic) NSMutableArray *availableAccessories;

@property (nonatomic) NSUInteger workoutLength;

@property (strong, nonatomic) DataStore *dataStore;


@end

@implementation WorkoutOnBoardView

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
   
    
    self.dataStore = [DataStore sharedDataStore];
    
     NSLog(@"adding accessories, currently %lu available", self.dataStore.availableAccessories.count);
    
    
    
    [[NSBundle mainBundle] loadNibNamed:@"WorkoutOnBoard" owner:self options:nil];
    
    [self addSubview:self.contentView];
    
    self.contentView.frame = self.bounds;
    
    self.startButton.layer.cornerRadius = 15;
    
    self.workoutLength = 30;
    
    [self updateMinutesLabel];
    
    self.accessory1.delegate = self;
    self.accessory2.delegate = self;
    self.accessory3.delegate = self;
    self.accessory4.delegate = self;
    self.accessory5.delegate = self;
    self.accessory6.delegate = self;
    
    self.accessory1.accessory = self.dataStore.availableAccessories[0];
    self.accessory2.accessory = self.dataStore.availableAccessories[1];
    self.accessory3.accessory = self.dataStore.availableAccessories[2];
    self.accessory4.accessory = self.dataStore.availableAccessories[3];
    self.accessory5.accessory = self.dataStore.availableAccessories[4];
    self.accessory6.accessory = self.dataStore.availableAccessories[5];
    
    self.availableAccessories = [[NSMutableArray alloc] init];
    
    
}

- (IBAction)startButtonTapped:(id)sender
{
    [self.delegate generateWorkoutTapped:self.workoutLength accessories:self.availableAccessories];
    
     NSLog(@"adding accessories, currently %lu available", self.dataStore.availableAccessories.count);
}
- (IBAction)minusMinutesTapped:(id)sender
{
    
    if (!(self.workoutLength <= 5))
    {
        self.workoutLength = self.workoutLength - 5;
        
        [self updateMinutesLabel];
    }
    
    
}
- (IBAction)plusMinutesTapped:(id)sender
{
    
    if (self.workoutLength < 75)
    {
        self.workoutLength = self.workoutLength + 5;
        
        [self updateMinutesLabel];
    }
    
    
}

-(void)updateMinutesLabel
{
    
    self.minutesLabel.text = [NSString stringWithFormat:@"%lu", (unsigned long)self.workoutLength];
    
}

-(void)accessoryChosen:(Accessory *)accessory
{
    [self.availableAccessories addObject:accessory];
}

-(void)accessoryUnchosen:(Accessory *)accessory
{
    [self.availableAccessories removeObject:accessory];
}

@end
