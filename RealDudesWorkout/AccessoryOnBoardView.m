//
//  AccessoryOnBoardView.m
//  RealDudesWorkout
//
//  Created by Brian Clouser on 5/21/16.
//  Copyright © 2016 The Qwiz LLC. All rights reserved.
//

#import "AccessoryOnBoardView.h"

@interface  AccessoryOnBoardView ()

@property (strong, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UIImageView *accessoryImageView;
@property (weak, nonatomic) IBOutlet UILabel *accessoryLabel;

@property (nonatomic) BOOL pictureChosen;


@end

@implementation AccessoryOnBoardView

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
    
    [[NSBundle mainBundle] loadNibNamed:@"AccessoryOnBoard" owner:self options:nil];
    
    [self addSubview:self.contentView];
    
    self.contentView.frame = self.bounds;
    
    self.accessoryOutlineCircleView.layer.borderWidth = 5;
      self.accessoryOutlineCircleView.layer.borderColor = [[UIColor darkGrayColor] CGColor];
    
    self.pictureChosen = NO;
    
}
- (IBAction)pictureTapped:(id)sender
{
    if (self.pictureChosen)
    {
        self.accessoryOutlineCircleView.layer.borderWidth = 5;
         self.accessoryOutlineCircleView.layer.borderColor = [[UIColor darkGrayColor] CGColor];
       
        
        self.pictureChosen = NO;
    }
    else
    {
        self.accessoryOutlineCircleView.layer.borderWidth = 5;
        self.accessoryOutlineCircleView.layer.borderColor = [[UIColor colorWithRed:70.0/255.0 green:150.0/255.0 blue:255.0/255.0 alpha:1] CGColor];
        
        self.pictureChosen = YES;
        
    }
    
}

-(void)setAccessory:(Accessory *)accessory
{
    
    _accessory = accessory;
    
    self.accessoryImageView.image = [UIImage imageNamed:accessory.pictureName];
    self.accessoryLabel.text = accessory.name;
    
    
}

@end
