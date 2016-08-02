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
#import "WorkoutTotalIndividualView.h"
#import "IntroView.h"
#import "StartButtonView.h"
#import "LogoView.h"
#import "CalendarMonth.h"

#define MIN_CALENDAR_HEIGHT 250;
#define MAX_CALENDAR_HEIGHT 400;


@interface HomeViewController () <UITableViewDataSource, UITableViewDelegate, WorkoutOnBoardDelegate, GenerateWorkoutViewDelegate,  WorkoutDetailViewDelegate, WorkoutTotalIndividualViewDelegate, StartButtonDelegate, LogoViewDelegate>


@property (weak, nonatomic) IBOutlet UITableView *workoutsTableView;
@property (strong, nonatomic) DataStore *dataStore;
@property (strong, nonatomic) NSArray *workouts;

@property (strong, nonatomic) UIView *blurView;

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
@property (nonatomic) BOOL logoViewDisplayed;

@property (nonatomic) NSInteger selectedRow;

@property (strong, nonatomic) WorkoutOnBoardView *workoutOnBoardView;
@property (strong, nonatomic) GenerateWorkoutView *generateWorkoutView;
@property (strong, nonatomic) WorkoutDetailView *workoutDetailView;
@property (strong, nonatomic) IntroView *introView;
@property (strong, nonatomic) StartButtonView *startButtonView;
@property (strong, nonatomic) LogoView *logoView;
@property (strong, nonatomic) WorkoutTotalsTopCellTableViewCell *topCell;

@property (strong, nonatomic) NSLayoutConstraint *onBoardViewLeftConstraint;
@property (strong, nonatomic) NSLayoutConstraint *generateWorkoutLeftConstraint;

@property (nonatomic) BOOL workoutCreated;

@property (nonatomic) BOOL hasLoadedBefore;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *calendarViewTopConstraint;
@property (weak, nonatomic) IBOutlet CalendarMonth *calendarMonth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *calendarMonthHeightConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableViewTopConstraint;
@property (nonatomic) BOOL calendarViewEnlarged;
@property (nonatomic) BOOL isUp;
@property (nonatomic) BOOL ignoreScrolls;
@property (nonatomic) CGFloat lastOffset;
@property (nonatomic) CGFloat smallHeight;
@property (nonatomic) CGFloat bigHeight;
@property (nonatomic) CGFloat offsetChange;
@property (nonatomic) CGFloat squareOffset;
@property (nonatomic) CGFloat bigSmallDiffererence;
@property (nonatomic) CGFloat testHeaderHeight;
@property (nonatomic) CGFloat headerHeight;
@property (nonatomic) BOOL scrollingUpLetGo;
@property (nonatomic) BOOL isMoving;


@end

@implementation HomeViewController

#pragma mark workout onboard user actions

-(void)startButtonTapped
{
    CGPoint home;
    home.x = 0;
    home.y = 0;
    
    if (self.blurViewDisplayed && !self.generateWorkoutViewDisplayed)
    {
        [self hideOnboardingViewsAnimated:YES];
    }
    else if (self.generateWorkoutViewDisplayed)
    {
        Workout *lastWorkout = [self.workouts firstObject];
        [self deleteWorkout:lastWorkout];
        [self hideOnboardingViewsAnimated:YES];
    }
    else
    {
        [self showOnboardingViewsAnimated:YES workoutSetupFirst:YES];
        [self.topCell.workoutTotalsTopCellView.scrollView setContentOffset:home];
    }
}

-(void)generateWorkoutTapped:(NSInteger)minutes accessories:(NSMutableArray *)accessories
{
    self.view.userInteractionEnabled = NO;
    self.startButtonView.alpha = 0;
    [self createNewWorkout:minutes accessories:accessories];
    self.workoutOnBoardView.alpha = 0;
    [self.logoView performGenerateWorkoutAnimation];
    
}

-(void)animationComplete
{
    self.view.userInteractionEnabled = YES;
    self.generateWorkoutView.alpha = 1;
    self.startButtonView.alpha = 1;
    self.workoutCreated = YES;
    self.generateWorkoutViewDisplayed = YES;
    self.accessoryAndTimeViewDisplayed = NO;
}

-(void)startWorkoutTapped
{
    [self performSegueWithIdentifier:@"segueToWorkout" sender:nil];
}

#pragma mark workout detail user actions

-(void)repeatWorkoutButtonTapped:(Workout *)workout
{
    [self shrinkWorkoutDetailView];
    [self replicateWorkout:workout];
    
    // this needs to actually make a workout with the exact same circuits, etc.
    
    [self showOnboardingViewsAnimated:YES workoutSetupFirst:NO];
    
}

