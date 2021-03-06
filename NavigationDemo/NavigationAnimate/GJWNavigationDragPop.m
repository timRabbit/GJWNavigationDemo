//
//  GJWNavigationDragPop.m
//  NavigationDemo
//
//  Created by dfhb@rdd on 16/8/17.
//  Copyright © 2016年 guojunwei. All rights reserved.
//

#import "GJWNavigationDragPop.h"
#import "GJWNavigationPopAnimate.h"
#import "GJWNavigationColorSource.h"
#import "UINavigationBar+Color.h"


@interface GJWNavigationDragPop ()
{
    UIScreenEdgePanGestureRecognizer * _edgePan;
    
}
@end
@implementation GJWNavigationDragPop

- (instancetype)init {
    self = [super init];
    self.interacting = NO;
    self.progressFinished = 0.3;
    return self;
}

- (void)setNavigationController:(UINavigationController *)navigationController {
    _navigationController = navigationController;
    
//    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
//    [_navigationController.view addGestureRecognizer:pan];
    
//    // 类似于系统从左侧滑动返回
    _edgePan = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
    _edgePan.edges = UIRectEdgeLeft;
    [_navigationController.view addGestureRecognizer:_edgePan];
    
}

-(void)setEnablePanBack:(BOOL)enablePanBack
{
    _enablePanBack = enablePanBack;
    
    _edgePan.enabled = enablePanBack;
    
}

- (void)handlePan:(UIPanGestureRecognizer *)pan {
    
    if (NO == self.enablePanBack) {
        self.interacting = NO;
        [self cancelInteractiveTransition];
        
        return;
        
    }
    
    //不支持返回的 code
    UIViewController *topVC = self.navigationController.topViewController;
    BOOL conformsToProtocol = [topVC conformsToProtocol:@protocol(GJWNavigationViewControllerPanProtocol)];
    BOOL respondsToSelector =  [topVC respondsToSelector:@selector(enablePanBack)];

    if ( conformsToProtocol && respondsToSelector ) {
        
        NSObject<GJWNavigationViewControllerPanProtocol > *objectProtocol = (id<GJWNavigationViewControllerPanProtocol>)topVC;
        
        if (NO == [objectProtocol enablePanBack]) {
            return;
        }
        
    }
    
    
    
    CGPoint offset = [pan translationInView:pan.view];
    // 速度
    CGPoint velocity = [pan velocityInView:pan.view];
    
//    NSLog(@"offset:%@---velocity:%@", NSStringFromCGPoint(offset), NSStringFromCGPoint(velocity));
    
    float progress = offset.x / pan.view.bounds.size.width;
    progress = MIN(1.0, MAX(progress, 0.0));

    switch (pan.state) {
        case UIGestureRecognizerStateBegan:
        {
            if (!self.pop.animating) {
                
                self.interacting = YES;
                if (velocity.x > 0 && self.navigationController.viewControllers.count > 1) {
                    [self.navigationController popViewControllerAnimated:YES];
                }
            }
            
        }
            break;
            
        case UIGestureRecognizerStateChanged:
        {
            if (self.interacting) {

                [self updateInteractiveTransition:progress];
            }
        }
            break;
        case UIGestureRecognizerStateEnded:
        {
            if (self.interacting) {
                
                if (progress > self.progressFinished) { // 滑动幅度
                    [self finishInteractiveTransition];
                } else {
                    [self cancelInteractiveTransition];
                    [(GJW_NavigationBar*)self.navigationController.navigationBar gjw_reset_afterCancleInteractiveTransition];

                }
                self.interacting = NO;
            }

        }
            break;
        case UIGestureRecognizerStateCancelled:
        {
            if (self.interacting) {
                [self cancelInteractiveTransition];
                self.interacting = NO;
            }

        }
            break;
        default:
            break;
    }
    
}

@end
