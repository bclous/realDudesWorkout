//
//  TotalWorkoutSummaryViewController.m
//  RealDudesWorkout
//
//  Created by Brian Clouser on 4/2/16.
//  Copyright © 2016 The Qwiz LLC. All rights reserved.
//

#import "TotalWorkoutSummaryViewController.h"
#import "TotalExcercisesTableViewCell.h"
#import "WorkoutsSinceSummaryTableViewCell.h"
#import "DataStore.h"

@interface TotalWorkoutSummaryViewController () <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UISegmentedControl *timePeriodToggle;
@property (weak, nonatomic) IBOutlet UITableView *summaryTableView;
@property (strong, nonatomic) NSArray *excercisesAndReps;
@property (strong, nonatomic) NSArray *pictureNames;
@property (strong, nonatomic) DataStore *dataStore;

@end

@implementation TotalWorkoutSummaryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self toggleTitles];
    

    
    self.dataStore = [DataStore sharedDataStore];
    
    self.summaryTableView.delegate = self;
    self.summaryTableView.dataSource = self;
    
    self.excercisesAndReps = [self.dataStore.user excerciseNameAndQuantitySortedGivenWorkouts:self.workoutsSinceTimeInterval];
    self.pictureNames = [self.dataStore.user excercisePictureNamesSortedGivenWorkouts:self.workoutsSinceTimeInterval];
    

}

- (IBAction)toggleSwitched:(id)sender
{
    
    if (self.timePeriodToggle.selectedSegmentIndex == 0)
    {
        self.excercisesAndReps = [self.dataStore.user excerciseNameAndQuantitySortedGivenWorkouts:self.workoutsSinceTimeInterval];
        self.pictureNames = [self.dataStore.user excercisePictureNamesSortedGivenWorkouts:self.workoutsSinceTimeInterval];
        
        [self.summaryTableView reloadData];
    }
    
    else if (self.timePeriodToggle.selectedSegmentIndex == 1)
    {
        self.excercisesAndReps = [self.dataStore.user excerciseNameAndQuantitySortedGivenWorkouts:self.workoutsSinceSetDay];
        self.pictureNames = [self.dataStore.user excercisePictureNamesSortedGivenWorkouts:self.workoutsSinceSetDay];
        
        [self.summaryTableView reloadData];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;
{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if (section == 0)
    {
        return 1;
    }
    else
    {
        return self.excercisesAndReps.count;
    }
    
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    if (indexPath.section == 0)
    {
        WorkoutsSinceSummaryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"totalWorkoutsSummaryCell"];
        
        cell.workoutsSinceSummaryView.workouts = self.workoutsSinceSetDay;
        
        return cell;
    }
    else
    {
        TotalExcercisesTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"totalExcercisesCell"];
        
        cell.ExcercisesView.excerciseImage.image = [UIImage imageNamed:self.pictureNames[indexPath.row]];
        
        cell.ExcercisesView.ExcerciseTotalLabel.text = self.excercisesAndReps[indexPath.row];
        
        return cell;
        
                                                               
    }
}

-(void)toggleTitles
{
    if ([self.timePeriod isEqualToString:@"weekly"])
    {
        [self.timePeriodToggle setTitle:@"Last 7 days" forSegmentAtIndex:0];
        [self.timePeriodToggle setTitle:@"Since Monday" forSegmentAtIndex:1];
    }
    else if ([self.timePeriod isEqualToString:@"monthly"])
    {
        [self.timePeriodToggle setTitle:@"Last 30 days" forSegmentAtIndex:0];
        [self.timePeriodToggle setTitle:@"Since the 1st" forSegmentAtIndex:1];
    }
    else
    {
        [self.timePeriodToggle setTitle:@"Last 365 days" forSegmentAtIndex:0];
        [self.timePeriodToggle setTitle:@"Since January 1st" forSegmentAtIndex:1];
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
