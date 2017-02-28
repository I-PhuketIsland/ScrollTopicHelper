//
//  ScrollTopicVIew.m
//  TableView
//
//  Created by Lee on 2017/2/28.
//  Copyright © 2017年 李家乐. All rights reserved.
//
#define TopicTitle_height 44



#import "ScrollTopicVIew.h"
#import <Masonry.h>
#import "UIView+Frame.h"

@interface ScrollTopicVIew()<UIScrollViewDelegate>
/*
 topicTitleView: 顶部滚动视图
 */
@property (nonatomic, strong) UIScrollView* topicTitleView;

/*
 titleArr: 标题数组
 */
@property (nonatomic, strong) NSArray* titleArr;
/*
 <#name#>: <#description#>
 */
@property (nonatomic, strong) UIView* indicatorView;
/*
 <#name#>: <#description#>
 */
@property (nonatomic, strong) UIButton* currentButton;
@end

@implementation ScrollTopicVIew

- (instancetype)initWithTItle:(NSArray *)arrTitle {
    if (self = [super init]) {
        _titleArr = arrTitle;
        
        [self addSubview:self.topicTitleView];
        [self addSubview:self.topicContentView];
        [self.topicTitleView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top);
            make.width.equalTo(self.mas_width);
            make.height.mas_equalTo(TopicTitle_height);
        }];
        [self.topicContentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.topicTitleView.mas_bottom);
            make.bottom.equalTo(self.mas_bottom);
            make.width.equalTo(self.mas_width);
        }];
        
        [self setupTopicButton];
        
    }
    return self;
}
- (void)layoutSubviews {
    [super layoutSubviews];
}
- (void)setupTopicButton {
    
    UIView * indicatorView = [[UIView alloc]init];
    indicatorView.tag = 10;
    indicatorView.y = TopicTitle_height - 3;
    indicatorView.height = 3;
    indicatorView.backgroundColor = [UIColor blueColor];
    self.indicatorView = indicatorView;
    
    for (int i = 0; i < _titleArr.count; i ++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [btn setTitle:_titleArr[i] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:14 weight:UIFontWeightMedium];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blueColor] forState:UIControlStateDisabled];
        [btn.titleLabel sizeToFit];
        btn.height = TopicTitle_height;
        btn.width = _titleArr.count > 4 ? _topicTitleView.width / 4 : _topicTitleView.width / _titleArr.count;
        btn.y = 0;
        btn.x = btn.width * i;
        btn.tag = i;
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        if (i == 0) {
            btn.enabled = NO;
            self.currentButton = btn;
            self.indicatorView.width = btn.titleLabel.width;
            self.indicatorView.centerX = btn.centerX;
        }
        [self.topicTitleView addSubview:btn];
    }
    [self.topicTitleView addSubview:self.indicatorView];
}
- (void)btnClick:(UIButton *)sender {
    self.currentButton.enabled = YES;
    sender.enabled = NO;
    
    [UIView animateWithDuration:0.25 animations:^{
        self.indicatorView.centerX = sender.centerX;
        self.indicatorView.width = sender.titleLabel.width;
    }];
    CGFloat totalWidth = self.topicTitleView.contentSize.width;
    CGPoint titleOffset = self.topicTitleView.contentOffset;
    if (self.currentButton.tag < sender.tag) {
        if (sender.tag > 2 && (totalWidth - titleOffset.x) > self.width) {
            titleOffset.x = sender.x - sender.width;
            self.topicTitleView.contentOffset = titleOffset;
        }
    }else {
        if (sender.tag != 0) {
            if ((totalWidth - titleOffset.x) > self.width || sender.tag <= 2) {
                titleOffset.x = sender.x - sender.width;
                [self.topicTitleView setContentOffset:titleOffset animated:YES];
            }
        }
        
    }
    
    CGPoint contentOffset = self.topicContentView.contentOffset;
    contentOffset.x = self.topicContentView.width * sender.tag;
    [self.topicContentView setContentOffset:contentOffset animated:YES];
    
    [self scrollViewDidEndScrollingAnimation:self.topicContentView];
    self.currentButton = sender;
}
#pragma mark -scrollerViewDelegate 
//停止动画开始加载页面
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    [self.sVEDelegate scrollViewEndScrollingAnimation:scrollView];
}
//停止减速
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSInteger tag = scrollView.contentOffset.x / scrollView.width;
    UIButton *btn = self.topicTitleView.subviews[tag];
    [self btnClick:btn];
    [self scrollViewDidEndScrollingAnimation:scrollView];
}
#pragma mark -lazy init
- (UIScrollView *)topicTitleView {
    if (_topicTitleView == nil) {
        _topicTitleView = [[UIScrollView alloc]init];
        _topicTitleView.width = [UIScreen mainScreen].bounds.size.width;
        _topicTitleView.contentSize = _titleArr.count < 4 ? CGSizeMake(_topicTitleView.width, 0): CGSizeMake(_topicTitleView.width/4 * _titleArr.count, 0);
        _topicTitleView.showsHorizontalScrollIndicator = NO;
    }
    return _topicTitleView;
}
- (UIScrollView *)topicContentView {
    if (_topicContentView == nil) {
        _topicContentView = [[UIScrollView alloc]init];
        _topicContentView.width = [UIScreen mainScreen].bounds.size.width;
        _topicContentView.contentSize = CGSizeMake(_topicContentView.width * _titleArr.count, 0);
        _topicContentView.pagingEnabled = YES;
        _topicContentView.bounces = NO;
        _topicContentView.delegate = self;
        _topicContentView.showsHorizontalScrollIndicator = NO;
    }
    return _topicContentView;
}
- (NSArray *)titleArr {
    if (_titleArr == nil) {
        _titleArr = [NSArray new];
    }
    return _titleArr;
}
@end
