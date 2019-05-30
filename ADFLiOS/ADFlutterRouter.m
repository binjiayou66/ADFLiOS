//
//  ADFlutterRouter.m
//  ADFLiOS
//
//  Created by Andy on 2019/5/30.
//  Copyright © 2019 Andy. All rights reserved.
//

#import "ADFlutterRouter.h"
#import "ADRouter.h"
#import "ADFlutterContainerViewController.h"

@implementation ADFlutterRouter

+ (ADFlutterRouter *)sharedRouter
{
    static id instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
        
    });
    return instance;
}

- (void)openPage:(NSString *)name params:(NSDictionary *)params animated:(BOOL)animated completion:(void (^)(BOOL finished))completion
{
    if ([params[@"present"] boolValue]) {
        ADFlutterContainerViewController *vc = [[ADFlutterContainerViewController alloc] init];
        [vc setName:name params:params];
        [[[ADRouter sharedInstance] currentController] presentViewController:vc animated:animated completion:^{}];
    } else {
        ADFlutterContainerViewController *vc = [[ADFlutterContainerViewController alloc] init];
        [vc setName:name params:params];
        [[[ADRouter sharedInstance] currentNavigationController] pushViewController:vc animated:animated];
    }
}

- (void)closePage:(NSString *)uid animated:(BOOL)animated params:(NSDictionary *)params completion:(void (^)(BOOL finished))completion
{
    UIViewController *currentController = [[ADRouter sharedInstance] currentController];
    FLBFlutterViewContainer *vc = (id)currentController.presentedViewController;    // 得验证下这样写可以吗？
    if ([vc isKindOfClass:FLBFlutterViewContainer.class] && [vc.uniqueIDString isEqual: uid]) {
        [vc dismissViewControllerAnimated:animated completion:^{}];
    } else {
        [[[ADRouter sharedInstance] currentNavigationController] popViewControllerAnimated:animated];
    }
}

@end
