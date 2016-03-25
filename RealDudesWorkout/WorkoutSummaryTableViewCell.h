//
//  WorkoutSummaryTableViewCell.h
//  RealDudesWorkout
//
//  Created by Brian Clouser on 3/24/16.
//  Copyright © 2016 The Qwiz LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WorkoutSummaryCellView.h"

@interface WorkoutSummaryTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet WorkoutSummaryCellView *workoutSummaryCellView;

@end
