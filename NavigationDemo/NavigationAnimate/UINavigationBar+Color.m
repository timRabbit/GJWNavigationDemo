//
//  UINavigationBar+BackgroundColor.m
//  NavigationDemo
//
//  Created by dfhb@rdd on 16/8/15.
//  Copyright © 2016年 guojunwei. All rights reserved.
//

#import "UINavigationBar+Color.h"
#import <objc/runtime.h>

@implementation TimUINavigationBarObject

@end

@interface UINavigationBar ()
{

    
}
@property (nonatomic, strong) UIImageView *backView;

@property (nonatomic, strong) TimUINavigationBarObject *preObject;

@end

static char backViewKey;
static char preObjectKey;

@implementation UINavigationBar (Color)
static char overlayKey;


- (void)setOverlay:(UIView *)overlay
{
    objc_setAssociatedObject(self, &overlayKey, overlay, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (UIView *)overlay
{
    return objc_getAssociatedObject(self, &overlayKey);
}


- (void)setBackView:(UIImageView *)backView {
    objc_setAssociatedObject(self, &backViewKey, backView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (UIImageView *)backView {
    return objc_getAssociatedObject(self, &backViewKey);
}

-(void)setPreObject:(TimUINavigationBarObject *)preObject
{
    objc_setAssociatedObject(self, &preObjectKey, preObject, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
-(TimUINavigationBarObject *)preObject
{
    return objc_getAssociatedObject(self, &preObjectKey);

}

#pragma mark init
-(void)initBackView
{
    [self setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    self.shadowImage = [UIImage new];
    
    UIImageView *view = [UIImageView new];
    view.frame = CGRectMake(0, -20, [UIScreen mainScreen].bounds.size.width, 64);
    [self insertSubview:view atIndex:0];
    view.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    view.userInteractionEnabled = NO;
    self.backView = view;
    
    
//    NSArray *subViews = [self subviews];
//    UIView *superView = [subViews firstObject];
//    //    UIView *superView = [subViews objectAtIndex:1];
//    //    superView = [[superView subviews]firstObject];
    
//    self.backView = superView;
    //        [superView addSubview:view];
    
//    superView.clipsToBounds = YES;
    
}

-(void)initBackView8_9
{
    [self setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    self.shadowImage = [UIImage new];

    NSArray *subViews = [self subviews];
    UIView *superView = [subViews firstObject];
//    UIView *superView = [subViews objectAtIndex:1];
//    superView = [[superView subviews]firstObject];
    
    self.backView = superView;
    
    superView.clipsToBounds = YES;
    
}

#pragma mark setting
- (void)gjw_setBackgroundColor:(UIColor *)backgroundColor {
    
    if (self.backView == nil) {
        [self initBackView];
    }
//    self.translucent = NO;
    self.backView.backgroundColor = backgroundColor;
    [self gjw_reset_backView_index];

}
- (void)gjw_setTitleAttributes:(NSDictionary *)attributes
{
    [self setTitleTextAttributes:attributes];
    
}
- (void)gjw_setShadowImage:(UIImage *)image
{
//    self.shadowImage = image;
//    [self gjw_reset_backView_index];

    
    self.shadowImage = image;
    
    NSArray *subViews = [self subviews];
    
    UIView *superView = nil;
    
    for (UIView *view in subViews ) {
        NSString *classStr = NSStringFromClass(view.class);
        if ([classStr isEqualToString:@"_UIBarBackground"]||
            [classStr isEqualToString:@"_UINavigationBarBackground"])
            {
                
            superView = view;
            break;
            
        }
        
    }
    for (UIView *view in superView.subviews ) {
        if ([NSStringFromClass(view.class) isEqualToString:@"UIImageView"]){
            superView = view;
            
            if ( image == nil) {
                superView.hidden = NO;
                
            }else{
                superView.hidden = YES;
                
            }

            
        }
    }
    
  
    
    
}

- (void)gjw_setBackgroundImage:(UIImage *)image
{
    if (self.backView == nil) {
        [self initBackView];
    }
    //    self.translucent = NO;
    self.backView.image = image;
//    if (image) {
//        UIColor *color = [UIColor colorWithPatternImage:self.backView.image];
//        [self gjw_setBackgroundColor:color];
//        
//    }
//    self.backView.image = nil;

    
//    self.backView.contentMode = model;
}

- (void)gjw_reset {
    [self setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    self.shadowImage = nil;
    [self.backView removeFromSuperview];
    self.backView = nil;
}

-(void)saveBarAttributes:(TimUINavigationBarObject *)object
{
    self.preObject = object;
}

///滑动取消
-(void)gjw_reset_afterCancleInteractiveTransition
{
    
    [self gjw_setBackgroundColor:self.preObject.preColor];
    [self gjw_setBackgroundImage:self.preObject.preBgImage];
    [self gjw_setTitleAttributes:self.preObject.preTitleAtt];
    [self gjw_setShadowImage:self.preObject.shadowImage];
    
}
-(void)gjw_reset_backView_index
{
    [self sendSubviewToBack:self.backView];
    
}



///
- (void)lt_setBackgroundColor:(UIColor *)backgroundColor
{
    if (!self.overlay) {
        [self setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
        
        // insert an overlay into the view hierarchy
        self.overlay = [[UIView alloc] initWithFrame:CGRectMake(0, -20, [UIScreen mainScreen].bounds.size.width, self.bounds.size.height + 20)];
        self.overlay.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        
        [self insertSubview:self.overlay atIndex:0];
    }
    self.overlay.backgroundColor = backgroundColor;
}
@end
