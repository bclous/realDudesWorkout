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
#import "StartWorkoutButtonView.h"
#import "WorkoutOnBoardView.h"


@interface HomeViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet TotalsFrontPageCellView *totalsView;
@property (weak, nonatomic) IBOutlet UITableView *workoutsTableView;
@property (strong, nonatomic) DataStore *dataStore;
@property (strong, nonatomic) NSArray *workouts;

@property (strong, nonatomic) UIVisualEffectView *blurView;

@property (strong, nonatomic) NSLayoutConstraint *blurViewBottomConstraint;
@property (strong, nonatomic) NSLayoutConstraint *blurViewTopConstraint;
@property (strong, nonatomic) NSLayoutConstraint *blurViewLeftConstraint;
@property (strong, nonatomic) NSLayoutConstraint *blurViewRightConstraint;

@property (strong, nonatomic) NSLayoutConstraint *workoutOnBoardTopConstraint;
@property (strong, nonatomic) NSLayoutConstraint *workoutOnBoardBottomConstraint;

@property (strong, nonatomic) UIImageView *addAndCancelIconImageView;

@property (strong, nonatomic) UITapGestureRecognizer *addAndCancelTapGestureRecognizer;

@property (nonatomic) BOOL blurViewDisplayed;

@property (nonatomic) NSInteger selectedRow;

@property (strong, nonatomic) WorkoutOnBoardView *workoutOnBoardView;



@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpMainTableView];
    [self setUpStartButtonView];
    
    self.dataStore = [DataStore sharedDataStore];
    
    [self.dataStore fetchData];
    
    self.workouts = [self.dataStore.user orderedWorkoutsLIFO];
    
    
}

-(void)setUpMainTableView
{
    
    self.workoutsTableView.dataSource = self;
    self.workoutsTableView.delegate = self;
    
    self.selectedRow = -1;

}

-(void)setUpStartButtonView
{
    
    self.blurViewDisplayed = NO;
    
    self.blurView = [[UIVisualEffectView alloc] init];
    
    [self.view addSubview:self.blurView];
    
    self.blurView.translatesAutoresizingMaskIntoConstraints = NO;
    
    CGFloat screenHeight = self.view.frame.size.height;
    CGFloat screenWidth = self.view.frame.size.width;
    
    self.blurViewBottomConstraint = [self.blurView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor constant:-20];
    self.blurViewTopConstraint = [self.blurView.topAnchor constraintEqualToAnchor:self.view.topAnchor constant:screenHeight - 70];
    self.blurViewLeftConstraint = [self.blurView.leftAnchor constraintEqualToAnchor:self.view.leftAnchor constant:screenWidth/2 - 25];
    self.blurViewRightConstraint = [self.blurView.rightAnchor constraintEqualToAnchor:self.view.rightAnchor constant:-(screenWidth/2 - 25)];
    
    self.blurViewBottomConstraint.active = YES;
    self.blurViewTopConstraint.active = YES;
    self.blurViewLeftConstraint.active = YES;
    self.blurViewRightConstraint.active = YES;
    
    self.blurView.effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    
    self.blurView.layer.cornerRadius = 25;
    self.blurView.clipsToBounds = YES;
    self.blurView.alpha = .9;
    
    [self addButtonToBlurView];
    
    [self addTapGesture];
    
    [self createWorkoutOnBoardView];
    
}

-(void)addButtonToBlurView
{
    
    self.addAndCancelIconImageView = [[UIImageView alloc] init];
    self.addAndCancelIconImageView.image = [UIImage imageNamed:@"add"];
    self.addAndCancelIconImageView.userInteractionEnabled = YES;
    
    [self.view addSubview:self.addAndCancelIconImageView];
    
    self.addAndCancelIconImageView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.addAndCancelIconImageView.heightAnchor constraintEqualToConstant:30].active = YES;
    [self.addAndCancelIconImageView.widthAnchor constraintEqualToConstant:30].active = YES;
    
    [self.addAndCancelIconImageView.centerXAnchor constraintEqualToAnchor:self.blurView.centerXAnchor].active = YES;
    [self.addAndCancelIconImageView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor constant:-30].active = YES;
    
    [self.view bringSubviewToFront:self.addAndCancelIconImageView];
    
    
}

