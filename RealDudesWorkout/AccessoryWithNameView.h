//
//  AccessoryWithNameView.h
//  RealDudesWorkout
//
//  Created by Brian Clouser on 3/25/16.
//  Copyright © 2016 The Qwiz LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Accessory.h"

@interface AccessoryWithNameView : UIView

@property (strong, nonatomic) Accessory *accessory;
@property (nonatomic) NSUInteger timesTouched;

@end
