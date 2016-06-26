//
//  WorkoutTotalIndividualView.h
//  RealDudesWorkout
//
//  Created by Brian Clouser on 6/6/16.
//  Copyright © 2016 The Qwiz LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol WorkoutTotalIndividualViewDelegate <NSObject>

-(void)moreDetailsTappped:(NSString *)timePeriod;

@end

@interface WorkoutTotalIndividualView : UIView

@property (strong, nonatomic) NSString *timePeriod;
@property (weak, nonatomic) IBOutlet UILabel *totalTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *averageTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *moreLabel;
@property (weak, nonatomic) id <WorkoutTotalIndividualViewDelegate> delegate;


@end
