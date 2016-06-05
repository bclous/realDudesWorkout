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
#import "WorkoutSummaryScrollTableViewCell.h"
#import "StartWorkoutButtonView.h"
#import "WorkoutOnBoardView.h"
#import "GenerateWorkoutView.h"
#import "GenerateWorkoutExcerciseView.h"
#import "WorkoutTotalsTopCellTableViewCell.h"
#import "WorkoutDetailView.h"


@interface HomeViewController () <UITableViewDataSource, UITableViewDelegate, WorkoutOnBoardDelegate, GenerateWorkoutViewDelegate, WorkoutScrollSummaryCellDelegate, WorkoutDetailViewDelegate>

@property (weak, nonatomic) IBOutlet TotalsFrontPageCellView *totalsView;
@property (weak, nonatomic) IBOutlet UITableView *workoutsTableView;
@property (strong, nonatomic) DataStore *dataStore;
@property (strong, nonatomic) NSArray *workouts;

@property (strong, nonatomic) UIVisualEffectView *blurView;

@property (strong, nonatomic) NSLayoutConstraint *blurViewBottomConstraint;
@property (strong, nonatomic) NSLayoutConstraint *blurViewTopConstraint;
@property (strong, nonatomic) NSLayoutConstraint *blurViewLeftConstraint;
@property (strong, nonatomic) NSLayoutConstraint *blurViewRightConstraint;

@property (strong, nonatomic) NSLayoutConstraint *workoutDetailViewHeightConstraint;

@property (strong, nonatomic) UIImageView *addAndCancelIconImageView;

@property (strong, nonatomic) UITapGestureRecognizer *addAndCancelTapGestureRecognizer;

@property (nonatomic) BOOL blurViewDisplayed;
@property (nonatomic) BOOL accessoryAndTimeViewDisplayed;
@property (nonatomic) BOOL generateWorkoutViewDisplayed;

@property (nonatomic) NSInteger selectedRow;

@property (strong, nonatomic) WorkoutOnBoardView *workoutOnBoardView;
@property (strong, nonatomic) GenerateWorkoutView *generateWorkoutView;
@property (strong, nonatomic) WorkoutDetailView *workoutDetailView;

@property (nonatomic) BOOL workoutCreated;

@property (nonatomic) BOOL hasLoadedBefore;



@end

@implementation HomeViewController

- (void)viewDidLoad
{
    
    [super viewDidLoad];
    
    self.dataStore = [DataStore sharedDataStore];
    
    [self.dataStore fetchData];
    
    self.workouts = [self.dataStore.user orderedWorkoutsLIFO];
    
    [self setUpMainTableView];
    [self setUpStartButtonView];
    [self setUpWorkoutDetailView];
    
    //Workout *lastWorkout = [self.workouts firstObject];
    
    self.hasLoadedBefore = YES;
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [self.workoutsTableView reloadData];
    
    
    if (self.hasLoadedBefore)
    {
        [self resetOnBoardingViews];
        [self shrinkBlurViewBackToButton];
    }
    
}

-(void)setUpMainTableView
{
    
    self.workoutsTableView.dataSource = self;
    self.workoutsTableView.delegate = self;
    
    self.selectedRow = -1;
    
    self.workoutsTableView.separatorStyle = UITableViewCellSeparatorStyleNone;

}

-(void)setUpWorkoutDetailView
{
    
    self.workoutDetailView = [[WorkoutDetailView alloc] init];
    
    [self.view addSubview:self.workoutDetailView];
    
    self.workoutDetailView.delegate = self;
    
    self.workoutDetailView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.workoutDetailView.widthAnchor constraintEqualToAnchor:self.view.widthAnchor].active = YES;
    [self.workoutDetailView.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor].active = YES;
    [self.workoutDetailView.centerYAnchor constraintEqualToAnchor:self.view.centerYAnchor].active = YES;
    
    self.workoutDetailViewHeightConstraint = [self.workoutDetailView.heightAnchor constraintEqualToAnchor:self.view.heightAnchor];
    
    self.workoutDetailViewHeightConstraint.active = YES;
    
    self.workoutDetailView.alpha = 0;
    
    self.workoutDetailView.clipsToBounds = YES;
    
    [self.view layoutIfNeeded];
    
}

