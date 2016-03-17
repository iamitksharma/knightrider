//
//  HomeViewController.m
//  MobilityHackathon
//
//  Created by Sandeep Kharbanda on 16/03/16.
//  Copyright © 2016 Intelligrape. All rights reserved.
//

#import "HomeViewController.h"
#import "ViewController.h"

@interface HomeViewController ()<UITextFieldDelegate>{
    
    __weak IBOutlet UIView *userInputVw;

    __weak IBOutlet UITextField *searchTxtFld;

    __weak IBOutlet UIButton *movieBtn;
    __weak IBOutlet UIButton *foodDrinkBtn;
    __weak IBOutlet UIButton *dealsBtn;

    __weak IBOutlet UISegmentedControl *findLocSegmentItems;
    __weak IBOutlet NSLayoutConstraint *dealsLeadingConstraints;
}

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.translucent = YES;
    [(UIView*)[self.navigationController.navigationBar.subviews objectAtIndex:0] setAlpha:0.8f];

    
    // Do any additional setup after loading the view.
}

-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
    dealsLeadingConstraints.constant = CGRectGetMinX(foodDrinkBtn.frame) - CGRectGetMaxX(movieBtn.frame);
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    
    if (findLocSegmentItems.selectedSegmentIndex == 0) {
        [self performSegueWithIdentifier:@"navigateToAR" sender:nil];
    }
    else {
        [self performSegueWithIdentifier:@"navigateToMap" sender:nil];
    }
    
    return YES;
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if ([segue.identifier isEqual:@"navigateToMap"]) {
        ViewController *mapViewController = [segue destinationViewController];
        mapViewController.searchText = searchTxtFld.text;
    }
}


@end
