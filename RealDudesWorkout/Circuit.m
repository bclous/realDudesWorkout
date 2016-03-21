//
//  Circuit.m
//  RealDudesWorkout
//
//  Created by Brian Clouser on 3/18/16.
//  Copyright © 2016 The Qwiz LLC. All rights reserved.
//

#import "Circuit.h"
#import "Workout.h"

@implementation Circuit

// Insert code here to add functionality to your managed object subclass

-(NSArray *)excerciseSetsInOrder
{
    NSArray *excerciseSetsNotInOrder = [self.excerciseSets allObjects];
    
    NSSortDescriptor *ExcerciseSetSortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"excerciseSetIndexNumberInCicuit" ascending:NO];
    
    NSArray *excerciseSetsInOrder = [excerciseSetsNotInOrder sortedArrayUsingDescriptors:@[ExcerciseSetSortDescriptor]];
    
    return excerciseSetsInOrder;
    
}

@end
