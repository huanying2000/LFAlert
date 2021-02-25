//
//  LFAlertManager.h
//  LFAlert
//
//  Created by Farben on 2020/8/13.
//  Copyright © 2020 Farben. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger,LFAlertStyle) {
    LFAlertStyleSheet      = 0,  //sheet风格
    LFAlertStyleAlert      = 1,  //alert风格
    LFAlertStyleSheetTop   = 2,  ///< sheet风格从上至下
    LFAlertStyleSheetLeft  = 3,  ///< sheet风格从左至右
    LFAlertStyleSheetRight = 4,  ///< sheet风格从右至左
};

typedef void(^LFAlertBlock)(id obj);

@interface LFAlertManager : NSObject

//背景
@property (nonatomic,readonly) UIView *backgroundView;
//提醒视图
@property (nonatomic,weak,readonly) UIView *alertView;
//弹出风格
@property (nonatomic,assign) LFAlertStyle alertStyle;
//背景点击是否有效
@property (nonatomic,assign) BOOL backgroundTapDismissEnable;
//是否使用弹簧动画效果
@property (nonatomic,assign) BOOL usingSpring;
//点击背景回调
@property (nonatomic,copy) LFAlertBlock tapBlock;
//dismiss回调
@property (nonatomic,copy) LFAlertBlock dismissBlock;

- (instancetype)initWithSuperview:(UIView*)superview alertView:(UIView*)alertView;

- (void)show;

- (void)hide:(BOOL)animated;

@end

NS_ASSUME_NONNULL_END