-(void)growWorkoutDetailViewWithWorkout:(Workout *)workout
{
    
     self.workoutDetailView.workout = workout;
    
    [self.view bringSubviewToFront:self.workoutDetailView];
    
    
    
    [UIView animateWithDuration:.2 animations:^{
        
        
        self.workoutDetailView.alpha = 1;
        
        self.workoutDetailViewHeightConstraint.active = NO;
        
        self.workoutDetailViewHeightConstraint = [self.workoutDetailView.heightAnchor constraintEqualToAnchor:self.view.heightAnchor];
        
        self.workoutDetailViewHeightConstraint.active = YES;
        
        [self.view layoutIfNeeded];
        
        
    } completion:^(BOOL finished) {
        
        
        
    }];
    
}

-(void)shrinkWorkoutDetailView
{
    
    [UIView animateWithDuration:.1 animations:^{
        
        
        [self.view layoutIfNeeded];
        
        self.workoutDetailView.alpha = 0;
        
        
    } completion:^(BOOL finished) {
        
        
        
    }];
    
    
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
    self.blurViewTopConstraint = [self.blurView.topAnchor constraintEqualToAnchor:self.view.topAnchor constant:screenHeight - 60];
    self.blurViewLeftConstraint = [self.blurView.leftAnchor constraintEqualToAnchor:self.view.leftAnchor constant:screenWidth/2 - 20];
    self.blurViewRightConstraint = [self.blurView.rightAnchor constraintEqualToAnchor:self.view.rightAnchor constant:-(screenWidth/2 - 20)];
    
    self.blurViewBottomConstraint.active = YES;
    self.blurViewTopConstraint.active = YES;
    self.blurViewLeftConstraint.active = YES;
    self.blurViewRightConstraint.active = YES;
    
    self.blurView.effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    
    self.blurView.layer.cornerRadius = 20;
    self.blurView.clipsToBounds = YES;
    self.blurView.alpha = 1;
    
    self.blurViewDisplayed = NO;
    self.accessoryAndTimeViewDisplayed = NO;
    self.generateWorkoutViewDisplayed = NO;
    
    
    [self addButtonToBlurView];
    
    [self addTapGesture];
    
    [self createWorkoutOnBoardView];
    
    [self createGenerateWorkoutView];
    
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
    [self.addAndCancelIconImageView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor constant:-25].active = YES;
    
    [self.view bringSubviewToFront:self.addAndCancelIconImageView];
    
    
}

-(void)createWorkoutOnBoardView
{
    self.workoutOnBoardView = [[WorkoutOnBoardView alloc] init];
    
    self.workoutOnBoardView.delegate = self;
    
    [self.blurView addSubview:self.workoutOnBoardView];
    
    self.workoutOnBoardView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.workoutOnBoardView.leftAnchor constraintEqualToAnchor:self.view.leftAnchor].active = YES;
    [self.workoutOnBoardView.rightAnchor constraintEqualToAnchor:self.view.rightAnchor].active = YES;
    [self.workoutOnBoardView.topAnchor constraintEqualToAnchor:self.view.topAnchor].active = YES;
    [self.workoutOnBoardView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor constant:-60].active = YES;
    
    
    self.workoutOnBoardView.clipsToBounds = YES;
    
    self.workoutOnBoardView.alpha = 0;
    
    
}

-(void)createGenerateWorkoutView
{
    
    self.generateWorkoutView = [[GenerateWorkoutView alloc] init];
    
    self.generateWorkoutView.delegate = self;
    
    [self.blurView addSubview:self.generateWorkoutView];
    
    self.generateWorkoutView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.generateWorkoutView.leftAnchor constraintEqualToAnchor:self.view.leftAnchor].active = YES;
    [self.generateWorkoutView.rightAnchor constraintEqualToAnchor:self.view.rightAnchor].active = YES;
    [self.generateWorkoutView.topAnchor constraintEqualToAnchor:self.view.topAnchor].active = YES;
    [self.generateWorkoutView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor constant:-60].active = YES;
    
    self.generateWorkoutView.clipsToBounds = YES;
    
    self.generateWorkoutView.alpha = 0;
    
}



