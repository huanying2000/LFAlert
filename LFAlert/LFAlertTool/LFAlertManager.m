//
//  LFAlertManager.m
//  LFAlert
//
//  Created by Farben on 2020/8/13.
//  Copyright © 2020 Farben. All rights reserved.
//

#import "LFAlertManager.h"

#define IOS_OR_LATER(v) ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SCREEN_HEIGHT   [[UIScreen mainScreen] bounds].size.height
#define SCREEN_WIDTH    [[UIScreen mainScreen] bounds].size.width

#define GX_ALERT_ANIMATION_DURATION   0.5
#define GX_ALERT_USINGSPRING_DAMPING  0.7
#define GX_ALERT_USINGSPRING_VELOCITY 1.0

@interface LFAlertManager ()

@property (nonatomic,weak) UIView *superview;
@property (nonatomic,strong) UIView *backgroundView;
@property (nonatomic,   weak) UIView *alertView;

@end

@implementation LFAlertManager


- (instancetype)initWithSuperview:(UIView *)superview alertView:(UIView *)alertView {
    self = [super init];
    if (self) {
        self.superview = superview;
        self.alertView = alertView;
        [self createSubViews];
    }
    return self;
}

- (void)createSubViews {
    self.backgroundView = [[UIControl alloc] init];
    self.backgroundView.alpha = 0.0;
    self.backgroundView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    self.backgroundView.backgroundColor = [UIColor blackColor];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureRecognizer:)];
    [self.backgroundView addGestureRecognizer:tap];
}

- (void)show {
    if (!self.alertView.superview) {
        if (!self.superview) {
            self.superview = [UIApplication sharedApplication].windows.firstObject;
        }
        self.backgroundView.frame = self.superview.bounds;
        [self.superview addSubview:self.backgroundView];
        [self.superview addSubview:self.alertView];
    }
    CGFloat safeAreaBottom = 0;
    if (@available(iOS 11.0, *)) {
        safeAreaBottom = UIApplication.sharedApplication.keyWindow.safeAreaInsets.bottom;
    }
    switch (self.alertStyle) {
        case LFAlertStyleSheet: {
            CGRect frame = self.alertView.frame;
            frame.origin.y = self.backgroundView.frame.size.height;
            frame.size.width = self.backgroundView.frame.size.width;
            self.alertView.frame = frame;
            frame.origin.y = self.backgroundView.frame.size.height - self.alertView.frame.size.height - safeAreaBottom;
            [LFAlertManager lf_animateWithUsingSpring:self.usingSpring animations:^{
                self.backgroundView.alpha = 0.4;
                self.alertView.frame = frame;
            } completion:NULL];
        }
            break;
        case LFAlertStyleAlert: {
            self.alertView.alpha = 0;
            self.alertView.center = self.superview.center;
            self.alertView.transform = CGAffineTransformScale(self.alertView.transform, 0.1, 0.1);
            [LFAlertManager lf_animateWithUsingSpring:self.usingSpring animations:^{
                self.backgroundView.alpha = 0.4;
                self.alertView.transform = CGAffineTransformIdentity;
                self.alertView.alpha = 1.0;
            } completion:NULL];
        }
            break;
        case LFAlertStyleSheetTop: {
            CGRect frame = self.alertView.frame;
            frame.origin.y = -self.alertView.frame.size.height;
            frame.size.width = self.backgroundView.frame.size.width;
            self.alertView.frame = frame;
            frame.origin.y = 0;
            [LFAlertManager lf_animateWithUsingSpring:self.usingSpring animations:^{
                self.backgroundView.alpha = 0.4;
                self.alertView.frame = frame;
            } completion:NULL];
        }
            break;
        case LFAlertStyleSheetLeft: {
            CGRect frame = self.alertView.frame;
            frame.origin.x = -self.alertView.frame.size.width;
            frame.size.height = self.superview.frame.size.height;
            self.alertView.frame = frame;
            frame.origin.x = 0;
            [LFAlertManager lf_animateWithUsingSpring:self.usingSpring animations:^{
                self.backgroundView.alpha = 0.4;
                self.alertView.frame = frame;
            } completion:NULL];
        }
            break;
        case LFAlertStyleSheetRight: {
            CGRect frame = self.alertView.frame;
            frame.origin.x = self.superview.frame.size.width;
            frame.size.height = self.superview.frame.size.height;
            self.alertView.frame = frame;
            frame.origin.x = self.superview.frame.size.width - self.alertView.frame.size.width;
            [LFAlertManager lf_animateWithUsingSpring:self.usingSpring animations:^{
                 self.backgroundView.alpha = 0.4;
                 self.alertView.frame = frame;
            } completion:NULL];
        }
            break;
    }
}

