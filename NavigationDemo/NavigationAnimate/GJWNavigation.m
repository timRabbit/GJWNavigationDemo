//
//  GJWNavigation.m
//  NavigationDemo
//
//  Created by dfhb@rdd on 16/8/16.
//  Copyright © 2016年 guojunwei. All rights reserved.
//

#import "GJWNavigation.h"
#import "GJWNavigationPushAnimate.h"
#import "GJWNavigationPopAnimate.h"
#import "GJWNavigationDragPop.h"
#import "UINavigationBar+Color.h"

@interface GJWNavigation () <UINavigationControllerDelegate>
@property (nonatomic, weak) UINavigationController *navigationController;
@property (nonatomic, strong) GJWNavigationPushAnimate *push;
@property (nonatomic, strong) GJWNavigationPopAnimate *pop;
@property (nonatomic, strong) GJWNavigationDragPop *dragPop;

@property (nonatomic, strong) NSMutableSet *disableVC_set;

@end

@implementation GJWNavigation
- (GJWNavigationPushAnimate *)push {
    if (!_push) {
        _push = [GJWNavigationPushAnimate new];
    }
    return _push;
}
- (GJWNavigationPopAnimate *)pop {
    if (!_pop) {
        _pop = [GJWNavigationPopAnimate new];
    }
    return _pop;
}
- (GJWNavigationDragPop *)dragPop {
    if (!_dragPop) {
        _dragPop = [GJWNavigationDragPop new];
    }
    return _dragPop;
}
- (instancetype)init {
    self = [super init];
    if (self) {
        self.dragPop.pop = self.pop;
        self.progressFinished = 0.3;
    }
    return self;
}
-(NSMutableSet *)disableVC_set
{
    if (!_disableVC_set) {
        _disableVC_set = [NSMutableSet new];
    }
    return _disableVC_set;
}

- (void)joinToNavigationController:(UINavigationController *)navigationController {
    
    self.navigationController = navigationController;
    self.navigationController.delegate = self;
    self.dragPop.navigationController = self.navigationController;
}

- (void)setProgressFinished:(float)progressFinished {
    _progressFinished = progressFinished;
    if (_progressFinished > 1.0 || _progressFinished < 0) {
        _progressFinished = 0.3;
    }
    self.dragPop.progressFinished = _progressFinished;
}
-(void)addDisAblePanBackViewController:(Class)class
{
    
    [self.disableVC_set addObject: class];
    
    
}

#pragma mark - UINavigationControllerDelegate
- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC {
    
    if ([self.disableVC_set containsObject:[toVC class]]) {
        self.dragPop.enablePanBack = NO;
    }else{
        self.dragPop.enablePanBack = YES;
    }
    
    
    if (operation == UINavigationControllerOperationPush) {
        return self.push;
    } else if (operation == UINavigationControllerOperationPop) {
        return self.pop;
    }
    return self.push;
    return nil;
}

- (id<UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController interactionControllerForAnimationController:(id<UIViewControllerAnimatedTransitioning>)animationController {
//    if ([animationController isKindOfClass:[GJWNavigationPopTransition class]]) {
//        
//        if (self.dragPop.interacting) {
//            return self.dragPop;
//        }
//        
////        return self.dragPop;
//    }
//    return nil;
    
    
    return self.dragPop.interacting ? self.dragPop:nil;
    
}
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    [self.navigationController.navigationBar gjw_reset_backView_index];
}
- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(nonnull UIViewController *)viewController animated:(BOOL)animated
{
    [self.navigationController.navigationBar gjw_reset_backView_index];
}

@end