-(void)makeWorkoutOnBoardScreenAppear
{
    
    [UIView animateWithDuration:.1 animations:^{
        
        
        self.workoutOnBoardView.alpha = 1;
        
        [self.view layoutIfNeeded];
        
        
    } completion:^(BOOL finished) {
        
        self.view.userInteractionEnabled = YES;
        self.addAndCancelTapGestureRecognizer.enabled = YES;
        self.blurViewDisplayed = YES;
        self.accessoryAndTimeViewDisplayed = YES;
        
    }];
    
    
}

-(void)makeWorkoutOnBoardScreenDisappear
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
    NSLog(@"this is getting called");
    
    if (self.blurViewDisplayed && !self.generateWorkoutViewDisplayed)
    {
        
        [self shrinkBlurViewBackToButton];
        
    }
    
    else if (self.generateWorkoutViewDisplayed)
    {
        Workout *lastWorkout = [self.workouts firstObject];
        
        [self deleteWorkout:lastWorkout];
        
        [self shrinkBlurViewBackToButton];
    }
    
        else
    {
         [self growBlurViewToFullScreen];
    }
    
}


-(void)resetOnBoardingViews
{
    
    NSLog(@"reset on boarding is getting called");
    
    if (self.accessoryAndTimeViewDisplayed)
    {
        
        [self.workoutOnBoardView removeFromSuperview];
        self.accessoryAndTimeViewDisplayed = NO;
        
        [self createWorkoutOnBoardView];
        
        
    }
    
    else if (self.generateWorkoutViewDisplayed)
    {
        [self.generateWorkoutView removeFromSuperview];
        self.generateWorkoutViewDisplayed = NO;
        
        
        [self createWorkoutOnBoardView];
        [self createGenerateWorkoutView];
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
        
        
        [self makeWorkoutOnBoardScreenAppear];
        self.blurView.layer.cornerRadius = 0;
    
        
    }];
}

-(void)growOnBoardingScreenWhenRepeatWorkoutTapped
{
    
    NSLog(@"grow onboarding is getting called");
    
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
        
        self.view.userInteractionEnabled = YES;
        self.addAndCancelTapGestureRecognizer.enabled = YES;
        self.blurViewDisplayed = YES;
        
        self.generateWorkoutView.alpha = 1;
        
        self.workoutCreated = YES;
        self.generateWorkoutViewDisplayed = YES;
        self.accessoryAndTimeViewDisplayed = NO;

        self.blurView.layer.cornerRadius = 0;

        
        
    }];

    
    
    
}

-(void)shrinkBlurViewBackToButton
{
    NSLog(@"shrink blur view getting called");
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
        self.blurViewTopConstraint = [self.blurView.topAnchor constraintEqualToAnchor:self.view.topAnchor constant:screenHeight - 60];
        self.blurViewLeftConstraint = [self.blurView.leftAnchor constraintEqualToAnchor:self.view.leftAnchor constant:screenWidth/2 - 20];
        self.blurViewRightConstraint = [self.blurView.rightAnchor constraintEqualToAnchor:self.view.rightAnchor constant:-(screenWidth/2 - 20)];
        
        self.blurViewBottomConstraint.active = YES;
        self.blurViewTopConstraint.active = YES;
        self.blurViewLeftConstraint.active = YES;
        self.blurViewRightConstraint.active = YES;
        
        self.blurView.layer.cornerRadius = 20;
        
        [self.view layoutIfNeeded];
        
        
    } completion:^(BOOL finished) {
        
        self.addAndCancelIconImageView.image = [UIImage imageNamed:@"add"];
        self.view.userInteractionEnabled = YES;
        self.addAndCancelTapGestureRecognizer.enabled = YES;
        self.blurViewDisplayed = NO;
      
        [self resetOnBoardingViews];
        
    }];
    
}

