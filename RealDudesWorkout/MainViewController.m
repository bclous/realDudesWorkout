//
//  MainViewController.m
//  RealDudesWorkout
//
//  Created by Brian Clouser on 3/9/16.
//  Copyright © 2016 The Qwiz LLC. All rights reserved.
//

#import "MainViewController.h"
#import "WorkoutDetailTableViewController.h"

@interface MainViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *addImage;

@property (weak, nonatomic) IBOutlet UITableView *workoutTableView;
@property (weak, nonatomic) IBOutlet UIImageView *emptyWorkoutsImage;

@property (weak, nonatomic) IBOutlet UIButton *addButton;


@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSLog(@"we're in the VC!");
    
    self.workoutTableView.delegate = self;
    self.workoutTableView.dataSource = self;
    
    self.dataStore = [dataStore sharedDataStore];
    
    [self.dataStore fetchData];
    
   // NSLog(@"in view controller, %li items in the back array", self.dataStore.backExcercises.count);
    
    self.addButton.hidden = NO;
    
    self.addImage.image = [UIImage imageNamed:@"addIcon"];
    
    if (self.dataStore.workouts.count == 0)
    {
        self.workoutTableView.hidden = YES;
        
        self.emptyWorkoutsImage.image = [UIImage imageNamed:@"emily"];
    }
    
    else
    {
        self.emptyWorkoutsImage.hidden = YES;
    }
    
    //NSLog(@"%li excercises in the back array",self.dataStore.backExcercises.count);
}
- (IBAction)logButtonPressed:(id)sender
{
    
    NSLog(@"this is where I was logging stuff");
    
    
}

-(void)viewDidAppear:(BOOL)animated
{
    [self.dataStore fetchData];
    
    [self.workoutTableView reloadData];
    
     // NSLog(@"%li excercises in the back array",self.dataStore.backExcercises.count);
    
    if (self.dataStore.workouts.count == 0)
    {
        self.workoutTableView.hidden = YES;
        
        self.emptyWorkoutsImage.image = [UIImage imageNamed:@"emily"];
    }
    
    else
    {
        self.workoutTableView.hidden = NO;
        self.emptyWorkoutsImage.hidden = YES;
    }

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    
    return self.dataStore.workouts.count;
   
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"basicCell" forIndexPath:indexPath];
    
    Workout *workoutAtRow = self.dataStore.workouts[indexPath.row];
    
    cell.textLabel.text = workoutAtRow.name;
    
    return cell;
    
}


- (IBAction)addWorkoutButtonTapped:(id)sender
{
    
        
    
    
    //nothing here except for it segueing
    
    

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
