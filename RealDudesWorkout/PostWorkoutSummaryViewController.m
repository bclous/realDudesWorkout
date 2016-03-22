//
//  PostWorkoutSummaryViewController.m
//  RealDudesWorkout
//
//  Created by Brian Clouser on 3/21/16.
//  Copyright © 2016 The Qwiz LLC. All rights reserved.
//

#import "PostWorkoutSummaryViewController.h"

@interface PostWorkoutSummaryViewController ()

@end

@implementation PostWorkoutSummaryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.hidesBackButton = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)buttonTapped:(id)sender
{
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"GoingBackToRootVC" object:nil];
    
    
    [self.navigationController popToRootViewControllerAnimated:YES];
    
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