-(void)generateWorkoutTapped:(NSInteger)minutes accessories:(NSMutableArray *)accessories
{
    
    [self createNewWorkout:minutes accessories:accessories];
    
    [self.workoutOnBoardView removeFromSuperview];
    
    self.generateWorkoutView.alpha = 1;
    
    self.workoutCreated = YES;
    self.generateWorkoutViewDisplayed = YES;
    self.accessoryAndTimeViewDisplayed = NO;
    

}

-(void)createNewWorkout:(NSInteger)minutes accessories:(NSMutableArray *)accessories
{
    
    NSLog(@"in create new workout, minutes is %lu", minutes);
    
    [self.dataStore.user generateNewWorkout];
    
    [self.dataStore fetchData];
    
    self.workouts = [self.dataStore.user orderedWorkoutsLIFO];
    
    Workout *newWorkout = [self.workouts firstObject];
    
    newWorkout.targetTimeInSeconds = minutes * 60;
    
    NSLog(@"still in create new workout, target time in seconds = %lu", newWorkout.targetTimeInSeconds);
    
    self.generateWorkoutView.workout = newWorkout;

    
    
}

-(void)startWorkoutTapped
{
   
    [self performSegueWithIdentifier:@"segueToWorkout" sender:nil];
    
}




#pragma tableView methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if (section == 0)
    {
        return 1;
    }
    
    else
    {
        return self.workouts.count;
    }
    
   
   
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    if (indexPath.section == 0)
    {
        WorkoutTotalsTopCellTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"topCell"];
        
        return cell;
    }
    
    else
    {
        WorkoutSummaryScrollTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"summaryCell"];
        
        cell.workoutScrollSummaryView.workout = self.workouts[indexPath.row];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.backgroundColor = [UIColor clearColor];
        
        [cell.workoutScrollSummaryView setStackViewWidth];
        
        cell.workoutScrollSummaryView.delegate = self;
        
        return cell;
    }
    
  

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 0)
    {
        return 160;
    }
    else
    {
        return 110;
    }
 
    
}


- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
 
    
    if (!(indexPath.section == 0))
    {
        
        [self setUpWorkoutDetailView];
        
        Workout *workoutChosen = self.workouts[indexPath.row];
        
        [self growWorkoutDetailViewWithWorkout:workoutChosen];
        
    }
    

}


-(void)deleteWorkout:(Workout *)workout
{
    
    [self.dataStore.user removeWorkoutsObject:workout];
    
    [self.dataStore fetchData];
    
    self.workouts = self.workouts = [self.dataStore.user orderedWorkoutsLIFO];
    
    [self.workoutsTableView reloadData];
    
}

-(void)replicateWorkout:(Workout *)workout
{
    NSLog(@"in replicate workout, target time is %lu", workout.targetTimeInSeconds);
    
    [self createNewWorkout:workout.targetTimeInSeconds/60 accessories:workout.availableAccessories];
    
}



#pragma cell delegate methods


-(void)repeatWorkoutButtonTapped:(Workout *)workout
{
    
    NSLog(@"in repeat workout button tapped, workout time is %lu", workout.targetTimeInSeconds);

    [self shrinkWorkoutDetailView];
    
    [self replicateWorkout:workout];
    
        // this needs to actually make a workout with the exact same circuits, etc.
    
    [self growOnBoardingScreenWhenRepeatWorkoutTapped];
    

}

-(void)deleteWorkoutButtonTapped:(Workout *)workout
{
   
    NSString *alertTitle = [NSString stringWithFormat:@"Delete %@", workout.name];
    
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:alertTitle
                                                                   message:@"Are you sure?"
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *deleteAction = [UIAlertAction actionWithTitle:@"Delete" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        NSLog(@"delete hit");
        
        [self shrinkWorkoutDetailView];
        
        [self deleteWorkout:workout];

        
        
    }];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        NSLog(@"cancel hit");
        
        
    }];
    
    [alert addAction:cancelAction];
    [alert addAction:deleteAction];
   
    
    [self presentViewController:alert animated:YES completion:nil];
    

    
}


-(void)leaveWorkoutDetailButtonTapped
{
    
    [self shrinkWorkoutDetailView];
    
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