- (void)hide:(BOOL)animated {
    if (!self.superview)
        return;
    if (!animated) {
        [self.backgroundView removeFromSuperview];
        [self.alertView removeFromSuperview];
        if (self.dismissBlock) {
            self.dismissBlock(self);
        }
        return;
    }
    switch (self.alertStyle) {
        case LFAlertStyleSheet: {
            CGRect frame = self.alertView.frame;
            frame.origin.y = self.backgroundView.frame.size.height;
            [UIView animateWithDuration:GX_ALERT_ANIMATION_DURATION/2.0 animations:^{
                 self.backgroundView.alpha = 0.0;
                 self.alertView.frame = frame;
             } completion:^(BOOL finished) {
                 if (finished) {
                     [self.backgroundView removeFromSuperview];
                     [self.alertView removeFromSuperview];
                 }
             }];
        }
            break;
        case LFAlertStyleAlert: {
            [UIView animateWithDuration:GX_ALERT_ANIMATION_DURATION/2.0 animations:^{
                self.backgroundView.alpha = 0.0;
                self.alertView.transform = CGAffineTransformScale(self.alertView.transform,0.1,0.1);
                self.alertView.alpha = 0.0;
            } completion:^(BOOL finished) {
                if (finished) {
                    [self.backgroundView removeFromSuperview];
                    [self.alertView removeFromSuperview];
                }
            }];
        }
            break;
        case LFAlertStyleSheetTop: {
            CGRect frame = self.alertView.frame;
            frame.origin.y = -self.alertView.frame.size.height;
            [UIView animateWithDuration:GX_ALERT_ANIMATION_DURATION/2.0 animations:^{
                self.backgroundView.alpha = 0.0;
                self.alertView.frame = frame;
            } completion:^(BOOL finished) {
                if (finished) {
                    [self.backgroundView removeFromSuperview];
                    [self.alertView removeFromSuperview];
                }
            }];
        }
            break;
        case LFAlertStyleSheetLeft: {
            CGRect frame = self.alertView.frame;
            frame.origin.x = -self.superview.frame.size.width;
            [UIView animateWithDuration:GX_ALERT_ANIMATION_DURATION/2.0 animations:^{
                self.backgroundView.alpha = 0.0;
                self.alertView.frame = frame;
            } completion:^(BOOL finished) {
                if (finished) {
                    [self.backgroundView removeFromSuperview];
                    [self.alertView removeFromSuperview];
                }
            }];
        }
                break;
        case LFAlertStyleSheetRight: {
            CGRect frame = self.alertView.frame;
            frame.origin.x = self.superview.frame.size.width;
            [UIView animateWithDuration:GX_ALERT_ANIMATION_DURATION/2.0 animations:^{
                self.backgroundView.alpha = 0.0;
                self.alertView.frame = frame;
            } completion:^(BOOL finished) {
                if (finished) {
                    [self.backgroundView removeFromSuperview];
                    [self.alertView removeFromSuperview];
                }
            }];
        }
            break;
    }
    if (self.dismissBlock) {
        self.dismissBlock(self);
    }
}

+ (void) lf_animateWithUsingSpring:(BOOL)usingSpring animations:(void (^)(void))animations completion:(void (^ __nullable)(BOOL finished))completion {
    if (usingSpring) {
        [UIView animateWithDuration:GX_ALERT_ANIMATION_DURATION
                         delay:0
        usingSpringWithDamping:GX_ALERT_USINGSPRING_DAMPING
         initialSpringVelocity:GX_ALERT_USINGSPRING_VELOCITY
                       options:UIViewAnimationOptionCurveEaseInOut
                    animations:animations
                    completion:completion];
    }else {
        [UIView animateWithDuration:GX_ALERT_ANIMATION_DURATION/2 animations:animations completion:completion];
    }
}

#pragma mark -UITapGestureRecognizer
- (void)tapGestureRecognizer:(UITapGestureRecognizer*)tap {
    if (self.backgroundTapDismissEnable) {
        [self hide:YES];
        if (self.tapBlock) {
            self.tapBlock(self);
        }
    }
}

- (void)dealloc {
    _backgroundView = nil;
    _alertView = nil;
}

@end
