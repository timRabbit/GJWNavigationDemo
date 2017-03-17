//
//  UINavigationPopTransition.m
//  NavigationDemo
//
//  Created by dfhb@rdd on 16/8/16.
//  Copyright © 2016年 guojunwei. All rights reserved.
//

#import "GJWNavigationPopAnimate.h"
#import "UINavigationBar+Color.h"
#import "GJWNavigationColorSource.h"


@implementation GJWNavigationPopAnimate
- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext {
    return 0.3;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    
    UIViewController<GJWNavigationColorSource> *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    
    UIViewController<GJWNavigationColorSource> *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    UIColor *nextColor = nil;
    UIImage *nextImage = nil;
    NSDictionary *nextTitleAttribute = nil;
    
    if ([fromVC conformsToProtocol:@protocol(GJWNavigationColorSource)]) {
        id <GJWNavigationColorSource> dataSource = fromVC;
        ///COLOR
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
        //title
        if ([dataSource respondsToSelector:@selector(navigationTitleAttributes)]) {
            if ([dataSource navigationTitleAttributes]) {
                nextTitleAttribute = [dataSource navigationTitleAttributes];
            }
        }
    }
    if ([toVC conformsToProtocol:@protocol(GJWNavigationColorSource)]) {
        id<GJWNavigationColorSource> dataSource = toVC;
        ///color
        if ([dataSource respondsToSelector:@selector(navigationBarOutColor)]) {
            if ([dataSource navigationBarInColor]) {
                nextColor = [dataSource navigationBarInColor];
            }
        }
        ///image
        if ([dataSource respondsToSelector:@selector(navigationBarBgImage)]) {
            if ([dataSource navigationBarBgImage]) {
                nextImage = [dataSource navigationBarBgImage];
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
    shadowView.alpha = 0.3;
    
    
    CGRect finalF = [transitionContext finalFrameForViewController:toVC];
    toVC.view.frame = CGRectOffset(finalF, -finalF.size.width/2, 0);
    
    [containerView insertSubview:toVC.view belowSubview:fromVC.view];
    [containerView insertSubview:shadowView aboveSubview:toVC.view];

    
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    
    self.animating = YES;
    [UIView animateWithDuration:duration delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        toVC.view.frame = finalF;
        fromVC.view.frame = CGRectOffset(fromVC.view.frame, fromVC.view.frame.size.width, 0);
        shadowView.alpha = 0;
        
        [fromVC.navigationController.navigationBar gjw_setBackgroundColor:nextColor];
        [fromVC.navigationController.navigationBar gjw_setTitleAttributes:nextTitleAttribute];
        [fromVC.navigationController.navigationBar gjw_setBackgroundImage:nextImage ];
        
        
    } completion:^(BOOL finished) {
//        fromVC.view.frame = fromF;
        self.animating = NO;
        [shadowView removeFromSuperview];
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
//        toVC.view.backgroundColor = [UIColor whiteColor];
        
        if (![transitionContext transitionWasCancelled]) {
            TimUINavigationBarObject *object = [TimUINavigationBarObject new];
            object.preColor = nextColor;
            object.preTitleAtt = nextTitleAttribute;
            object.preBgImage = nextImage;
            
            [fromVC.navigationController.navigationBar saveBarAttributes:object];
            
        }
        
    }];
    [toVC.navigationController.navigationBar gjw_reset_backView_index];
    
}

@end
