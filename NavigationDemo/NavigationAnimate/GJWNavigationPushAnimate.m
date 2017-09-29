//
//  UINavigationPushTransition.m
//  NavigationDemo
//
//  Created by dfhb@rdd on 16/8/16.
//  Copyright © 2016年 guojunwei. All rights reserved.
//

#import "GJWNavigationPushAnimate.h"
#import "UINavigationBar+Color.h"
#import "GJWNavigationColorSource.h"

@implementation GJWNavigationPushAnimate

- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext {
    return 0.3;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    
    UIViewController<GJWNavigationColorSource> *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    
    UIViewController<GJWNavigationColorSource> *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    UIColor *nextColor = nil;
    UIImage *nextImage = nil;
    UIImage *shadowImage = nil;
    NSDictionary *nextTitleAttribute = nil;

    if ([fromVC conformsToProtocol:@protocol(GJWNavigationColorSource)]) {
        id <GJWNavigationColorSource> dataSource = fromVC;
        ///color
        if ([dataSource respondsToSelector:@selector(navigationBarOutColor)]) {
            if ([dataSource navigationBarInColor]) {
                nextColor = [dataSource navigationBarInColor];
            }
        }
//        ///IMAGE //注释掉,避免后一个页面没有image 的情况的 bug
//        if ([dataSource respondsToSelector:@selector(navigationBarBgImage)]) {
//            if ([dataSource navigationBarBgImage]) {
//                nextImage = [dataSource navigationBarBgImage];
//            }
//        }
        ///IMAGE
//        if ([dataSource respondsToSelector:@selector(navigationBarShadowImage)]) {
//            if ([dataSource navigationBarShadowImage]) {
//                nextImage = [dataSource navigationBarShadowImage];
//            }
//        }
        ///title
        if ([dataSource respondsToSelector:@selector(navigationTitleAttributes)]) {
            if ([dataSource navigationTitleAttributes]) {
                nextTitleAttribute = [dataSource navigationTitleAttributes];
            }
        }
        
    }
    if ([toVC conformsToProtocol:@protocol(GJWNavigationColorSource)]) {
        id<GJWNavigationColorSource> dataSource = toVC;
        //COLOR
        if ([dataSource respondsToSelector:@selector(navigationBarOutColor)]) {
            if ([dataSource navigationBarInColor]) {
                nextColor = [dataSource navigationBarInColor];
            }
        }
        ///IMAGE
        if ([dataSource respondsToSelector:@selector(navigationBarBgImage)]) {
            if ([dataSource navigationBarBgImage]) {
                nextImage = [dataSource navigationBarBgImage];
            }
        }
        ///IMAGE
        if ([dataSource respondsToSelector:@selector(navigationBarShadowImage)]) {
            if ([dataSource navigationBarShadowImage]) {
                shadowImage = [dataSource navigationBarShadowImage];
            }
        }
        //title
        if ([dataSource respondsToSelector:@selector(navigationTitleAttributes)]) {
            if ([dataSource navigationTitleAttributes]) {
                nextTitleAttribute = [dataSource navigationTitleAttributes];
            }
        }
        
        
    }

    
    
    UIView *containerView = [transitionContext containerView];
    
    UIView *shadowView = [[UIView alloc] init];
    shadowView.frame = containerView.bounds;
    shadowView.backgroundColor = [UIColor blackColor];
    shadowView.alpha = 0;
    
    [containerView addSubview:shadowView];
    [containerView addSubview:toVC.view];
    
    
    
    CGRect originFromFrame = fromVC.view.frame;
    CGRect finalToFrame = [transitionContext finalFrameForViewController:toVC];
    toVC.view.frame = CGRectOffset(finalToFrame, finalToFrame.size.width, 0);
    
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    
    
    [UIView animateWithDuration:duration delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        toVC.view.frame = finalToFrame;
        CGRect fromF = CGRectOffset(originFromFrame, -originFromFrame.size.width/2, 0);
        fromVC.view.frame = fromF;
        shadowView.alpha = 0.3;
        
        [(GJW_NavigationBar*)fromVC.navigationController.navigationBar gjw_setBackgroundColor:nextColor];
        [(GJW_NavigationBar*)fromVC.navigationController.navigationBar gjw_setTitleAttributes:nextTitleAttribute];
        [(GJW_NavigationBar*)fromVC.navigationController.navigationBar gjw_setBackgroundImage:nextImage ];
        [(GJW_NavigationBar*)fromVC.navigationController.navigationBar gjw_setShadowImage:shadowImage ];

        
        
    } completion:^(BOOL finished) {
        fromVC.view.frame = originFromFrame;
        [shadowView removeFromSuperview];
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
//        toVC.view.backgroundColor = [UIColor whiteColor];
        
        if (![transitionContext transitionWasCancelled]) {
            TimUINavigationBarObject *object = [TimUINavigationBarObject new];
            object.preColor = nextColor;
            object.preTitleAtt = nextTitleAttribute;
            object.preBgImage = nextImage;
            object.shadowImage = shadowImage;
            
            [(GJW_NavigationBar*)fromVC.navigationController.navigationBar saveBarAttributes:object];
            
        }
        
    }];
    [(GJW_NavigationBar*)toVC.navigationController.navigationBar gjw_reset_backView_index];
    
}

@end
