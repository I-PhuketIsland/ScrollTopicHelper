//
//  ViewController.m
//  TableView
//
//  Created by Lee on 2017/2/28.
//  Copyright © 2017年 李家乐. All rights reserved.
//

#import "ViewController.h"
#import "ScrollTopicVIew.h"
#import <Masonry.h>
#import "UIView+Frame.h"


@interface ViewController ()<ScrollViewEndDelegate>
/*
 <#name#>: <#description#>
 */
@property (nonatomic, strong) ScrollTopicVIew *s;
/*
 <#name#>: <#description#>
 */
@property (nonatomic, assign) NSInteger i;
/*
 <#name#>: <#description#>
 */
@property (nonatomic, strong) NSMutableArray* arr;
/*
 <#name#>: <#description#>
 */
@property (nonatomic, assign) CGFloat height;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //不要让他自动设置位置
    self.automaticallyAdjustsScrollViewInsets = NO;
    _arr = [NSMutableArray new];
    [self setupView];
    _i = 0;
    _s = [[ScrollTopicVIew alloc]initWithTItle:@[@"1",@"2",@"3",@"4",@"5",@"6"]];
    _s.sVEDelegate = self;
    
    [self.view addSubview:_s];
    _height = 100;
    [_s mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).mas_offset(_height);
        make.bottom.equalTo(self.view);
        make.width.equalTo(self.view);
    }];
    [self scrollViewEndScrollingAnimation:_s.topicContentView];
    
}
- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
   
}
- (void)setupView {
    UIView * v1 = [[UIView alloc]initWithFrame:self.view.bounds];
    v1.backgroundColor = [UIColor blackColor];
    [_arr addObject:v1];
    
    UIView * v2 = [[UIView alloc]initWithFrame:self.view.bounds];
    v2.backgroundColor = [UIColor blueColor];
    [_arr addObject:v2];
    
    UIView * v3 = [[UIView alloc]initWithFrame:self.view.bounds];
    v3.backgroundColor = [UIColor whiteColor];
    [_arr addObject:v3];
    
    UIView * v4 = [[UIView alloc]initWithFrame:self.view.bounds];
    v4.backgroundColor = [UIColor orangeColor];
    [_arr addObject:v4];
    
    UIView * v5 = [[UIView alloc]initWithFrame:self.view.bounds];
    v5.backgroundColor = [UIColor greenColor];
    [_arr addObject:v5];
    
    UIView * v6 = [[UIView alloc]initWithFrame:self.view.bounds];
    v6.backgroundColor = [UIColor redColor];
    [_arr addObject:v6];
}
- (void)scrollViewEndScrollingAnimation:(UIScrollView*)scrollView {
    [self.view layoutIfNeeded];
    NSInteger index = scrollView.contentOffset.x / scrollView.width;
    UIView *v = _arr[index];
    [scrollView addSubview:v];
    [v mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(scrollView.contentOffset.x);
        make.height.equalTo(scrollView);
        make.width.equalTo(scrollView);
    }];
}
- (IBAction)btn:(id)sender {
    if (_i%2 == 0) {
        _height = 50;
        [_s mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.view).mas_offset(_height);
        }];
    }else {
        _height = 100;
        [_s mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.view).mas_offset(_height);
        }];
    }
    [UIView animateWithDuration:1 animations:^{
        [self.view layoutIfNeeded];

    }];
    
    _i ++;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
