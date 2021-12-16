//
//  ZHADFLUXController.m
//  MV_Flux_Demo_Example
//
//  Created by ITxiansheng on 2021/12/16.
//  Copyright © 2021 ITxiansheng. All rights reserved.
//

#import "ZHADFLUXController.h"
#import "ZHADActionCreator.h"
#import "ZHFLUXStore.h"
#import <MJRefresh.h>
#import "FluxDispatcher.h"
#import "ZHADFluxCell.h"

@interface ZHADFLUXController ()<ZHFLUXStoreDelegate,UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *testTableView;
@property (nonatomic, strong) UIActivityIndicatorView *indicatorView;

@property (nonatomic,strong) ZHFLUXStore *store;
@property (nonatomic,strong) ZHADActionCreator *creator;//model

@end

@implementation ZHADFLUXController

- (void)viewDidLoad {
    [super viewDidLoad];
    _store =[[ZHFLUXStore alloc]initWithIdentifier:self];
    _store.delegate = self;
    _creator = [[ZHADActionCreator alloc]initWithActionIdentifier:[NSString stringWithFormat:@"%p", self]];
    [FluxDispatcher registerStore:_store];
    self.view.backgroundColor = [UIColor cyanColor];
    [self.view addSubview:self.testTableView];
    [self.view addSubview:self.indicatorView];
    
    self.indicatorView.hidden = NO;
    [self.indicatorView startAnimating];
    [_creator refreshList];
}

#pragma mark - tableview datasource / delegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.store.dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ZHADFluxCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ZHADFluxCell"];
    if(!cell){
        cell=[[ZHADFluxCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"ZHADFluxCell"];
    }
    cell.indexPath = indexPath;
    [cell setStore:self.store];
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

#pragma mark - ZHFLUXStoreDelegate

- (void)storeRefreshCompleted:(ZHFLUXStore *)store
{
    [self.indicatorView stopAnimating];
    self.indicatorView.hidden = YES;
    [self.testTableView.mj_header endRefreshing];
    [self.testTableView reloadData];
}

- (void)storeAdd:(ZHFLUXStore *)store
{
    [self.testTableView reloadData];
}

- (void)storeReduce:(ZHFLUXStore *)store
{
    [self.testTableView reloadData];
}

#pragma mark - view gettr

-(UITableView *)testTableView
{
    if (!_testTableView) {
        _testTableView = [[UITableView alloc] initWithFrame:CGRectMake(0,20,[UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 20) style:UITableViewStylePlain];
        _testTableView.delegate = self;
        _testTableView.dataSource = self;
        [_testTableView registerNib:[UINib nibWithNibName:@"TestCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"TestCell"];
        __weak typeof (self) weakSelf = self;
        _testTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            weakSelf.indicatorView.hidden = NO;
            [weakSelf.indicatorView startAnimating];
            [weakSelf.creator refreshList];
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
