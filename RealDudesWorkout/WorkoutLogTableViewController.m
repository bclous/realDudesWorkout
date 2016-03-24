//
//  WorkoutLogTableViewController.m
//  RealDudesWorkout
//
//  Created by Brian Clouser on 3/17/16.
//  Copyright © 2016 The Qwiz LLC. All rights reserved.
//

#import "WorkoutLogTableViewController.h"
#import "UIScrollView+APParallaxHeader.h"
#import "WorkoutTableViewCell.h"
#import "SWTableViewCell.h"
#import "WorkoutDetailTableViewController.h"

@interface WorkoutLogTableViewController () <SWTableViewCellDelegate>

@end

@implementation WorkoutLogTableViewController

- (void)viewDidLoad
{
    
    [super viewDidLoad];
    
    [self.tableView addParallaxWithImage:[UIImage imageNamed:@"hotGirlWorkout"] andHeight:250 andShadow:YES];
    
    self.dataStore = [DataStore sharedDataStore];
    
    [self.dataStore fetchData];
    
}

-(void)viewDidAppear:(BOOL)animated
{

    [self.dataStore fetchData];
    
    [self.tableView reloadData];

}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.dataStore.user.workouts.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"basicCell" forIndexPath:indexPath];
    
    WorkoutTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"workoutCell" forIndexPath:indexPath];
    
    NSArray *workoutsInOrderLIFO = [self.dataStore.user orderedWorkoutsLIFO];
    
    Workout *workout = workoutsInOrderLIFO[indexPath.row];
    
    cell.weekdayLabel.text = [workout workoutStartDayOfWeek];
    cell.dayOfMonthLabel.text = [workout workoutStartDayOfMonth];
    cell.monthLabel.text = [workout workoutStartMonth];
    
    cell.workoutNameLabel.text = workout.name;
    cell.workoutTimeAndDurationLabel.text = [workout workoutTimeString];
    cell.workoutExcercisesCompleteLabel.text = [workout excercisesCompletedString];
    
    // set up delete button
    cell.rightUtilityButtons = [self rightButtons];
    cell.delegate = self;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [self performSegueWithIdentifier:@"segueToWorkoutDetail" sender:self];
}


// helper method for SWCell delegate
- (NSArray *)rightButtons
{
    
    NSMutableArray *rightUtilityButtons = [NSMutableArray new];
    
    [rightUtilityButtons sw_addUtilityButtonWithColor:
     
    [UIColor colorWithRed:1.0f green:0.231f blue:0.188 alpha:1.0f]
                                                title:@"Delete"];
    return rightUtilityButtons;
}







/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/



- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    NSLog(@"this is getting called");
    
    if ([segue.identifier isEqualToString:@"segueToWorkoutDetail"])
    {
    
        WorkoutDetailTableViewController *destinationVC = segue.destinationViewController;
        
        NSIndexPath *selectedPath = self.tableView.indexPathForSelectedRow;
        
        NSArray *workoutsInOrderLIFO = [self.dataStore.user orderedWorkoutsLIFO];
        
        Workout *selectedWorkout = workoutsInOrderLIFO[selectedPath.row];
        
        destinationVC.workout = selectedWorkout;
    }
    
    
}


@end
