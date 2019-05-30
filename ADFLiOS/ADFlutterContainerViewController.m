//
//  ADFlutterContainerViewController.m
//  ADFLiOS
//
//  Created by Andy on 2019/5/30.
//  Copyright © 2019 Andy. All rights reserved.
//

#import "ADFlutterContainerViewController.h"

@interface ADFlutterContainerViewController ()

@end

@implementation ADFlutterContainerViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationController.navigationBar.hidden = YES;
}

#pragma mark - UINavigationControllerDelegate

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    
}

@end
