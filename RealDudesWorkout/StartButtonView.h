//
//  StartButtonView.h
//  RealDudesWorkout
//
//  Created by Brian Clouser on 7/16/16.
//  Copyright © 2016 The Qwiz LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol StartButtonDelegate <NSObject>

-(void)startButtonTapped;

@end

@interface StartButtonView : UIView
@property (weak, nonatomic) id <StartButtonDelegate>delegate;
@property (weak, nonatomic) IBOutlet UIImageView *buttonImage;
@property (weak, nonatomic) IBOutlet UIView *outLineView;


@end
