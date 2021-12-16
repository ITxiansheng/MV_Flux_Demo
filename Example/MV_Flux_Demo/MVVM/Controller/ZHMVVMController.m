//
//  ZHMVVMController.m
//  MV_Flux_Demo_Example
//
//  Created by ITxiansheng on 2021/12/15.
//  Copyright © 2021 wangbaojun. All rights reserved.
//

#import "ZHMVVMController.h"
#import <MJRefresh.h>
#import "ZHMVVMViewModel.h"
#import "ZHMVVMCell.h"

@interface ZHMVVMController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *testTableView;
@property (nonatomic, strong) UIActivityIndicatorView *indicatorView;
@property (nonatomic, strong) ZHMVVMViewModel *viewModel;

@end

@implementation ZHMVVMController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor cyanColor];
    [self.view addSubview:self.testTableView];
    [self.view addSubview:self.indicatorView];
    [self bindViewModel];
}

- (void)bindViewModel {
    self.viewModel = [ZHMVVMViewModel new];
    [[[self.viewModel.refreshDataCommand.executing skip:1] take:1] subscribeNext:^(id x) {
        self.indicatorView.hidden = NO;
        [self.indicatorView startAnimating];
    }];
    [self.viewModel.refreshDataCommand execute:nil];
    @weakify(self);
    [self.viewModel.refreshEndSubject subscribeNext:^(id x) {
        @strongify(self);
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.testTableView.mj_header endRefreshing];
            [self.indicatorView stopAnimating];
            self.indicatorView.hidden = YES;
            [self.testTableView reloadData];
        });
    }];
}

#pragma mark - tableView代理

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.viewModel.dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ZHMVVMCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ZHMVVMCell"];
    if(!cell){
        cell=[[ZHMVVMCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"ZHMVVMCell"];
    }
    ZHMVVMCellViewModel *cellViewModel = [ZHMVVMCellViewModel new];
    cellViewModel.model = self.viewModel.dataArray[indexPath.row];
    [cell setViewModel:cellViewModel];
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%@",NSStringFromSelector(_cmd));
}
- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section API_AVAILABLE(ios(6.0))
{
    NSLog(@"%@",NSStringFromSelector(_cmd));
}
- (void)tableView:(UITableView *)tableView willDisplayFooterView:(UIView *)view forSection:(NSInteger)section API_AVAILABLE(ios(6.0))
{
    NSLog(@"%@",NSStringFromSelector(_cmd));
}
- (void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath*)indexPath API_AVAILABLE(ios(6.0))
{
    NSLog(@"%@",NSStringFromSelector(_cmd));
}
- (void)tableView:(UITableView *)tableView didEndDisplayingHeaderView:(UIView *)view forSection:(NSInteger)section API_AVAILABLE(ios(6.0))
{
    NSLog(@"%@",NSStringFromSelector(_cmd));
}
- (void)tableView:(UITableView *)tableView didEndDisplayingFooterView:(UIView *)view forSection:(NSInteger)section API_AVAILABLE(ios(6.0))
{
    NSLog(@"%@",NSStringFromSelector(_cmd));
}

-(UITableView *)testTableView
{
    if (!_testTableView) {
        _testTableView = [[UITableView alloc] initWithFrame:CGRectMake(0,20,[UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 20) style:UITableViewStylePlain];
        _testTableView.delegate = self;
        _testTableView.dataSource = self;
        [_testTableView registerNib:[UINib nibWithNibName:@"TestCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"TestCell"];
        @weakify(self);
        _testTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            @strongify(self);
            [self.viewModel.refreshDataCommand execute:nil];
        }];

    }
    return _testTableView;
}

- (UIActivityIndicatorView *)indicatorView
{
    if (!_indicatorView) {
        _indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        _indicatorView.center = self.view.center;
        _indicatorView.hidesWhenStopped = YES;
    }
    return _indicatorView;
}

@end
