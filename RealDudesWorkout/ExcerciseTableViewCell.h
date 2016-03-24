//
//  ExcerciseTableViewCell.h
//  RealDudesWorkout
//
//  Created by Brian Clouser on 3/23/16.
//  Copyright © 2016 The Qwiz LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ExcerciseTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *excerciseImage;
@property (weak, nonatomic) IBOutlet UILabel *repsAndNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *durationLabel;

@end
