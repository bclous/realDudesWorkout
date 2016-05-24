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
@property (weak, nonatomic) IBOutlet UIImageView *blueOutlineImage;
@property (weak, nonatomic) IBOutlet UIImageView *circleImage;

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
    
    self.pictureChosen = NO;
    
    self.blueOutlineImage.alpha = 0;
    
    self.contentView.alpha = .5;
    
}
- (IBAction)pictureTapped:(id)sender
{

    if (self.pictureChosen)
    {
        self.blueOutlineImage.alpha = 0;
        self.contentView.alpha = .5;

        self.pictureChosen = NO;
    }
    else
    {
      self.blueOutlineImage.alpha = 1;
        self.contentView.alpha = 1;
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
