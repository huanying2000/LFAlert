//
//  UIView+LFAlertView.h
//  LFAlert
//
//  Created by Farben on 2020/8/13.
//  Copyright © 2020 Farben. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LFAlertManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface UIView (LFAlertView)

@property (nonatomic,weak) LFAlertManager *lf_manager;

- (void) showAlertStyle:(LFAlertStyle)alertStyle;

- (void)showAlertStyle:(LFAlertStyle)alertStyle backgoundTapDismissEnable:(BOOL)backgoundTapDismissEnable;

- (void)showAlertStyle:(LFAlertStyle)alertStyle backgoundTapDismissEnable:(BOOL)backgoundTapDismissEnable usingSpring:(BOOL)usingSpring;

- (void)showAlertStyle:(LFAlertStyle)alertStyle backgoundTapDismissEnable:(BOOL)backgoundTapDismissEnable usingSpring:(BOOL)usingSpring tapBlock:(LFAlertBlock)tapBlock;

- (void)showAlertStyle:(LFAlertStyle)alertStyle backgoundTapDismissEnable:(BOOL)backgoundTapDismissEnable usingSpring:(BOOL)usingSpring tapBlock:(LFAlertBlock)tapBlock dismissBlock:(LFAlertBlock)dismissBlock;


- (void)showToView:(UIView *)view alertStyle:(LFAlertStyle)alertStyle;

- (void)showToView:(UIView *)view alertStyle:(LFAlertStyle)alertStyle backgoundTapDismissEnable:(BOOL)backgoundTapDismissEnable;

- (void)showToView:(UIView *)view alertStyle:(LFAlertStyle)alertStyle backgoundTapDismissEnable:(BOOL)backgoundTapDismissEnable usingSpring:(BOOL)usingSpring;

- (void)showToView:(UIView *)view alertStyle:(LFAlertStyle)alertStyle backgoundTapDismissEnable:(BOOL)backgoundTapDismissEnable usingSpring:(BOOL)usingSpring tapBlock:(LFAlertBlock)tapBlock;

- (void)showToView:(UIView *)view alertStyle:(LFAlertStyle)alertStyle backgoundTapDismissEnable:(BOOL)backgoundTapDismissEnable usingSpring:(BOOL)usingSpring tapBlock:(LFAlertBlock)tapBlock dismissBlock:(LFAlertBlock)dismissBlock;


- (void)hideToView;

- (void)hideToView:(BOOL)animated;

+ (BOOL)hideAlertForView:(UIView *)view;

+ (BOOL)hideAlertForView:(UIView *)view animated:(BOOL)animated;

@end

NS_ASSUME_NONNULL_END