-(void)createWorkoutOnBoardView
{
    self.workoutOnBoardView = [[WorkoutOnBoardView alloc] init];
    
    [self.blurView addSubview:self.workoutOnBoardView];
    
    self.workoutOnBoardView.translatesAutoresizingMaskIntoConstraints = NO;
    
//    self.workoutOnBoardTopConstraint = [self.workoutOnBoardView.topAnchor constraintEqualToAnchor:self.view.topAnchor constant:-400];
//    self.workoutOnBoardBottomConstraint = [self.workoutOnBoardView.bottomAnchor constraintEqualToAnchor:self.view.topAnchor];
    
    [self.workoutOnBoardView.leftAnchor constraintEqualToAnchor:self.view.leftAnchor].active = YES;
    [self.workoutOnBoardView.rightAnchor constraintEqualToAnchor:self.view.rightAnchor].active = YES;
    [self.workoutOnBoardView.topAnchor constraintEqualToAnchor:self.view.topAnchor].active = YES;
    [self.workoutOnBoardView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor constant:-60].active = YES;
    
//    self.workoutOnBoardTopConstraint.active = YES;
//    self.workoutOnBoardBottomConstraint.active = YES;
    
    self.workoutOnBoardView.clipsToBounds = YES;
    
    self.workoutOnBoardView.alpha = 0;
    
    [self setAccessoryCircleSizes];
    
    
}

-(void)setAccessoryCircleSizes
{
    self.workoutOnBoardView.accessory1.accessoryOutlineCircleView.layer.cornerRadius = self.workoutOnBoardView.accessory1.accessoryOutlineCircleView.frame.size.height / 2;
    self.workoutOnBoardView.accessory2.accessoryOutlineCircleView.layer.cornerRadius = self.workoutOnBoardView.accessory1.accessoryOutlineCircleView.frame.size.height / 2;
    self.workoutOnBoardView.accessory3.accessoryOutlineCircleView.layer.cornerRadius = self.workoutOnBoardView.accessory1.accessoryOutlineCircleView.frame.size.height / 2;
    self.workoutOnBoardView.accessory4.accessoryOutlineCircleView.layer.cornerRadius = self.workoutOnBoardView.accessory1.accessoryOutlineCircleView.frame.size.height / 2;
    self.workoutOnBoardView.accessory5.accessoryOutlineCircleView.layer.cornerRadius = self.workoutOnBoardView.accessory1.accessoryOutlineCircleView.frame.size.height / 2;
    self.workoutOnBoardView.accessory6.accessoryOutlineCircleView.layer.cornerRadius = self.workoutOnBoardView.accessory1.accessoryOutlineCircleView.frame.size.height / 2;
}

-(void)bringWorkoutOnBoardScreenDown
{
    
    [UIView animateWithDuration:.1 animations:^{
        
        
        self.workoutOnBoardView.alpha = 1;
        
        [self.view layoutIfNeeded];
        
        
    } completion:^(BOOL finished) {
        
        self.view.userInteractionEnabled = YES;
        self.addAndCancelTapGestureRecognizer.enabled = YES;
        self.blurViewDisplayed = YES;
        
    }];
    
    
}

-(void)moveWorkoutOnBoardScreenUp
{
    
    [UIView animateWithDuration:.05 animations:^{
        
        
          self.workoutOnBoardView.alpha = 1;
        
        [self.view layoutIfNeeded];
        
        
    } completion:^(BOOL finished) {
        
        [self shrinkBlurViewBackToButton];
        
    }];
    
}

-(void)addTapGesture
{
    
    self.addAndCancelTapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(addOrCancelHit)];
    
    [self.addAndCancelIconImageView addGestureRecognizer:self.addAndCancelTapGestureRecognizer];
    
    
}

-(void)addOrCancelHit
{
    
    if (self.blurViewDisplayed)
    {
        [self moveWorkoutOnBoardScreenUp];
    }
    else
    {
         [self growBlurViewToFullScreen];
    }
    
}

