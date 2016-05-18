//
//  WorkoutSummaryScrollTableViewCell.h
//  RealDudesWorkout
//
//  Created by Brian Clouser on 5/16/16.
//  Copyright © 2016 The Qwiz LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WorkoutScrollSummaryCellView.h"


@interface WorkoutSummaryScrollTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet WorkoutScrollSummaryCellView *workoutScrollSummaryView;


@end
