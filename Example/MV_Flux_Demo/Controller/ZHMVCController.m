//
//  ZHMVCController.m
//  MV_Flux_Demo_Example
//
//  Created by ITxiansheng on 2021/12/15.
//  Copyright © 2021 itxiansheng. All rights reserved.
//

#import "ZHMVCController.h"
#import "ZHMVCService.h"
#import "ZHMVCModel.h"
#import <MJRefresh.h>
#import "ZHMVCCellTableViewCell.h"

@interface ZHMVCController ()<ZHMVCCellTableViewCellDelegate,UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *testTableView;
@property (nonatomic, strong) UIActivityIndicatorView *indicatorView;
@property (nonatomic, strong) ZHMVCService *service;
@property (nonatomic, strong) NSMutableArray <ZHMVCModel *> *dataArr;

@end

@implementation ZHMVCController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor cyanColor];
    
    [self.view addSubview:self.testTableView];
    [self.view addSubview:self.indicatorView];
    __weak typeof (self) weakSelf = self;
    self.testTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf loadData];
    }];
    [self loadData];
}

- (void)loadData
{
    __weak typeof (self) weakSelf = self;
    self.service = [[ZHMVCService alloc] init];
    [self showLoadingTip];
    
    [self.service loadDataWithSuccessBlcok:^(NSArray * dataArr) {
        for (int i = 0; i < dataArr.count; i ++) {
            ZHMVCModel *testModel = [ZHMVCModel new];
            testModel.num = [dataArr[i] integerValue];
            [weakSelf.dataArr addObject:testModel];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf hideLoadingTip];
            [weakSelf.testTableView.mj_header endRefreshing];
            [weakSelf.testTableView reloadData];
        });
    }];
}

#pragma mark tableView代理
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ZHMVCModel *testModel = self.dataArr[indexPath.row];
    ZHMVCCellTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ZHMVCCellTableViewCell"];
    if(!cell){
        cell=[[ZHMVCCellTableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"ZHMVPCellTableViewCell"];
    }
    cell.titleL.text = [@"计数值为:" stringByAppendingString: [@(testModel.num) stringValue]];
    cell.indexPath = indexPath;
    cell.delegate = self;
    return cell;
}

#pragma mark - indicator

- (void)showLoadingTip {
    [self.indicatorView startAnimating];
    self.indicatorView.hidden = NO;
}

- (void)hideLoadingTip {
    [self.indicatorView stopAnimating];
    self.indicatorView.hidden = YES;
}

#pragma mark - ZHMVCCellTableViewCellDelegate

-(void)clickAddBtnWithIndex:(NSIndexPath*)indexPath
{
    ZHMVCModel *testModel = self.dataArr[indexPath.row];
    testModel.num ++;
    [self.testTableView reloadData];

}
-(void)clickReduceBtnWithIndex:(NSIndexPath*)indexPath
{
    ZHMVCModel *testModel = self.dataArr[indexPath.row];
    testModel.num --;
    [self.testTableView reloadData];
}

#pragma mark - 懒加载

- (NSMutableArray *)dataArr
{
    if (!_dataArr) {
        _dataArr = [NSMutableArray new];
    }
    return _dataArr;
}

- (ZHMVCService *)service
{
    if (!_service) {
        _service = [ZHMVCService new];
    }
    return _service;
}

-(UITableView *)testTableView
{
    if (!_testTableView) {
        _testTableView = [[UITableView alloc] initWithFrame:CGRectMake(0,20,[UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 20) style:UITableViewStylePlain];
        _testTableView.delegate = self;
        _testTableView.dataSource = self;
        [_testTableView registerNib:[UINib nibWithNibName:@"TestCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"TestCell"];
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