-(void)growBlurViewToFullScreen
{
    
    self.view.userInteractionEnabled = NO;
    self.addAndCancelTapGestureRecognizer.enabled = NO;
    
    
    [UIView animateWithDuration:.2 animations:^{
        
        self.blurView.alpha = 1;
        
      
        self.addAndCancelIconImageView.transform = CGAffineTransformMakeRotation(M_PI/4);
 
        
        self.blurViewBottomConstraint.active = NO;
        self.blurViewTopConstraint.active = NO;
        self.blurViewLeftConstraint.active = NO;
        self.blurViewRightConstraint.active = NO;
        
        self.blurViewBottomConstraint = [self.blurView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor];
        self.blurViewTopConstraint = [self.blurView.topAnchor constraintEqualToAnchor:self.view.topAnchor ];
        self.blurViewLeftConstraint = [self.blurView.leftAnchor constraintEqualToAnchor:self.view.leftAnchor];
        self.blurViewRightConstraint = [self.blurView.rightAnchor constraintEqualToAnchor:self.view.rightAnchor];
        
        self.blurViewBottomConstraint.active = YES;
        self.blurViewTopConstraint.active = YES;
        self.blurViewLeftConstraint.active = YES;
        self.blurViewRightConstraint.active = YES;
        
        
        
        [self.view layoutIfNeeded];
        
        
    } completion:^(BOOL finished) {
        
        [self setAccessoryCircleSizes];
        
        [self bringWorkoutOnBoardScreenDown];
        self.blurView.layer.cornerRadius = 0;
    
      
        
    }];
}

-(void)shrinkBlurViewBackToButton
{
    
    self.view.userInteractionEnabled = NO;
    self.addAndCancelTapGestureRecognizer.enabled = NO;
    
    [UIView animateWithDuration:.2 animations:^{
        
        self.blurView.alpha = 1;
        
         self.addAndCancelIconImageView.transform = CGAffineTransformMakeRotation(0);
        
        self.blurViewBottomConstraint.active = NO;
        self.blurViewTopConstraint.active = NO;
        self.blurViewLeftConstraint.active = NO;
        self.blurViewRightConstraint.active = NO;
        
        CGFloat screenHeight = self.view.frame.size.height;
        CGFloat screenWidth = self.view.frame.size.width;
        
        self.blurViewBottomConstraint = [self.blurView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor constant:-20];
        self.blurViewTopConstraint = [self.blurView.topAnchor constraintEqualToAnchor:self.view.topAnchor constant:screenHeight - 70];
        self.blurViewLeftConstraint = [self.blurView.leftAnchor constraintEqualToAnchor:self.view.leftAnchor constant:screenWidth/2 - 25];
        self.blurViewRightConstraint = [self.blurView.rightAnchor constraintEqualToAnchor:self.view.rightAnchor constant:-(screenWidth/2 - 25)];
        
        self.blurViewBottomConstraint.active = YES;
        self.blurViewTopConstraint.active = YES;
        self.blurViewLeftConstraint.active = YES;
        self.blurViewRightConstraint.active = YES;
        
        self.blurView.layer.cornerRadius = 25;
        
        [self.view layoutIfNeeded];
        
        
    } completion:^(BOOL finished) {
        
        self.addAndCancelIconImageView.image = [UIImage imageNamed:@"add"];
        self.view.userInteractionEnabled = YES;
        self.addAndCancelTapGestureRecognizer.enabled = YES;
        self.blurViewDisplayed = NO;
        
    }];
    
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    NSLog(@"%lu is the number of workouts", self.workouts.count);
    
    return self.workouts.count;
   
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"creating the cell");
    
    NSLog(@"Workout name is %@",((Workout *)self.workouts[indexPath.row]).name);
    
    WorkoutSummaryScrollTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"summaryCell"];
    
    cell.workoutScrollSummaryView.workout = self.workouts[indexPath.row];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.backgroundColor = [UIColor clearColor];
    
    NSLog(@"Workout name is %@",((Workout *)self.workouts[indexPath.row]).name);
    
    NSLog(@"workout name is %@ from the other way",cell.workoutScrollSummaryView.workout.name);
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
        if (indexPath.row == self.selectedRow)
        {
            return 265;
        }
        else
        {
           return 85;
        }
        
        // Cell isn't selected so return single height
 
    
}

- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath
{
 
    NSLog(@"highlight row method getting called");
    
    return YES;

}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.selectedRow == indexPath.row)
    {
        self.selectedRow = -1;
        [tableView beginUpdates];
        [tableView endUpdates];
    }
    
    else
    {
        self.selectedRow = indexPath.row;
        [tableView beginUpdates];
        [tableView endUpdates];
    }
    
    
   
    
    NSLog(@"row %lu selected", indexPath.row);
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSLog(@"row %lu deselected", indexPath.row);
    
    
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
