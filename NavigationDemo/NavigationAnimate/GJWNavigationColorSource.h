//
//  GJWNavigationColorSource.h
//  NavigationDemo
//
//  Created by dfhb@rdd on 16/8/17.
//  Copyright © 2016年 guojunwei. All rights reserved.
//

#import <Foundation/Foundation.h>

@class UIColor;
@protocol GJWNavigationColorSource <NSObject>

@optional
- (UIColor *)navigationBarInColor;
- (UIColor *)navigationBarOutColor;

- (UIImage *)navigationBarBgImage;


///title 的相关属性
- (NSDictionary *)navigationTitleAttributes;


@end

@protocol GJWNavigationViewControllerPanProtocol <NSObject>

//@optional
///是否使用手势
- (BOOL)enablePanBack;

@end
