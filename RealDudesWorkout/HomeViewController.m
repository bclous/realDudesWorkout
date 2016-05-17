//
//  HomeViewController.m
//  RealDudesWorkout
//
//  Created by Brian Clouser on 5/11/16.
//  Copyright © 2016 The Qwiz LLC. All rights reserved.
//

#import "HomeViewController.h"
#import "DataStore.h"
#import "TotalsFrontPageCellView.h"
#import "ExcerciseTableViewCell.h"
#import "WorkoutSummaryScrollTableViewCell.h"


@interface HomeViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet TotalsFrontPageCellView *totalsView;
@property (weak, nonatomic) IBOutlet UITableView *workoutsTableView;
@property (strong, nonatomic) DataStore *dataStore;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpMainTableView];
    
    self.dataStore = [DataStore sharedDataStore];
    
    
}

-(void)setUpMainTableView
{
    
    self.workoutsTableView.dataSource = self;
    self.workoutsTableView.delegate = self;

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WorkoutSummaryScrollTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"summaryCell"];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 265;
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
