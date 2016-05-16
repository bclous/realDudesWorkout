//
//  NumberOfWorkoutsView.m
//  RealDudesWorkout
//
//  Created by Brian Clouser on 5/11/16.
//  Copyright © 2016 The Qwiz LLC. All rights reserved.
//

#import "NumberOfWorkoutsView.h"

@interface NumberOfWorkoutsView()
@property (strong, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UIView *outlineView;
@property (weak, nonatomic) IBOutlet UILabel *numberOfWorkoutsLabel;
@property (weak, nonatomic) IBOutlet UILabel *workoutsLabel;




@end

@implementation NumberOfWorkoutsView

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
    
    
    [[NSBundle mainBundle] loadNibNamed:@"NumberOfWorkouts" owner:self options:nil];
    
    [self addSubview:self.contentView];
    
    self.contentView.frame = self.bounds;
    
    self.outlineView.layer.cornerRadius = 30;
    
    
}


@end
