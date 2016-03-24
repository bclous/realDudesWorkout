//
//  TimeIntervalFormatter.h
//  RealDudesWorkout
//
//  Created by Brian Clouser on 3/23/16.
//  Copyright © 2016 The Qwiz LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TimeIntervalFormatter : NSObject

+(NSString*)intervalStringWithSeconds:(NSTimeInterval)interval;

@end
