//
//  WorkoutDetailTableViewController.m
//  RealDudesWorkout
//
//  Created by Brian Clouser on 3/12/16.
//  Copyright © 2016 The Qwiz LLC. All rights reserved.
//

#import "WorkoutDetailTableViewController.h"
#import "ExcerciseTableViewCell.h"
#import "RestTableViewCell.h"
#import "WorkoutSummaryTableViewCell.h"
#import "ExcerciseTableViewCell.h"

@interface WorkoutDetailTableViewController ()

@property (strong, nonatomic) NSArray *excercises;

@end

@implementation WorkoutDetailTableViewController

- (void)viewDidLoad {

[super viewDidLoad];

    self.excercises = [self.workout completedExcercisesInOrder];

    self.tableView.tableFooterView = [UIView new];

    [self.tableView setSeparatorColor:[UIColor groupTableViewBackgroundColor]];
    


}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

      return 2;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  
    if (section == 0)
    {
        return 1;
    }
    
    else
    {
        return self.excercises.count;
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        return 162;
    }
    
    else
    {
        return 100;
    }
    
}

-(BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath
{
    return NO;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    if (indexPath.section == 0)
    {
        WorkoutSummaryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"workoutSummaryCell"];
        
        cell.workoutSummaryCellView.workout = self.workout;
        
        return cell;
    }
    else
    {
        NSLog(@"getting in the else to make the excercise cell");
        
        ExcerciseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"excerciseCell"];
        
        cell.excerciseCellView.excerciseSet = self.excercises[indexPath.row];
        
        return cell;
    }
    
    
    
//    if (indexPath.section == 0)
//    {
//        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"basicCell"];
//        
//        NSArray *info = [self.workout arrayOfInfo];
//        
//        cell.textLabel.text = info[indexPath.row];
//        
//        return cell;
//        
//    }
//    
//    else
//    {
//        
//        BOOL isExcerciseCell = indexPath.row%2 == 0;
//        
//        ExcerciseSet *excerciseSetAtRow = self.excercises[indexPath.row / 2];
//        
//        if (isExcerciseCell)
//        {
//            ExcerciseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"excerciseCell" forIndexPath:indexPath];
//            
//            cell.excerciseImage.image = [UIImage imageNamed:excerciseSetAtRow.excercise.pictureName];
//            cell.repsAndNameLabel.text = [NSString stringWithFormat:@"%lld %@",excerciseSetAtRow.numberofRepsActual,excerciseSetAtRow.excercise.name];
//            cell.durationLabel.text = [self timeStringWithSecondsFromTimeInteveral:excerciseSetAtRow.timeInSecondsActual];
//            
//            [cell setSeparatorInset:UIEdgeInsetsZero];
//            
//            
//            
//            
//            return cell;
//            
//            
//            
//        }
//        
//        else
//        {
//            RestTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"restCell" forIndexPath:indexPath];
//            
//            cell.restLabel.text = @"Rest";
//            cell.durationLabel.text = [self timeStringWithSecondsFromTimeInteveral:excerciseSetAtRow.restTimeAfterInSecondsActual];;
//            
//            [cell setSeparatorInset:UIEdgeInsetsZero];
//            
//            
//            return cell;
//            
//        }
//        
//    }

}



-(NSString *)timeStringWithSecondsFromTimeInteveral:(NSTimeInterval)interval
{
    
    NSInteger hours = interval/3600;
    NSInteger minutes = (((NSInteger)interval)%3600)/60;
    NSInteger seconds = (((NSInteger)interval)%3600)%60;
    
    
    
    BOOL moreThanDay = hours > 24;
    
    BOOL hasHours = hours > 0;
    BOOL hasMinutes = minutes > 0;
    
    BOOL singleDigitSeconds = seconds < 10;
    BOOL singleDigitMinutes = minutes < 10;
    
    if (moreThanDay)
    {
        return @"> 1 day";
    }
    else if (singleDigitSeconds && !hasMinutes && !hasHours)
    {
        NSString *time = [NSString stringWithFormat:@"0:0%ld",(long)seconds];
        
        return time;
    }
    else if (!singleDigitSeconds && !hasMinutes && !hasHours)
    {
        NSString *time = [NSString stringWithFormat:@"0:%ld",(long)seconds];
        
        return time;
    }
    else if (singleDigitSeconds && hasMinutes && !hasHours)
    {
        NSString *time = [NSString stringWithFormat:@"%ld:0%ld",(long)minutes,(long)seconds];
        
        return time;
    }
    else if (!singleDigitSeconds && hasMinutes && !hasHours)
    {
        NSString *time = [NSString stringWithFormat:@"%ld:%ld",(long)minutes,(long)seconds];
        
        return time;
        
    }
    else if (hasHours && singleDigitSeconds && singleDigitMinutes)
    {
        NSString *time = [NSString stringWithFormat:@"%ld:%0ld:0%ld",(long)hours,(long)minutes,(long)seconds];
        
        return time;
    }
    else if(hasHours && singleDigitSeconds && !singleDigitMinutes)
    {
        NSString *time = [NSString stringWithFormat:@"%ld:%ld:0%ld",(long)hours,(long)minutes,(long)seconds];
        
        return time;
    }
    else if(hasHours && !singleDigitSeconds && singleDigitMinutes)
    {
        NSString *time = [NSString stringWithFormat:@"%ld:%0ld:%ld",(long)hours,(long)minutes,(long)seconds];
        
        return time;
    }
    else
    {
        NSString *time = [NSString stringWithFormat:@"%ld:%ld:%ld",(long)hours,(long)minutes,(long)seconds];
        
        return time;
    }
    
    
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
