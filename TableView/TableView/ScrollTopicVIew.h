//
//  ScrollTopicVIew.h
//  TableView
//
//  Created by Lee on 2017/2/28.
//  Copyright © 2017年 李家乐. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ScrollViewEndDelegate <NSObject>

- (void)scrollViewEndScrollingAnimation:(UIScrollView*)scrollView;
/*
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
 */
@end

@interface ScrollTopicVIew : UIView
/*
 topicContentView: 内容视图
 */
@property (nonatomic, strong) UIScrollView* topicContentView;
/*
 <#name#>: <#description#>
 */
@property (nonatomic, assign) id<ScrollViewEndDelegate> sVEDelegate;

- (instancetype)initWithTItle:(NSArray *)arrTitle;
@end
/*初始化
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
*/
