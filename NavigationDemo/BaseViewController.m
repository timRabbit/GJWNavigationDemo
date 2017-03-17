//
//  BaseViewController.m
//  NavigationDemo
//
//  Created by dfhb@rdd on 16/6/29.
//  Copyright © 2016年 guojunwei. All rights reserved.
//

#import "BaseViewController.h"

#ifndef USECUSTOMITEM
    #define USECUSTOMITEM 1
#endif

@interface BaseViewController () 
{
    UIButton *backBtn;
    BOOL _enableNavPanBack;
    
}
@end
@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // 
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
#if USECUSTOMITEM
    if ( self.navigationController.viewControllers.count > 1 ) {
        
        self.navigationItem.leftBarButtonItem = [self backBarButtonItem];
        //        self.navigationController.interactivePopGestureRecognizer.enabled = YES;
        //        self.navigationItem.backBarButtonItem
        
        if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
            self.navigationController.interactivePopGestureRecognizer.delegate = nil;
        }
        
    }
#endif
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (UIColor *)navigationBarInColor {
    return nil;
}

- (UIColor *)navigationBarOutColor {
    return nil;
}

-(NSDictionary *)navigationTitleAttributes
{
   return  @{NSForegroundColorAttributeName: [UIColor redColor]};
    
}




#if USECUSTOMITEM

#pragma mark 设置返回按钮
-(UIBarButtonItem *)backBarButtonItem{
    UIBarButtonItem *item ;
    if (item) {
        return item;
    }
    
    if (!item) {
        //        item = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleDone target:nil action:NULL];
        
        UIImage *image  = [[UIImage imageNamed:@"v2_goback"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
//        backBtn = [[UIButton alloc] initNavigationButton:image];
        backBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
        [backBtn setImage:image forState:0];
        //item = [[UIBarButtonItem alloc] initWithImage:image style:UIBarButtonItemStylePlain target:self action:@selector(backItemAct:)];
        backBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        
        item = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
        
        [backBtn addTarget:self action:@selector(backItemAct:) forControlEvents:UIControlEventTouchUpInside];
        
        
    }
    return item;
}
-(void)backItemAct:(id)sender
{
    [self.navigationController popViewControllerAnimated:1];
    
}

#endif
@end