-(void)deleteWorkoutButtonTapped:(Workout *)workout
{
    
    NSString *alertTitle = [NSString stringWithFormat:@"Delete %@", workout.name];
    
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:alertTitle
                                                                   message:@"Are you sure?"
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *deleteAction = [UIAlertAction actionWithTitle:@"Delete" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [self shrinkWorkoutDetailView];
        [self deleteWorkout:workout];
        
    }];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    [alert addAction:cancelAction];
    [alert addAction:deleteAction];
    
    [self presentViewController:alert animated:YES completion:nil];
}

-(void)leaveWorkoutDetailButtonTapped
{
    [self shrinkWorkoutDetailView];
}

#pragma mark view animations

-(void)showOnboardingViewsAnimated:(BOOL)animated workoutSetupFirst:(BOOL)setupFirst
{
    self.workoutOnBoardView.alpha = setupFirst;
    self.generateWorkoutView.alpha = !setupFirst;
    
    if (animated)
    {
        self.view.userInteractionEnabled = NO;
        
        [UIView animateWithDuration:0.15 animations:^{
            self.blurView.alpha = .9;
            self.startButtonView.buttonImage.transform = CGAffineTransformMakeRotation(-M_PI/4);
            self.startButtonView.outLineView.backgroundColor = [UIColor redColor];
        } completion:^(BOOL finished) {
            
            [UIView animateWithDuration:.15 animations:^{
                [self adjustOnboardingConstraintsShow:YES];
                [self.view layoutIfNeeded];
                
            } completion:^(BOOL finished) {
                self.view.userInteractionEnabled = YES;
            }];
        }];
    }
    else
    {
        self.blurView.alpha = 1;
        self.startButtonView.buttonImage.transform = CGAffineTransformMakeRotation(-M_PI/4);
        [self adjustOnboardingConstraintsShow:YES];
        self.startButtonView.outLineView.backgroundColor = [UIColor redColor];
        [UIView performWithoutAnimation:^{
            [self.view layoutIfNeeded];
        }];
    }
    
    self.blurViewDisplayed = YES;
    self.accessoryAndTimeViewDisplayed = setupFirst;
    self.generateWorkoutViewDisplayed = !setupFirst;
}

-(void)hideOnboardingViewsAnimated:(BOOL)animated
{
    if (animated)
    {
        self.view.userInteractionEnabled = NO;
        
        [UIView animateWithDuration:0.15 animations:^{
            [self adjustOnboardingConstraintsShow:NO];
            self.startButtonView.buttonImage.transform = CGAffineTransformMakeRotation(0);
            self.startButtonView.outLineView.backgroundColor = [UIColor colorWithRed:83.0/255.0 green:164.0/255.0 blue:255.0/255.0 alpha:1];
            [self.view layoutIfNeeded];
            
        } completion:^(BOOL finished) {
            
            [UIView animateWithDuration:.15 animations:^{
                self.blurView.alpha = 0;
            } completion:^(BOOL finished) {
                self.view.userInteractionEnabled = YES;
                [self.generateWorkoutView removeFromSuperview];
                [self createGenerateWorkoutView];
                [self.workoutOnBoardView resetView];
                
            }];
        }];
    }
    else
    {
        [self adjustOnboardingConstraintsShow:NO];
        self.blurView.alpha = 0;
        [self.generateWorkoutView removeFromSuperview];
        [self createGenerateWorkoutView];
        [self.workoutOnBoardView resetView];
        self.startButtonView.buttonImage.transform = CGAffineTransformMakeRotation(0);
        self.startButtonView.outLineView.backgroundColor = [UIColor colorWithRed:83.0/255.0 green:164.0/255.0 blue:255.0/255.0 alpha:1];
        
        [UIView performWithoutAnimation:^{
            [self.view layoutIfNeeded];
        }];
    }
    
    self.blurViewDisplayed = NO;
    self.accessoryAndTimeViewDisplayed = NO;
    self.generateWorkoutViewDisplayed = NO;
}

