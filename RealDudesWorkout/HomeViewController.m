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
#import "TableViewHeaderView.h"
#import "MonthScrollView.h"
#import "UIImage+BDC_Image.h"
#import "UIColor+BDC_Color.h"
#import "Last12Months.h"
#import "PreDownloadTableViewCell.h"
#import "AfterFirstWorkoutCell.h"


#define MIN_CALENDAR_HEIGHT 250;
#define MAX_CALENDAR_HEIGHT 400;


@interface HomeViewController () <UITableViewDataSource, UITableViewDelegate, WorkoutOnBoardDelegate, GenerateWorkoutViewDelegate,  WorkoutDetailViewDelegate, WorkoutTotalIndividualViewDelegate, StartButtonDelegate, LogoViewDelegate, MonthScrollViewDelegate>


@property (weak, nonatomic) IBOutlet UITableView *workoutsTableView;
@property (strong, nonatomic) DataStore *dataStore;
@property (strong, nonatomic) NSArray *workouts;
@property (weak, nonatomic) IBOutlet UIView *calendarBlockView;
@property (weak, nonatomic) IBOutlet MonthScrollView *monthScrollView;

@property (strong, nonatomic) NSLayoutConstraint *blurViewBottomConstraint;
@property (strong, nonatomic) NSLayoutConstraint *blurViewTopConstraint;
@property (strong, nonatomic) NSLayoutConstraint *blurViewLeftConstraint;
@property (strong, nonatomic) NSLayoutConstraint *blurViewRightConstraint;

@property (strong, nonatomic) NSLayoutConstraint *workoutDetailViewHeightConstraint;

@property (strong, nonatomic) UIImageView *addAndCancelIconImageView;

@property (strong, nonatomic) UITapGestureRecognizer *addAndCancelTapGestureRecognizer;

@property (nonatomic) BOOL onboardContainerViewDisplayed;
@property (nonatomic) BOOL accessoryAndTimeViewDisplayed;
@property (nonatomic) BOOL generateWorkoutViewDisplayed;
@property (nonatomic) BOOL logoViewDisplayed;

@property (nonatomic) NSInteger selectedRow;

@property (weak, nonatomic) IBOutlet UIView *headerView;
@property (strong, nonatomic) UIView *workoutOnboardContainerView;
@property (strong, nonatomic) WorkoutOnBoardView *workoutOnBoardView;
@property (strong, nonatomic) GenerateWorkoutView *generateWorkoutView;
@property (strong, nonatomic) WorkoutDetailView *workoutDetailView;
@property (strong, nonatomic) IntroView *introView;
@property (strong, nonatomic) StartButtonView *startButtonView;
@property (strong, nonatomic) LogoView *logoView;
@property (strong, nonatomic) WorkoutTotalsTopCellTableViewCell *topCell;
@property (strong, nonatomic) UIVisualEffectView *blurCoverView;
@property (weak, nonatomic) IBOutlet UIView *mainContainerView;
@property (weak, nonatomic) IBOutlet Last12Months *last12MonthsView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *mainContainerViewRightConstraint;
@property (strong, nonatomic) NSLayoutConstraint *onboardContainerViewLeftConstraint;

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
@property (nonatomic) CGFloat screenWidth;
@property (nonatomic) CGFloat calendarMonthHeight;


@end

@implementation HomeViewController

#pragma mark workout onboard user actions



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
    
    //[self showOnboardingViewsAnimated:YES workoutSetupFirst:NO];
    
}
-(void)startButtonTapped
{
    if (self.generateWorkoutViewDisplayed)
    {
        Workout *lastWorkout = [self.workouts firstObject];
        [self deleteWorkout:lastWorkout];
    }
    
    [self adjustViewsToOnboarding:!self.onboardContainerViewDisplayed animate:YES];
}

