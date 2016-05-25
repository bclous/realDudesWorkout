//
//  AccessoryOnBoardView.h
//  RealDudesWorkout
//
//  Created by Brian Clouser on 5/21/16.
//  Copyright © 2016 The Qwiz LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Accessory.h"

@protocol AccessoryOnBoardDelegate <NSObject>

-(void)accessoryChosen:(Accessory *)accessory;
-(void)accessoryUnchosen:(Accessory *)accessory;

@end

@interface AccessoryOnBoardView : UIView

@property (strong, nonatomic) Accessory *accessory;
@property (weak, nonatomic) id <AccessoryOnBoardDelegate> delegate;

@end
