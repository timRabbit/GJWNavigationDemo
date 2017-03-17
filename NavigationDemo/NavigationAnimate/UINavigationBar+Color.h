//
//  UINavigationBar+BackgroundColor.h
//  NavigationDemo
//
//  Created by dfhb@rdd on 16/8/15.
//  Copyright © 2016年 guojunwei. All rights reserved.
//

#import <UIKit/UIKit.h>
///缓存 bar 的相关属性
@interface TimUINavigationBarObject:NSObject

@property (nonatomic, strong) UIColor *preColor;
@property (nonatomic, strong) NSDictionary *preTitleAtt;
@property (nonatomic, strong) UIImage *preBgImage;
@end


@interface UINavigationBar (Color)
///使用者可调用
///设置 color
- (void)gjw_setBackgroundColor:(UIColor *)backgroundColor;
///设置 image
- (void)gjw_setBackgroundImage:(UIImage *)image;
///设置 title
- (void)gjw_setTitleAttributes:(NSDictionary *)attributes;


///使用者不建议调用
///取消自定义的 color 层
- (void)gjw_reset;
///改变 color 层的顺序
- (void)gjw_reset_backView_index;
///取消滑动之后的动作
- (void)gjw_reset_afterCancleInteractiveTransition;
///保存缓存的属性
-(void)saveBarAttributes:(TimUINavigationBarObject *)object;

@end