-(void)generateWorkoutTapped:(NSInteger)minutes accessories:(NSMutableArray *)accessories
{
    self.view.userInteractionEnabled = NO;
    [self createNewWorkout:minutes accessories:accessories];
    self.workoutOnBoardView.alpha = 0;
    //[self.logoView performGenerateWorkoutAnimation];
    [self animationComplete];
    
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

-(void)adjustViewsToOnboarding:(BOOL)onboarding animate:(BOOL)animate
{
   
    self.blurCoverView.alpha = 1;
    [self.workoutOnBoardView resetView];
    [self.generateWorkoutView resetView];
    
    self.onboardContainerViewDisplayed = onboarding;
    self.accessoryAndTimeViewDisplayed = onboarding;
    self.generateWorkoutViewDisplayed = NO;
    
    self.onboardContainerViewLeftConstraint.active = NO;
    self.onboardContainerViewLeftConstraint = onboarding ? [self.workoutOnboardContainerView.leftAnchor constraintEqualToAnchor:self.view.leftAnchor] : [self.workoutOnboardContainerView.leftAnchor constraintEqualToAnchor:self.view.rightAnchor];
    self.onboardContainerViewLeftConstraint.active = YES;
    
    self.view.userInteractionEnabled = NO;
    
    CGFloat duration = animate ? .17 : 0;
    
    [UIView animateWithDuration:duration animations:^{
        [self.view layoutIfNeeded];
        [self.startButtonView adjustStartButtonToHome:!onboarding];
    } completion:^(BOOL finished) {
        
        CGFloat animateOutDuration = (onboarding || !animate) ? 0 : .2;
        
        [UIView animateWithDuration:animateOutDuration animations:^{
            self.blurCoverView.alpha = onboarding ? 1 : 0;
        } completion:^(BOOL finished) {
            self.view.userInteractionEnabled = YES;
            self.workoutOnBoardView.alpha = 1;
            self.generateWorkoutView.alpha = 0;
        }];
    }];
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
        [self.last12MonthsView updateViewForWorkouts];
        
        
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


-(void)growWorkoutDetailViewWithWorkout:(Workout *)workout
{
    self.workoutDetailView.workout = workout;
    [self.view bringSubviewToFront:self.workoutDetailView];
    
    [UIView animateWithDuration:.15 animations:^{
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
    [self.calendarMonth updateCalendarMonth];
    self.introView.alpha = self.workouts.count ? 0 : 1;
}

-(void)replicateWorkout:(Workout *)workout
{
    [self createNewWorkout:workout.targetTimeInSeconds/60 accessories:workout.availableAccessories];
}

#pragma mark tableView and scroll view methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return 0;
        case 1:
            if (self.workouts.count == 0)
            {
                return 1;
            }
            else if (self.workouts.count == 1 && self.calendarMonth.monthAdditionToNow == 0)
            {
                return 2;
            }
            else
            {
                return self.workouts.count;
            }
        default:
            return 0;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    if (section == 0)
    {
        UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 800, 800)];
        headerView.backgroundColor = [UIColor clearColor];
        headerView.userInteractionEnabled = NO;
        return headerView;
    }
    else
    {
        TableViewHeaderView *headerView = [[TableViewHeaderView alloc] init];
        return headerView;
    }
  
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return section == 0 ? self.calendarMonthHeight : 35;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.workouts.count == 0)
    {
        [tableView registerNib:[UINib nibWithNibName:@"TableViewCells" bundle:nil] forCellReuseIdentifier:@"preDownloadCell"];
        PreDownloadTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"preDownloadCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.monthAdditionToNow = self.calendarMonth.monthAdditionToNow;
        return cell;
    }
    else if (self.workouts.count == 1 && self.calendarMonth.monthAdditionToNow == 0)
    {
        if (indexPath.row == 0)
        {
            WorkoutSummaryScrollTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"summaryCell"];
            cell.workoutScrollSummaryView.workout = self.workouts[indexPath.row];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.backgroundColor = [UIColor clearColor];
            return cell;
        }
        else
        {
            [tableView registerNib:[UINib nibWithNibName:@"AfterFirstWorkoutCell" bundle:nil] forCellReuseIdentifier:@"afterFirstWorkoutCell"];
            AfterFirstWorkoutCell *cell = [tableView dequeueReusableCellWithIdentifier:@"afterFirstWorkoutCell"];
            return cell;
            
        }
    }
    else
    {
         WorkoutSummaryScrollTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"summaryCell"];
        cell.workoutScrollSummaryView.workout = self.workouts[indexPath.row];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor clearColor];
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.introView.alpha = self.workouts.count ? 0 : 1;
    return 110;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.workouts.count > 0 && !(self.workouts.count == 0 && self.calendarMonth.monthAdditionToNow == 0 && indexPath.row == 1))
    {
        [self setUpWorkoutDetailView];
        Workout *workoutChosen = self.workouts[indexPath.row];
        [self growWorkoutDetailViewWithWorkout:workoutChosen];
    }
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    if (scrollView.contentOffset.y <= 0)
    {
        self.calendarBlockView.alpha = 0;
        [self adjustViewsCalendarInFront:YES];
    }
    else
    {
        [self adjustViewsCalendarInFront:NO];
        
        if ((scrollView.contentOffset.y / 41.43 * .1 + .3) < 0)
        {
            self.calendarBlockView.alpha = 0;
        }
        else if ((scrollView.contentOffset.y / 41.43 * .1 + .3)  > 1)
        {
            self.calendarBlockView.alpha = 1;
        }
        else
        {
            self.calendarBlockView.alpha = scrollView.contentOffset.y / 41.43 * .1 + .3;
        }
    }
}


