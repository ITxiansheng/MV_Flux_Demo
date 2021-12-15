//
//  ZHMVPPresenter.m
//  MV_Flux_Demo_Example
//
//  Created by ITxiansheng on 2021/12/14.
//  Copyright © 2021 itxiansheng. All rights reserved.
//

#import "ZHMVPPresenter.h"
#import "ZHMVPProtocol.h"
#import "ZHMVPService.h"
#import <MJRefresh.h>
#import "ZHMVPCellTableViewCell.h"
#import "ZHMVPModel.h"

@interface ZHMVPPresenter ()<ZHMVPProtocol>

@property (nonatomic,weak) UITableView *testTableView;
@property (nonatomic,strong) NSMutableArray *dataArr;
@property (nonatomic,strong) ZHMVPService *service;
@property (nonatomic,weak) id <ZHMVPProtocol>control;

@end

@implementation ZHMVPPresenter

//进行控制器和视图绑定
-(void)bindTableView:(UITableView*)testTableView control:(id<ZHMVPProtocol>)control{
    __weak typeof (self) weakSelf = self;
    self.testTableView = testTableView;
    self.control = control;
    self.testTableView.delegate = self;
    self.testTableView.dataSource = self;
    self.testTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf reloadData];
    }];
}

//进行网络数据的加载
-(void)loadDataWithSuccessblock:(Block)successBlock{
    
    __weak typeof (self) weakSelf = self;
    self.service = [[ZHMVPService alloc] init];
    if ([self.control respondsToSelector:@selector(showLoadingTip)]) {
        [self.control showLoadingTip];
    }
    
    [self.service loadDataWithSuccessBlcok:^(NSArray * dataArr) {
        for (int i = 0; i < dataArr.count; i ++) {
            ZHMVPModel *testModel = [ZHMVPModel new];
            testModel.num = [dataArr[i] integerValue];
            [weakSelf.dataArr addObject:testModel];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            if ([weakSelf.control respondsToSelector:@selector(hideLoadingTip)]) {
                [weakSelf.control hideLoadingTip];
            }
            if (successBlock) {
                successBlock();
            }
        });
    }];
}

-(void)reloadData{
    __weak typeof (self) weakSelf = self;
    if ([self.control respondsToSelector:@selector(showLoadingTip)]) {
        [self.control showLoadingTip];
    }
    [self.dataArr removeAllObjects];
    [self.service loadDataWithSuccessBlcok:^(NSArray * dataArr) {
        for (int i = 0; i < dataArr.count; i ++) {
            ZHMVPModel *testModel = [ZHMVPModel new];
            testModel.num = [dataArr[i] integerValue];
            [weakSelf.dataArr addObject:testModel];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            if ([weakSelf.control respondsToSelector:@selector(hideLoadingTip)]) {
                [weakSelf.control hideLoadingTip];
            }
            [weakSelf.testTableView reloadData];
            [weakSelf.testTableView.mj_header endRefreshing];
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
    ZHMVPModel *testModel = self.dataArr[indexPath.row];
    ZHMVPCellTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ZHMVPCellTableViewCell"];
    if(!cell){
        cell=[[ZHMVPCellTableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"ZHMVPCellTableViewCell"];
    }
    cell.titleL.text = [@"计数值为:" stringByAppendingString: [@(testModel.num) stringValue]];
    cell.indexPath = indexPath;
    cell.delegate = self;
    return cell;
}

#pragma mark 实现cell点击代理
-(void)clickAddBtnWithIndex:(NSIndexPath *)indexPath{
    ZHMVPModel *testModel = self.dataArr[indexPath.row];
    testModel.num ++;
    [self.testTableView reloadData];
}

-(void)clickReduceBtnWithIndex:(NSIndexPath *)indexPath{
    ZHMVPModel *testModel = self.dataArr[indexPath.row];
    testModel.num --;
    [self.testTableView reloadData];
}

#pragma mark 懒加载
-(NSMutableArray *)dataArr{
    if (!_dataArr) {
        _dataArr = @[].mutableCopy;
    }
    return _dataArr;
}


@end
