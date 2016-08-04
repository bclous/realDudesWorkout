//
//  TableViewHeaderView.m
//  RealDudesWorkout
//
//  Created by Brian Clouser on 8/3/16.
//  Copyright © 2016 The Qwiz LLC. All rights reserved.
//

#import "TableViewHeaderView.h"

@interface TableViewHeaderView ()

@property (strong, nonatomic) IBOutlet UIView *contentView;

@end

@implementation TableViewHeaderView

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
    [[NSBundle mainBundle] loadNibNamed:@"TableViewHeaderView" owner:self options:nil];
    [self addSubview:self.contentView];
    self.contentView.frame = self.bounds;
}


@end
