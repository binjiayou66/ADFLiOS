//
//  ADRouter.m
//  ADFLiOS
//
//  Created by Andy on 2019/5/30.
//  Copyright © 2019 Andy. All rights reserved.
//

#import "ADRouter.h"
#import <objc/runtime.h>

@implementation ADRouter

+ (instancetype)sharedInstance
{
    static ADRouter *router = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        if (!router) {
            router = [[self alloc] init];
        }
    });
    
    return router;
}

- (UIViewController *)currentController
{
    return  [[self class] visibleViewControllerWithRootViewController:self.rootViewController];
}

- (UINavigationController *)currentNavigationController
{
    UINavigationController *nvc = [[self class] expectedVisibleNavigationController];
    return nvc;
}

- (void)showViewController:(NSString *)viewControllerName param:(NSDictionary *)param
{
    [self showViewController:viewControllerName param:param animated:YES];
}

- (void)showViewController:(NSString *)viewControllerName param:(NSDictionary *)param animated:(BOOL)animated
{
    Class viewController = NSClassFromString(viewControllerName);
    if ([self.currentController isKindOfClass:[viewController class]]) {
        return;
    }
    UINavigationController *nvc = [[self class] expectedVisibleNavigationController];
    
    UIViewController *vc = [self getObjectWithClassName:viewControllerName];
    
    if (vc)
    {
        if (nvc)
        {
            [self pushViewController:vc parameters:param atNavigationController:nvc animated:animated];
        }
        else
        {
            [self pressntVController:vc parameters:param animated:animated];
        }
    }
}

- (void)presentControllerWithControllerName:(NSString *)viewControllerName param:(NSDictionary *)param
{
    [self presentControllerWithControllerName:viewControllerName param:param animated:YES];
}

- (void)presentControllerWithControllerName:(NSString *)viewControllerName param:(NSDictionary *)param animated:(BOOL)animated
{
    UIViewController *vc = [self getObjectWithClassName:viewControllerName];
    
    if (vc)
    {
        [self pressntVController:vc parameters:param animated:animated];
    }
}

- (void)presentController:(UIViewController *)controller param:(NSDictionary *)param
{
    [self presentController:controller param:param animated:YES];
}

- (void)presentController:(UIViewController *)controller param:(NSDictionary *)param animated:(BOOL)animated
{
    [self pressntVController:controller parameters:param animated:animated];
}

- (id)getObjectWithClassName:(NSString *)className
{
    if (className == nil || className.length == 0) {
        return nil;
    }
    UIViewController *vc = [NSClassFromString(className) new];
    
    return vc;
}

- (void)popViewController
{
    UIViewController *currentController = [self currentController];
    
    if (currentController.presentingViewController)
    {
        [currentController dismissViewControllerAnimated:YES completion:nil];
    }
    else
    {
        [currentController.navigationController popViewControllerAnimated:YES];
    }
}

- (void)popToRootViewControllerAnimated:(BOOL)animated
{
    UIViewController *currentController = [self currentController];
    
    if (currentController.presentingViewController)
    {
        [currentController dismissViewControllerAnimated:animated completion:nil];
    }
    else
    {
        [currentController.navigationController popToRootViewControllerAnimated:animated];
    }
}

#pragma mark - private method

- (void)pushViewController:(UIViewController *)viewController parameters:(NSDictionary *)parameters atNavigationController:(UINavigationController *)navigationController animated:(BOOL)animated
{
    if (viewController == nil || [viewController isKindOfClass:[UINavigationController class]] || navigationController == nil) return;
    
    [self setObject:viewController parameters:parameters];
    
    [viewController setHidesBottomBarWhenPushed:YES];
    [navigationController pushViewController:viewController animated:animated];
}

- (void)pressntVController:(UIViewController *)vc parameters:(NSDictionary *)parameters animated:(BOOL)animated
{
    if (vc == nil) return;
    
    [self setObject:vc parameters:parameters];
    
    UIViewController *vc1 = [[self class] visibleViewControllerWithRootViewController:[[self class]visibleViewController]];
    
    [vc1 presentViewController:vc animated:animated completion:^{
        
    }];
}

+ (UINavigationController *)expectedVisibleNavigationController
{
    UIViewController *vc = [self visibleViewControllerWithRootViewController:[UIApplication sharedApplication].delegate.window.rootViewController];
    
    UINavigationController *nvc = (UINavigationController *)([vc isKindOfClass:[UINavigationController class]] ? vc : vc.navigationController);
    
    return nvc;
}

+ (UIViewController *)visibleViewController
{
    UIViewController *vc = [self visibleViewControllerWithRootViewController:[UIApplication sharedApplication].delegate.window.rootViewController];
    return vc;
}

+ (UIViewController *)visibleViewControllerWithRootViewController:(UIViewController *)rootViewController
{
    if ([rootViewController isKindOfClass:[UITabBarController class]])
    {
        UITabBarController *tbc = (UITabBarController *)rootViewController;
        return [self visibleViewControllerWithRootViewController:tbc.selectedViewController];
    }
    else if ([rootViewController isKindOfClass:[UINavigationController class]])
    {
        UINavigationController *nvc = (UINavigationController *)rootViewController;
        return [self visibleViewControllerWithRootViewController:nvc.visibleViewController];
    }
    else if (rootViewController.presentedViewController)
    {
        UIViewController *presentedVC = rootViewController.presentedViewController;
        return [self visibleViewControllerWithRootViewController:presentedVC];
    }
    else
    {
        return rootViewController;
    }
}

- (void)setObject:(UIViewController *)viewController parameters:(NSDictionary *)parameters
{
    if (viewController == nil || [viewController isKindOfClass:[UINavigationController class]]) return;
    
    NSArray *properties = [self _cm_propertyNamesByObject:viewController];
    
    [parameters enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        // 安全性检查
        if ([properties containsObject:key])
        {
            [viewController setValue:obj forKey:key];
        }
    }];
}

- (NSArray *)_cm_propertyNamesByObject:(id)object
{
    unsigned int outCount, i;
    objc_property_t *properties = class_copyPropertyList([object class], &outCount);
    NSMutableArray *nameArray = [[NSMutableArray alloc] initWithCapacity:outCount];
    for (i = 0; i < outCount; i++) {
        objc_property_t property = properties[i];
        NSString *propertyName = [[NSString alloc] initWithCString:property_getName(property) encoding:NSUTF8StringEncoding];
        [nameArray addObject:propertyName];
        
    }
    free(properties);
    return nameArray;
}

- (UIViewController *)rootViewController
{
    return [UIApplication sharedApplication].delegate.window.rootViewController;
}

@end
