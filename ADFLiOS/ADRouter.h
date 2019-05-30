//
//  ADRouter.h
//  ADFLiOS
//
//  Created by Andy on 2019/5/30.
//  Copyright © 2019 Andy. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ADRouter : NSObject

/**
 *  单例 CMRouter
 *
 *  @return 创建一个对象
 */
+ (instancetype)sharedInstance;

/**
 *  获取当前展示的 Controller
 *
 *  @return 获取当前展示的 Controller
 */
- (UIViewController *)currentController;

/**
 *  获取当前 NavigationController
 *
 *  @return 获取当前 NavigationController
 */
- (UINavigationController *)currentNavigationController;

/**
 *  push or present 一个 viewController
 *
 *  @param viewControllerName 将要显示的 viewController 的类名
 *  @param param   目标 viewController  需要的参数
 *  @explanation animated default = YES
 */
- (void)showViewController:(NSString *)viewControllerName param:(NSDictionary *)param;

/**
 push or present 一个 viewController
 
 @param viewControllerName 将要显示的 viewController 的类名
 @param param 目标 viewController  需要的参数
 @param animated 是否需要转场动画
 */
- (void)showViewController:(NSString *)viewControllerName param:(NSDictionary *)param animated:(BOOL)animated;

/**
 *  present 一个 viewController
 *
 *  @param viewControllerName 将要显示的 viewController 的类名
 *  @param param   目标 viewController  需要的参数
 */
- (void)presentControllerWithControllerName:(NSString *)viewControllerName param:(NSDictionary *)param;

/**
 *  present 一个 viewController
 *
 *  @explanation  将要显示的 viewController
 *  @param param   目标 viewController  需要的参数
 */
- (void)presentController:(UIViewController *)controller param:(NSDictionary *)param;

/**
 *  根据 className 创建一个对象
 *
 *  @param className 对象名称
 *
 *  @return 根据 className 创建一个对象
 */
- (id)getObjectWithClassName:(NSString *)className;

/**
 *  返回上一级页面 pop or dismiss
 */
- (void)popViewController;

/**
 返回上级根目录 或者 dimiss 模态视图
 
 @param animated 是否需要转场动画
 */
- (void)popToRootViewControllerAnimated:(BOOL)animated;


@end

NS_ASSUME_NONNULL_END
