//
//  UIView+LFAlertView.m
//  LFAlert
//
//  Created by Farben on 2020/8/13.
//  Copyright © 2020 Farben. All rights reserved.
//

#import "UIView+LFAlertView.h"
#import <objc/runtime.h>

@implementation UIView (LFAlertView)

static const char LF_MANAGER = '\0';
- (void)setLf_manager:(LFAlertManager *)lf_manager {
    objc_setAssociatedObject(self, &LF_MANAGER, lf_manager, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (LFAlertManager *)lf_manager {
    return objc_getAssociatedObject(self, &LF_MANAGER);
}

#pragma mark -Class
+ (BOOL)hideAlertForView:(UIView *)view {
    return [self hideAlertForView:view animated:YES];
}

+ (BOOL)hideAlertForView:(UIView *)view animated:(BOOL)animated {
    UIView *hud = [self alertForView:view];
    if (hud != nil) {
        [hud hideToView:animated];
        return YES;
    }
    return NO;
}

+ (UIView *)alertForView:(UIView *)view {
    NSEnumerator *subviewsEnum = [view.subviews reverseObjectEnumerator];
    for (UIView *subview in subviewsEnum) {
        if ([subview isKindOfClass:self]) {
            return subview;
        }
    }
    return nil;
}

#pragma mark -Utility
- (void)showAlertStyle:(LFAlertStyle)alertStyle {
    [self showToView:nil alertStyle:alertStyle backgoundTapDismissEnable:NO usingSpring:NO tapBlock:nil dismissBlock:nil];
}

- (void)showAlertStyle:(LFAlertStyle)alertStyle backgoundTapDismissEnable:(BOOL)backgoundTapDismissEnable {
    [self showToView:nil alertStyle:alertStyle backgoundTapDismissEnable:backgoundTapDismissEnable usingSpring:NO tapBlock:nil dismissBlock:nil];
}

- (void)showAlertStyle:(LFAlertStyle)alertStyle backgoundTapDismissEnable:(BOOL)backgoundTapDismissEnable usingSpring:(BOOL)usingSpring {
    [self showToView:nil alertStyle:alertStyle backgoundTapDismissEnable:backgoundTapDismissEnable usingSpring:usingSpring tapBlock:nil dismissBlock:nil];
}

- (void)showAlertStyle:(LFAlertStyle)alertStyle backgoundTapDismissEnable:(BOOL)backgoundTapDismissEnable usingSpring:(BOOL)usingSpring tapBlock:(LFAlertBlock)tapBlock {
    [self showToView:nil alertStyle:alertStyle backgoundTapDismissEnable:backgoundTapDismissEnable usingSpring:usingSpring tapBlock:tapBlock dismissBlock:nil];
}

- (void)showAlertStyle:(LFAlertStyle)alertStyle backgoundTapDismissEnable:(BOOL)backgoundTapDismissEnable usingSpring:(BOOL)usingSpring tapBlock:(LFAlertBlock)tapBlock dismissBlock:(LFAlertBlock)dismissBlock {
    [self showToView:nil alertStyle:alertStyle backgoundTapDismissEnable:backgoundTapDismissEnable usingSpring:usingSpring tapBlock:tapBlock dismissBlock:dismissBlock];
}

- (void)showToView:(UIView *)view alertStyle:(LFAlertStyle)alertStyle {
    [self showToView:view alertStyle:alertStyle backgoundTapDismissEnable:NO usingSpring:NO tapBlock:nil dismissBlock:nil];
}

- (void)showToView:(UIView *)view alertStyle:(LFAlertStyle)alertStyle backgoundTapDismissEnable:(BOOL)backgoundTapDismissEnable {
    [self showToView:view alertStyle:alertStyle backgoundTapDismissEnable:backgoundTapDismissEnable usingSpring:NO tapBlock:nil dismissBlock:nil];
}

- (void)showToView:(UIView *)view alertStyle:(LFAlertStyle)alertStyle backgoundTapDismissEnable:(BOOL)backgoundTapDismissEnable usingSpring:(BOOL)usingSpring {
    [self showToView:view alertStyle:alertStyle backgoundTapDismissEnable:backgoundTapDismissEnable usingSpring:usingSpring tapBlock:nil dismissBlock:nil];
}

- (void)showToView:(UIView *)view alertStyle:(LFAlertStyle)alertStyle backgoundTapDismissEnable:(BOOL)backgoundTapDismissEnable usingSpring:(BOOL)usingSpring tapBlock:(LFAlertBlock)tapBlock {
    [self showToView:view alertStyle:alertStyle backgoundTapDismissEnable:backgoundTapDismissEnable usingSpring:usingSpring tapBlock:tapBlock dismissBlock:nil];
}

- (void)showToView:(UIView *)view alertStyle:(LFAlertStyle)alertStyle backgoundTapDismissEnable:(BOOL)backgoundTapDismissEnable usingSpring:(BOOL)usingSpring tapBlock:(LFAlertBlock)tapBlock dismissBlock:(LFAlertBlock)dismissBlock {
    LFAlertManager *manager = [[LFAlertManager alloc] initWithSuperview:view alertView:self];
    manager.alertStyle = alertStyle;
    manager.backgroundTapDismissEnable = backgoundTapDismissEnable;
    manager.usingSpring = usingSpring;
    manager.tapBlock = tapBlock;
    manager.dismissBlock = dismissBlock;
    [manager show];
    self.lf_manager = manager;
}

- (void)hideToView {
    [self hideToView:YES];
}

- (void)hideToView:(BOOL)animated {
    if (self.lf_manager) {
        [self.lf_manager hide:animated];
    }
}

@end
