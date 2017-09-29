//
//  ViewController.m
//  NavigationDemo
//
//  Created by dfhb@rdd on 16/6/29.
//  Copyright © 2016年 guojunwei. All rights reserved.
//

#import "ViewController.h"
#import "SecondViewController.h"
#import "UINavigationBar+Color.h"
#import "GJWNavigation.h"

@interface ViewController ()
@property (nonatomic, strong) GJWNavigation *navigation;
@property (nonatomic, strong) UIImageView *image;
@end

@implementation ViewController

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.edgesForExtendedLayout = UIRectEdgeAll;
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.backgroundColor = [UIColor orangeColor];
    [button addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:@"下一页" forState:UIControlStateNormal];
    [self.view addSubview:button];
    button.frame = CGRectMake(100, 100, 80, 80);
    
    
    {
        UIImageView *button = [UIImageView new];
        button.backgroundColor = [UIColor orangeColor];
        [self.view addSubview:button];
        button.frame = CGRectMake(300, 100, 80, 80);
        
        _image = button;
        
    }
    self.navigationItem.title = @"Fir Controller";
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc]init];
    backItem.title = @"";
    self.navigationItem.backBarButtonItem = backItem;
    
    // 设置navigationBar的背景色 (仅仅在根视图控制器中设置一次即可)
    UINavigationBar *bar = [self.navigationController navigationBar];
    [bar gjw_setBackgroundColor:[self navigationBarInColor]];
    [bar gjw_setTitleAttributes:[self navigationTitleAttributes]];
    [bar gjw_setShadowImage:[self navigationBarShadowImage]];
//    [bar gjw_setBackgroundImage:[self navigationBarBgImage]];
    
    self.view.backgroundColor = [UIColor colorWithRed:0.972 green:0.394 blue:0.294 alpha:1.000];
    
}
// 设置从其他页面到该页面的导航颜色
- (UIColor *)navigationBarInColor {
//    UIImage *image = [UIImage imageNamed:@"v2_goback"] ;
////    UIImage *image = [UIImage imageNamed:@"bg_profit-"] ;
//    image = [image resizableImageWithCapInsets:UIEdgeInsetsMake(1, 1, 1, 1) resizingMode:UIImageResizingModeStretch];
//    return [UIColor colorWithPatternImage:image];
    
    return [UIColor orangeColor];
}
static int i = 0;

- (void)buttonClick {
    
    if(0){
    UIImage *image1 = [UIImage imageNamed:@"bg_profit-"];
    UIImage *image2 = [UIImage imageNamed:@"bg_expenditure"];
    
    
    CATransition *transition = [CATransition animation];
    transition.duration = 1;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionFade;
    [self.image.layer addAnimation:transition forKey:@"a"];
    [self.image setImage: ++i % 2 ? image1 : image2];
    
    
    [UIView animateWithDuration:1
                          delay:0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
        
//                         [self.image setImage: ++i % 2 ? image1 : image2];
        
    } completion:^(BOOL finished) {
        
    }];
    
    
    return;
    }
    SecondViewController *second = [SecondViewController new];
    if (self.tabBarController) {
    
        [self.tabBarController.navigationController pushViewController:second animated:YES];
        [self.tabBarController.navigationController setNavigationBarHidden:0 animated:1];
    
    }else{
        [self.navigationController pushViewController:second animated:YES];
        
    }
}
-(NSDictionary *)navigationTitleAttributes
{
    return  @{NSForegroundColorAttributeName: [UIColor yellowColor]};
    
}
-(UIImage *)navigationBarShadowImage
{
    
//    return [UIImage imageNamed:@"bg_expenditure"];
    return [UIImage new];
    return nil;
    
}
-(UIImage *)navigationBarBgImage
{
    return [UIImage imageNamed:@"bg_expenditure"];

}

@end
