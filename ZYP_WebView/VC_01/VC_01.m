//
//  VC_01.m
//  ZYP_WebView
//
//  Created by 赵云鹏 on 2017/11/7.
//  Copyright © 2017年 赵云鹏. All rights reserved.
//

#import "VC_01.h"
#import "TestVC.h"

@interface VC_01 ()

@end

@implementation VC_01

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIButton *button = [[UIButton alloc]init];
    button.backgroundColor = [UIColor orangeColor];
    [button addTarget:self action:@selector(onClickBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(30);
        make.top.equalTo(self.view).offset(60 + 40);
    }];
    
}

- (void)onClickBtn:(UIButton *)btn {
    NSLog(@"123");
    
    
}




@end