#pragma mark month scroll view delegate method

-(void)newIndexChosen:(NSUInteger)index
{
    self.calendarBlockView.alpha = 0;
    
    if (index == 13)
    {
        self.calendarMonthHeight = self.view.frame.size.height;
        self.calendarMonth.alpha = 0;
        [self.workoutsTableView reloadData];
        self.last12MonthsView.alpha = 1;
        [self.last12MonthsView updateViewToOn:YES animate:YES];
        
    }
    else
    {
        self.last12MonthsView.alpha = 0;
        [self.last12MonthsView updateViewToOn:NO animate:NO];
        self.calendarMonth.alpha = 1;
        self.calendarMonth.monthAdditionToNow = index - 12;
        self.calendarMonthHeight = (self.screenWidth - 20)/7 *[self.calendarMonth weeksToShow] + 59;
        self.calendarMonthHeightConstraint.constant = self.calendarMonthHeight;
        self.workouts = [self.calendarMonth workoutsInThisMonth];
        [self.workoutsTableView reloadData];
        [self adjustViewsCalendarInFront:YES];
    }
}

-(void)resetCalendarComponents
{
    self.calendarMonth.monthAdditionToNow = 0;
    self.calendarMonthHeight = (self.screenWidth - 20)/7 *[self.calendarMonth weeksToShow] + 59;
    self.calendarMonthHeightConstraint.constant = self.calendarMonthHeight;
    self.workouts = [self.calendarMonth workoutsInThisMonth];
    [self.calendarMonth updateCalendarMonth];
    [self.workoutsTableView reloadData];
    CGPoint home;
    home.x = 0;
    home.y = 0;
    [self.workoutsTableView setContentOffset:home animated:NO];
    [self adjustViewsCalendarInFront:YES];
    [self.monthScrollView moveScrollViewToIndex:12 animate:NO];
    self.calendarBlockView.alpha = 0;
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

-(void)generateBlurCoverView
{
    self.blurCoverView = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleDark]];
    [self.view addSubview:self.blurCoverView];
    self.blurCoverView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:.5];
    self.blurCoverView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.blurCoverView.leftAnchor constraintEqualToAnchor:self.view.leftAnchor].active = YES;
    [self.blurCoverView.rightAnchor constraintEqualToAnchor:self.view.rightAnchor].active = YES;
    [self.blurCoverView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor].active = YES;
    [self.blurCoverView.topAnchor constraintEqualToAnchor:self.view.topAnchor].active = YES;
    self.blurCoverView.alpha = 0;
}

-(void)generateOnboardingContainerView
{
    self.workoutOnboardContainerView = [[UIView alloc] init];
    [self.view addSubview:self.workoutOnboardContainerView];
    self.workoutOnboardContainerView.translatesAutoresizingMaskIntoConstraints = NO;
    self.workoutOnboardContainerView.backgroundColor = [UIColor clearColor];
    
    self.onboardContainerViewLeftConstraint = [self.workoutOnboardContainerView.leftAnchor constraintEqualToAnchor:self.view.rightAnchor];
    self.onboardContainerViewLeftConstraint.active = YES;
    [self.workoutOnboardContainerView.widthAnchor constraintEqualToAnchor:self.view.widthAnchor].active = YES;
    [self.workoutOnboardContainerView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor].active = YES;
    [self.workoutOnboardContainerView.topAnchor constraintEqualToAnchor:self.view.topAnchor constant:64].active = YES;
    
    self.workoutOnboardContainerView.clipsToBounds = YES;
    self.onboardContainerViewDisplayed = NO;
    self.accessoryAndTimeViewDisplayed = NO;
    self.generateWorkoutViewDisplayed = NO;
}

