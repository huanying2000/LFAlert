//
//  ViewController.m
//  LFAlert
//
//  Created by Farben on 2020/8/13.
//  Copyright © 2020 Farben. All rights reserved.
//

#import "ViewController.h"
#import "UIView+LFAlertView.h"
#import "MenuView.h"

#define SCREEN_HEIGHT   [[UIScreen mainScreen] bounds].size.height
#define SCREEN_WIDTH    [[UIScreen mainScreen] bounds].size.width

@interface ViewController ()

@property (nonatomic,strong) UIView *menu;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - 350) / 2, 100, 350, 400)];
    view.backgroundColor = [UIColor redColor];
    self.menu = view;
    [self.view addSubview:self.menu];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position.y"];
    NSValue *value1 = @(300 - 20);
    NSValue *value2 = @(300);
    animation.values = @[value1,value2,value1,value2,value1,value2];
    animation.duration = 1.5;
    animation.repeatCount = 1;
    animation.removedOnCompletion = NO;
    [self.menu.layer addAnimation:animation forKey:nil];
//    MenuView *menu = [[MenuView alloc] initWithFrame:CGRectMake(0, 0, 280, 350)];
//    [menu showAlertStyle:LFAlertStyleAlert backgoundTapDismissEnable:YES usingSpring:NO];
}


@end
