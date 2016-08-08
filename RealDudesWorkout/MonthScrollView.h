//
//  MonthScrollView.h
//  RealDudesWorkout
//
//  Created by Brian Clouser on 8/3/16.
//  Copyright © 2016 The Qwiz LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MonthScrollViewDelegate <NSObject>

-(void)newIndexChosen:(NSUInteger)index;

@end

@interface MonthScrollView : UIView

@property (weak, nonatomic) id <MonthScrollViewDelegate>delegate;
@property (weak, nonatomic) IBOutlet UIScrollView *monthScrollView;
@property (nonatomic) CGFloat scrollViewWidth;

-(void)moveScrollViewToIndex:(NSUInteger)index animate:(BOOL)animate;

@end
