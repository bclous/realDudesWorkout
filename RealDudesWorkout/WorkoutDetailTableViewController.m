//
//  WorkoutDetailTableViewController.m
//  RealDudesWorkout
//
//  Created by Brian Clouser on 3/12/16.
//  Copyright © 2016 The Qwiz LLC. All rights reserved.
//

#import "WorkoutDetailTableViewController.h"

@interface WorkoutDetailTableViewController ()

@property (strong, nonatomic) NSArray *excercisesOutOfOrder;
@property (strong, nonatomic) NSArray *excercisesInOrder;
@property (strong, nonatomic) NSArray *excercisesInOrderCompleted;

@end

@implementation WorkoutDetailTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.excercisesOutOfOrder = [self.workout.excercises allObjects];
//    
//    [self orderExcercises];
//    
//    [self generateArrayOfOnlyCompletedExcercises];
//    
//    for (Excercise *excercise in self.excercisesInOrder)
//    {
//        NSLog(@"%@ is complete: %.0lld",excercise.name, excercise.timeInSecondsActual);
//    }
    
    
    
    
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0)
    {
        return 3;
    }
    else
    {
        
    }
    return self.excercisesInOrderCompleted.count;

    }


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 0)
    {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: @"excerciseCell" forIndexPath:indexPath];
        
        if (indexPath.row == 0)
        {
            cell.textLabel.text = @"Date: date here";
            
        }
        else if (indexPath.row == 1)
        {
            cell.textLabel.text = [NSString stringWithFormat:@"Workout duration: %@",[self totalTimeText]];
        }
        else
        {
            //cell.textLabel.text = [self numberOfExcercisesText];
        }
        
        return cell;

    }
    
    else
    {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: @"excerciseCell" forIndexPath:indexPath];
        
        Excercise *excerciseAtRow = self.excercisesInOrderCompleted[indexPath.row];
        
        //cell.textLabel.text = [self excerciseTextFrom:excerciseAtRow];
        
        return cell;
    }
    
    
    
    
}

-(void)orderExcercises
{
    
    
    NSSortDescriptor *sortByIndexValueDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"indexInWorkoutNumber" ascending:YES];
    
    self.excercisesInOrder = [self.excercisesOutOfOrder sortedArrayUsingDescriptors:@[sortByIndexValueDescriptor]];
    

    
}

-(void)generateArrayOfOnlyCompletedExcercises
{
    NSPredicate *onlyCompletedExcercisesPredicate = [NSPredicate predicateWithFormat:@"isComplete = YES"];
    
    self.excercisesInOrderCompleted = [self.excercisesInOrder filteredArrayUsingPredicate:onlyCompletedExcercisesPredicate];
    
}

//-(NSString *)numberOfExcercisesText
//{
//   /NSUInteger totalNumberOfExcercises = [;
//    NSUInteger completedExcercises = self.excercisesInOrderCompleted.count;
//    
//    if (self.workout.isFinishedSuccessfully)
//    {
//        NSString *numberOfExcercises = [NSString stringWithFormat:@"%lu/%lu workout completed!",completedExcercises,totalNumberOfExcercises];
//        
//        return numberOfExcercises;
//    }
//    else
//    {
//        NSString *numberOfExcercises = [NSString stringWithFormat:@"%lu/%lu workout incomplete",completedExcercises,totalNumberOfExcercises];
//        
//        return numberOfExcercises;
//
//    }
//    
//}

-(NSString *)totalTimeText
{
    
    NSInteger hours = self.workout.timeInSeconds/3600;
    NSInteger minutes = (((NSInteger)self.workout.timeInSeconds)%3600)/60;
    NSInteger seconds = (((NSInteger)self.workout.timeInSeconds)%3600)%60;
    
    BOOL hasHours = hours > 0;
    BOOL hasMinutes = minutes > 0;
    
    if (hasHours)
    {
        NSString *stringWithHours = [NSString stringWithFormat:@"%luh %lum %lus",hours,minutes,seconds];
        
        return stringWithHours;
    }
    else if (hasMinutes)
    {
        NSString *stringWithMinutes = [NSString stringWithFormat:@"%lum %lus",minutes, seconds];
        
        return stringWithMinutes;
    }
    else
    {
        NSString *stringWithSeconds = [NSString stringWithFormat:@"%lus",seconds];
        
        return stringWithSeconds;
    }
    
    return @"0s";
    
}
                               
//-(NSString *)excerciseTextFrom:(Excercise *)excercise
//{
//    BOOL isRest = [excercise.name isEqualToString:@"Rest"];
//    
//    if (isRest)
//    {
//        NSString *restString = [NSString stringWithFormat:@"Rested for %lld seconds",excercise.timeInSecondsActual];
//        
//        return restString;
//    }
//    else
//    {
//        NSString *excerciseString = [NSString stringWithFormat:@"%lld %@",excercise.numberOfRepsActual, excercise.name];
//        
//        return excerciseString;
//    }
//    
//}


                               
                               




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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
