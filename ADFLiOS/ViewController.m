//
//  ViewController.m
//  ADFLiOS
//
//  Created by Andy on 2019/5/29.
//  Copyright © 2019 Andy. All rights reserved.
//

#import "ViewController.h"
#import "ADFlutterRouter.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

}

- (IBAction)onClickButton:(id)sender
{
    [[ADFlutterRouter sharedRouter] openPage:@"hello_flutter" params:@{} animated:YES completion:^(BOOL f){}];
}

@end