-(void)adjustOnboardingConstraintsShow:(BOOL)show
{
    self.onBoardViewLeftConstraint.active = NO;
    self.generateWorkoutLeftConstraint.active = NO;
    
    self.onBoardViewLeftConstraint = show ? [self.workoutOnBoardView.leftAnchor constraintEqualToAnchor:self.view.leftAnchor] : [self.workoutOnBoardView.leftAnchor constraintEqualToAnchor:self.view.rightAnchor];
    self.generateWorkoutLeftConstraint = show ? [self.generateWorkoutView.leftAnchor constraintEqualToAnchor:self.view.leftAnchor] : [self.generateWorkoutView.leftAnchor constraintEqualToAnchor:self.view.rightAnchor];
    
    self.onBoardViewLeftConstraint.active = YES;
    self.generateWorkoutLeftConstraint.active = YES;
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
        
        // nada
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


#pragma mark helper methods


-(void)createNewWorkout:(NSInteger)minutes accessories:(NSMutableArray *)accessories
{
    [self.dataStore.user generateNewWorkout];
    [self.dataStore fetchData];
    self.workouts = [self.dataStore.user orderedWorkoutsLIFO];
    
    Workout *newWorkout = [self.workouts firstObject];
    newWorkout.targetTimeInSeconds = minutes * 60;
    self.generateWorkoutView.workout = newWorkout;
}

-(void)deleteWorkout:(Workout *)workout
{
    [self.dataStore.user removeWorkoutsObject:workout];
    [self.dataStore fetchData];
    self.workouts = self.workouts = [self.dataStore.user orderedWorkoutsLIFO];
    [self.workoutsTableView reloadData];
    self.introView.alpha = self.workouts.count ? 0 : 1;
}

-(void)replicateWorkout:(Workout *)workout
{
    [self createNewWorkout:workout.targetTimeInSeconds/60 accessories:workout.availableAccessories];
}

#pragma mark tableView methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.workouts.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 800, 800)];
    headerView.backgroundColor = [UIColor clearColor];
    headerView.userInteractionEnabled = NO;
    return headerView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return self.headerHeight;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WorkoutSummaryScrollTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"summaryCell"];

    cell.workoutScrollSummaryView.workout = self.workouts[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor clearColor];
    return cell;

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.introView.alpha = self.workouts.count ? 0 : 1;
    return 110;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    [self setUpWorkoutDetailView];
    Workout *workoutChosen = self.workouts[indexPath.row];
    [self growWorkoutDetailViewWithWorkout:workoutChosen];

}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (self.squareOffset == 0 && [self.calendarMonth monthIsSquare])
    {
        self.squareOffset = -scrollView.contentOffset.y;
    }
    
    if (self.headerHeight == self.smallHeight)
    {
        self.calendarViewTopConstraint.constant = fmin(0, -scrollView.contentOffset.y);
    }
    
    if (!self.ignoreScrolls)
    {
        if (self.headerHeight + -scrollView.contentOffset.y > self.bigHeight)
        {
            self.calendarMonthHeightConstraint.constant = self.bigHeight;
        }
        else if (self.headerHeight +  -scrollView.contentOffset.y < self.smallHeight)
        {
            self.calendarMonthHeightConstraint.constant = self.smallHeight;
            
            if(self.headerHeight == self.bigHeight)
            {
                [self adjustHeaderHeightBig:NO];
            }
        }
        else
        {
            self.calendarMonthHeightConstraint.constant = self.headerHeight + -scrollView.contentOffset.y;
        }
    }
}

-(void)adjustHeaderHeightBig:(BOOL)big
{
    self.headerHeight = big ? self.bigHeight : self.smallHeight;
    [self.workoutsTableView reloadData];
    CGPoint offset;
    offset.x = 0;
    offset.y = big ? 0 : self.workoutsTableView.contentOffset.y - (self.bigHeight - self.smallHeight);
    
    [self.workoutsTableView setContentOffset:offset animated:big];
    
}



-(void)setSquareOffset:(CGFloat)squareOffset
{
    _squareOffset = squareOffset;
    self.bigHeight = self.smallHeight + 50 + squareOffset;
   
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    NSLog(@"beging");
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset
{
    
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
 
   if ((self.headerHeight == self.smallHeight && [self.calendarMonth monthIsSquare]) || (self.headerHeight == self.bigHeight && !decelerate))
   {
       [self adjustHeaderHeightBig:YES];
   }
    
    if (self.calendarViewTopConstraint.constant == 0)
    {
        self.scrollingUpLetGo = YES;
    }
    
}

-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    if ((self.headerHeight == self.smallHeight && [self.calendarMonth monthIsSquare]) || (self.headerHeight == self.bigHeight))
    {
        [self adjustHeaderHeightBig:YES];
    }
}




#pragma mark Set up all views

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
}

-(void)setUpIntroView
{
    self.introView = [[IntroView alloc] init];
    [self.view addSubview:self.introView];
    self.introView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.introView.leftAnchor constraintEqualToAnchor:self.view.leftAnchor].active = YES;
    [self.introView.rightAnchor constraintEqualToAnchor:self.view.rightAnchor].active = YES;
    [self.introView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor].active = YES;
    [self.introView.topAnchor constraintEqualToAnchor:self.view.topAnchor constant:320].active = YES;
    [self.view bringSubviewToFront:self.introView];
    self.introView.alpha = self.workouts.count ? 0 : 1;
}

