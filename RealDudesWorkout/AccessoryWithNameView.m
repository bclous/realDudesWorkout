//
//  AccessoryWithNameView.m
//  RealDudesWorkout
//
//  Created by Brian Clouser on 3/25/16.
//  Copyright © 2016 The Qwiz LLC. All rights reserved.
//

#import "AccessoryWithNameView.h"

@interface AccessoryWithNameView ()

@property (strong, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UIImageView *accessoryImage;
@property (weak, nonatomic) IBOutlet UILabel *AccessoryNameLabel;
@property (weak, nonatomic) IBOutlet UIView *labelView;

@property (weak, nonatomic) IBOutlet UIVisualEffectView *deselectedView;

@end

@implementation AccessoryWithNameView

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
    
    
    [[NSBundle mainBundle] loadNibNamed:@"AccessoryWithName" owner:self options:nil];
    
    [self addSubview:self.contentView];
    
    self.contentView.frame = self.bounds;
    
    self.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.layer.borderWidth = .5;
 
    
}

-(void)setAccessory:(Accessory *)accessory
{
    
    _accessory = accessory;
    
    self.accessoryImage.image = [UIImage imageNamed:accessory.pictureName];
    self.AccessoryNameLabel.text = accessory.name;
    
    self.timesTouched = 0;
    

}

-(void)setTimesTouched:(NSUInteger)timesTouched
{
    _timesTouched = timesTouched;
    
    NSLog(@"getting to set times touched");
    
    NSLog(@"times touched: %lu", timesTouched);
    
    if (timesTouched % 2 == 0)
    {
        self.deselectedView.hidden = YES;
        self.labelView.hidden = NO;
        
    
    }
    else
    {
        NSLog(@"getting to the else");
        self.deselectedView.hidden = NO;
        self.labelView.hidden = YES;
    }
}









/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