-(void)createWorkoutOnBoardView
{
    self.workoutOnBoardView = [[WorkoutOnBoardView alloc] init];
    self.workoutOnBoardView.delegate = self;
    self.workoutOnBoardView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:self.workoutOnBoardView];

    [self.workoutOnBoardView.leftAnchor constraintEqualToAnchor:self.workoutOnboardContainerView.leftAnchor].active = YES;
    [self.workoutOnBoardView.rightAnchor constraintEqualToAnchor:self.workoutOnboardContainerView.rightAnchor].active = YES;
    [self.workoutOnBoardView.topAnchor constraintEqualToAnchor:self.workoutOnboardContainerView.topAnchor].active = YES;
    [self.workoutOnBoardView.bottomAnchor constraintEqualToAnchor:self.workoutOnboardContainerView.bottomAnchor constant:-51].active = YES;
}

-(void)createGenerateWorkoutView
{
    self.generateWorkoutView = [[GenerateWorkoutView alloc] init];
    self.generateWorkoutView.delegate = self;
    [self.view addSubview:self.generateWorkoutView];
    self.generateWorkoutView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.generateWorkoutView.leftAnchor constraintEqualToAnchor:self.workoutOnboardContainerView.leftAnchor].active = YES;
    [self.generateWorkoutView.rightAnchor constraintEqualToAnchor:self.workoutOnboardContainerView.rightAnchor].active = YES;
    [self.generateWorkoutView.topAnchor constraintEqualToAnchor:self.workoutOnboardContainerView.topAnchor].active = YES;
    [self.generateWorkoutView.bottomAnchor constraintEqualToAnchor:self.workoutOnboardContainerView.bottomAnchor constant:-51].active = YES;
    
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

-(void)createStartButtonView
{
    self.startButtonView = [[StartButtonView alloc] init];
    self.startButtonView.delegate = self;
    [self.view addSubview:self.startButtonView];
    self.startButtonView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.startButtonView.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor].active = YES;
    [self.startButtonView.widthAnchor constraintEqualToConstant:32].active = YES;
    [self.startButtonView.heightAnchor constraintEqualToAnchor:self.startButtonView.widthAnchor].active = YES;
    [self.startButtonView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor constant:-15].active = YES;
    [self.view bringSubviewToFront:self.startButtonView];
}

-(void)adjustViewsCalendarInFront:(BOOL)front
{
    [self.view bringSubviewToFront:self.calendarMonth];
    [self.view bringSubviewToFront:self.calendarBlockView];
    [self.view bringSubviewToFront:self.workoutsTableView];
    if (front)
    {
        [self.view bringSubviewToFront:self.calendarMonth];
        [self.view bringSubviewToFront:self.calendarBlockView];
    }
    [self.view bringSubviewToFront:self.last12MonthsView];
    [self.view bringSubviewToFront:self.monthScrollView];
    [self.view bringSubviewToFront:self.headerView];
    [self.view bringSubviewToFront:self.logoView];
    [self.view bringSubviewToFront:self.blurCoverView];
    [self.view bringSubviewToFront:self.workoutOnboardContainerView];
    [self.view bringSubviewToFront:self.workoutOnBoardView];
    [self.view bringSubviewToFront:self.generateWorkoutView];
    [self.view bringSubviewToFront:self.startButtonView];
    [self.view bringSubviewToFront:self.workoutDetailView];
}


#pragma mark view lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.dataStore = [DataStore sharedDataStore];
    [self.dataStore fetchData];
    self.workouts = [self.dataStore.user orderedWorkoutsLIFO];
    [self.last12MonthsView generateExercises];
    
    [self setUpMainTableView];
    [self setUpWorkoutDetailView];
    [self generateBlurCoverView];
    [self generateOnboardingContainerView];
    [self createWorkoutOnBoardView];
    [self createGenerateWorkoutView];
    [self createLogoView];
    self.monthScrollView.delegate = self;
    [self createStartButtonView];
  
    self.screenWidth = self.view.frame.size.width;
    [self resetCalendarComponents];

    self.hasLoadedBefore = YES;
}

-(void)setScreenWidth:(CGFloat)screenWidth
{
    _screenWidth = screenWidth;
    self.monthScrollView.scrollViewWidth = screenWidth / 3;
    
}

-(void)viewWillAppear:(BOOL)animated 
{
   
    [self resetCalendarComponents];
    [self.last12MonthsView updateViewForWorkouts];
    
    self.introView.alpha = self.workouts.count ? 0 : 1;
    
    if (self.hasLoadedBefore)
    {
        [self adjustViewsToOnboarding:NO animate:NO];
    }
}

-(void)viewDidAppear:(BOOL)animated
{
    [self resetCalendarComponents];
}




@end
