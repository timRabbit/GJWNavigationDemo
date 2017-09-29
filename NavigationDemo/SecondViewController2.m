//
//  SecondViewController.m
//  NavigationDemo
//
//  Created by dfhb@rdd on 16/6/29.
//  Copyright © 2016年 guojunwei. All rights reserved.
//

#import "SecondViewController2.h"
#import "SecondViewController.h"

@implementation SecondViewController2

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"Second Controller2";
    
//    self.edgesForExtendedLayout = UIRectEdgeAll;
    self.edgesForExtendedLayout = UIRectEdgeNone;

    /*
     特别注意:
     当该页面的导航颜色为透明色时，要设置 self.edgesForExtendedLayout = UIRectEdgeAll;
     与该页面的相邻的页面的edgesForExtendedLayout != UIRectEdgeNone
     也就是说当导航透明的时候，我们要保证view的(x,y)坐标是从(0,0)位置开始的，而不是以(0.64)开始的
     */
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.backgroundColor = [UIColor orangeColor];
    [button addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:@"下一页" forState:UIControlStateNormal];
    [self.view addSubview:button];
    button.frame = CGRectMake(100, 568-100-64, 80, 100);
    
    
//    self.automaticallyAdjustsScrollViewInsets = true;
    
    UIImageView* imageView = [[UIImageView alloc] initWithImage:[ UIImage imageNamed:@"demo-header"]];
    imageView.contentMode = UIViewContentModeScaleToFill;
    imageView.frame = CGRectMake(0, -64, self.view.bounds.size.width, self.view.bounds.size.width*0.75);
    
    [self.view addSubview:imageView];
    
    
}

- (void)buttonClick {
    
    SecondViewController *second = [SecondViewController new];
    
    [self.navigationController pushViewController:second animated:YES];
    
}

// 设置从其他页面到该页面的导航颜色
- (UIColor *)navigationBarInColor {
    
//    UIImage *image = [UIImage imageNamed:@"bg_expenditure"] ;
//    
//    image = [image resizableImageWithCapInsets:UIEdgeInsetsZero resizingMode:UIImageResizingModeTile];
//    return [UIColor colorWithPatternImage:image];
//    
    return [UIColor clearColor];
//    return [UIColor colorWithRed:0.972 green:0.394 blue:0.294 alpha:1.000];
    return [UIColor colorWithRed:0.018 green:0.028 blue:0.023 alpha:0.777];
}
-(BOOL)enablePanBack
{
    return NO;
}
-(NSDictionary *)navigationTitleAttributes
{
    return  @{NSForegroundColorAttributeName: [UIColor yellowColor]};
    
}
-(UIImage *)navigationBarShadowImage
{

    return [UIImage new];
    return nil;

}
//-(UIImage *)navigationBarBgImage
//{
//    return [UIImage imageNamed:@"bg_expenditure"];
//    
//}

@end
