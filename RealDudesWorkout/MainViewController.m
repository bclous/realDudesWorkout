//
//  MainViewController.m
//  RealDudesWorkout
//
//  Created by Brian Clouser on 3/9/16.
//  Copyright © 2016 The Qwiz LLC. All rights reserved.
//

#import "MainViewController.h"
#import "WorkoutDetailTableViewController.h"
#import <FontAwesomeKit/FontAwesomeKit.h>
#import <CWStatusBarNotification.h>

@interface MainViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UIButton *addWorkoutButton;
@property (weak, nonatomic) IBOutlet UITableView *workoutTableView;
@property (weak, nonatomic) IBOutlet UIImageView *emilyImage;



@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSLog(@"we're in the VC!");
    
    self.workoutTableView.delegate = self;
    self.workoutTableView.dataSource = self;
    
    self.emilyImage.image = [UIImage imageNamed:@"emily"];
    self.emilyImage.alpha = 1;
    self.workoutTableView.alpha = 0;
    
    [UIView animateWithDuration:3.5 animations:^{
        
        self.emilyImage.alpha = 0;
        self.workoutTableView.alpha = 1;
    }];
    
    self.dataStore = [dataStore sharedDataStore];
    
    [self.dataStore fetchData];
    
   // NSLog(@"in view controller, %li items in the back array", self.dataStore.backExcercises.count);
    
    //self.addButton.hidden = NO;
    
    FAKFontAwesome *addWorkout = [FAKFontAwesome arrowCircleORightIconWithSize:75];
    
    NSAttributedString *addWorkoutString = [addWorkout attributedString];
    
    [self.addWorkoutButton setAttributedTitle:addWorkoutString forState:0];
    
    self.workoutTableView.sectionHeaderHeight = 10;
    

    
    //NSLog(@"%li excercises in the back array",self.dataStore.backExcercises.count);
}


-(void)viewWillAppear:(BOOL)animated
{
    [self.dataStore fetchData];
    
    [self.workoutTableView reloadData];
    
     // NSLog(@"%li excercises in the back array",self.dataStore.backExcercises.count);
    

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
        return self.dataStore.workouts.count;
    }
   
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 0)
    {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"basicCell" forIndexPath:indexPath];
        
        cell.textLabel.text = @"Lifetime totals";
        
        return cell;
    }
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"basicCell" forIndexPath:indexPath];
    
    Workout *workoutAtRow = self.dataStore.workouts[indexPath.row];
    
    cell.textLabel.text = workoutAtRow.name;
    
    return cell;
    
}




#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
   //Segue for when user clicks into a workout.  Sends that view controller the selected workout. 
    
    
    BOOL tapToWorkoutDetail = [segue.identifier isEqualToString:@"segueToWorkoutDetail"];
    
    if (tapToWorkoutDetail)
    {
    
        WorkoutDetailTableViewController *destinationVC = segue.destinationViewController;
        
        NSIndexPath *indexPath = [self.workoutTableView indexPathForSelectedRow];
        
        destinationVC.workout = self.dataStore.workouts[indexPath.row];
    
    }
    
    
}


@end
