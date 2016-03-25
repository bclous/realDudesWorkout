//
//  PostWorkoutSummaryViewController.m
//  RealDudesWorkout
//
//  Created by Brian Clouser on 3/24/16.
//  Copyright © 2016 The Qwiz LLC. All rights reserved.
//

#import "PostWorkoutSummaryViewController.h"
#import "WorkoutSummaryTableViewCell.h"
#import "ExcerciseTableViewCell.h"
#import "RestTableViewCell.h"
#import "WorkoutSummaryCellView.h"
#import "ExcerciseCellView.h"

@interface PostWorkoutSummaryViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *workoutDetailTableView;
@property (strong, nonatomic) Workout *workout;
@property (strong, nonatomic) NSArray *excerciseSets;


@end

@implementation PostWorkoutSummaryViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.workoutDetailTableView.delegate = self;
    self.workoutDetailTableView.dataSource = self;
    
    self.datastore = [DataStore sharedDataStore];
    
    NSArray *workoutsInOrder = [self.datastore.user orderedWorkoutsLIFO];
    
    self.workout = workoutsInOrder[0];
    
    NSLog(@"workout name is: %@", self.workout.name);
    
    self.excerciseSets = [self.workout excercisesInOrder];
    
    NSLog(@"with %lld excercises in it", self.excerciseSets.count);
    
    self.navigationItem.hidesBackButton = YES;
    
}


- (IBAction)buttonPressed:(id)sender
{
    [self.navigationController popToRootViewControllerAnimated:YES];
    
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


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
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
        return self.excerciseSets.count;
    }
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;

{
    
    
    if (indexPath.section == 0)
    {
    
        WorkoutSummaryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"workoutSummaryCell"];
        
        cell.workoutSummaryCellView.workout = self.workout;
        
        NSLog(@"name of working in cell making method: %@", self.workout.name);
        
        return cell;
    }
    
    else
    {
        
        ExcerciseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"excerciseCell"];
        
        cell.excerciseCellView.excerciseSet = self.excerciseSets[indexPath.row];
        
        return cell;
    
    }
}

    
    
    




/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