-(void)generateStartButton
{
    self.startButtonView = [[StartButtonView alloc] init];
    [self.view addSubview:self.startButtonView];
    self.startButtonView.delegate = self;
    self.startButtonView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.startButtonView.heightAnchor constraintEqualToConstant:60].active = YES;
    [self.startButtonView.widthAnchor constraintEqualToConstant:60].active = YES;
    [self.startButtonView.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor].active = YES;
    [self.startButtonView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor constant:-10].active = YES;
}

-(void)generateBlurView
{
    self.blurView = [[UIView alloc] init];
    [self.view addSubview:self.blurView];
    self.blurView.translatesAutoresizingMaskIntoConstraints = NO;
    self.blurView.backgroundColor = [UIColor blackColor];
    
    [self.blurView.leftAnchor constraintEqualToAnchor:self.view.leftAnchor].active = YES;
    [self.blurView.rightAnchor constraintEqualToAnchor:self.view.rightAnchor].active = YES;
    [self.blurView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor].active = YES;
    [self.blurView.topAnchor constraintEqualToAnchor:self.view.topAnchor constant:70].active = YES;
    
    self.blurView.clipsToBounds = YES;
    self.blurView.alpha = 0;
    self.blurViewDisplayed = NO;
    self.accessoryAndTimeViewDisplayed = NO;
    self.generateWorkoutViewDisplayed = NO;
}

-(void)createWorkoutOnBoardView
{
    self.workoutOnBoardView = [[WorkoutOnBoardView alloc] init];
    self.workoutOnBoardView.delegate = self;
    self.workoutOnBoardView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:self.workoutOnBoardView];
    [self.workoutOnBoardView.widthAnchor constraintEqualToAnchor:self.view.widthAnchor].active = YES;
    [self.workoutOnBoardView.topAnchor constraintEqualToAnchor:self.view.topAnchor].active = YES;
    [self.workoutOnBoardView.heightAnchor constraintEqualToAnchor:self.view.heightAnchor constant:-60].active = YES;
    self.onBoardViewLeftConstraint = [self.workoutOnBoardView.leftAnchor constraintEqualToAnchor:self.view.rightAnchor];
    self.onBoardViewLeftConstraint.active = YES;
}

-(void)createGenerateWorkoutView
{
    self.generateWorkoutView = [[GenerateWorkoutView alloc] init];
    self.generateWorkoutView.delegate = self;
    [self.view addSubview:self.generateWorkoutView];
    self.generateWorkoutView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.generateWorkoutView.widthAnchor constraintEqualToAnchor:self.view.widthAnchor].active = YES;
    [self.generateWorkoutView.topAnchor constraintEqualToAnchor:self.view.topAnchor].active = YES;
    [self.generateWorkoutView.heightAnchor constraintEqualToAnchor:self.view.heightAnchor constant:-60].active = YES;
    self.generateWorkoutLeftConstraint = [self.generateWorkoutView.leftAnchor constraintEqualToAnchor:self.view.rightAnchor];
    self.generateWorkoutLeftConstraint.active = YES;
    self.generateWorkoutView.alpha = 0;
}

-(void)createLogoView
{
    self.logoView = [[LogoView alloc] init];
    self.logoView.delegate = self;
    [self.view addSubview:self.logoView];
    self.logoView.userInteractionEnabled = NO;
    self.logoView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.logoView.centerYAnchor constraintEqualToAnchor:self.view.centerYAnchor].active = YES;
    [self.logoView.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor].active = YES;
    [self.logoView.heightAnchor constraintEqualToAnchor:self.view.heightAnchor].active = YES;
    [self.logoView.widthAnchor constraintEqualToAnchor:self.view.widthAnchor].active = YES;
}


#pragma mark view lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.calendarMonth.monthAdditionToNow = 0;
    
    
    self.smallHeight = 250;
    self.headerHeight = self.smallHeight;
    self.bigHeight = 1000;

    
    self.dataStore = [DataStore sharedDataStore];
    [self.dataStore fetchData];
    
    self.workouts = [self.dataStore.user orderedWorkoutsLIFO];
    
    [self setUpMainTableView];
    [self setUpWorkoutDetailView];
    [self setUpIntroView];
    [self generateBlurView];
    [self createWorkoutOnBoardView];
    [self createGenerateWorkoutView];
    [self generateStartButton];
    [self createLogoView];
    [self.view layoutIfNeeded];
    
    self.hasLoadedBefore = YES;
}

-(void)viewWillAppear:(BOOL)animated
{
    self.lastOffset = 0;
    [self.workoutsTableView reloadData];
    self.introView.alpha = self.workouts.count ? 0 : 1;
    
    if (self.hasLoadedBefore)
    {
        [self hideOnboardingViewsAnimated:NO];
    }
}




@end
