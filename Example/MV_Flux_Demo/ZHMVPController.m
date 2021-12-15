//
//  ZHMVPController.m
//  MV_Flux_Demo_Example
//
//  Created by ITxiansheng on 2021/12/14.
//  Copyright © 2021 itxiansheng. All rights reserved.
//

#import "ZHMVPController.h"
#import "ZHMVPPresenter.h"
#import "ZHMVPProtocol.h"

@interface ZHMVPController ()<ZHMVPProtocol>

@property (nonatomic, strong) ZHMVPPresenter *presenter;
@property (nonatomic, strong) UITableView *testTableView;
@property (nonatomic, strong) UIActivityIndicatorView *indicatorView;

@end

@implementation ZHMVPController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor cyanColor];
    
    __weak typeof(self) weakSelf = self;
    [self.presenter bindTableView:self.testTableView control:self];
    [self.view addSubview:self.testTableView];
    [self.view addSubview:self.indicatorView];

    //调用presenter加载数据的方法模拟数据加载
    [self.presenter loadDataWithSuccessblock:^() {
        [weakSelf.testTableView reloadData];
    }];
}

#pragma mark 实现协议方法
- (void)showLoadingTip {
    [self.indicatorView startAnimating];
    self.indicatorView.hidden = NO;
}

- (void)hideLoadingTip {
    [self.indicatorView stopAnimating];
}

#pragma mark 懒加载
-(UITableView *)testTableView{
    if (!_testTableView) {
        _testTableView = [[UITableView alloc] initWithFrame:CGRectMake(0,20,[UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 20) style:UITableViewStylePlain];
        [_testTableView registerNib:[UINib nibWithNibName:@"TestCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"TestCell"];
    }
    return _testTableView;
}

-(ZHMVPPresenter *)presenter{
    if (!_presenter) {
        _presenter = [[ZHMVPPresenter alloc] init];
    }
    return _presenter;
}

- (UIActivityIndicatorView *)indicatorView {
    if (!_indicatorView) {
        _indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        _indicatorView.center = self.view.center;
        _indicatorView.hidesWhenStopped = YES;
    }
    return _indicatorView;
}

@end
