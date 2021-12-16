//
//  ZHMVVMViewModel.m
//  MV_Flux_Demo_Example
//
//  Created by ITxiansheng on 2021/12/15.
//  Copyright © 2021 ITxiansheng. All rights reserved.
//

#import "ZHMVVMViewModel.h"
#import "ZHMVVMService.h"
#import "ZHMVCModel.h"

@interface ZHMVVMViewModel ()

@property (nonatomic, strong)ZHMVVMService *service;

@end

@implementation ZHMVVMViewModel

- (instancetype)init {
    if (self = [super init]) {
        _service = [ZHMVVMService new];
        [self setRACSignal];
    }
    return self;
}

- (void)setRACSignal {
    //处理登录点击:创建登录命令。（只要处理事件，就要用到RACCommand）
    @weakify(self);
    [self.refreshDataCommand.executionSignals.switchToLatest subscribeNext:^(NSArray *array) {
        @strongify(self);
        self.dataArray = array;
        [self.refreshEndSubject sendNext:@(YES)];
    }];
}

- (RACSubject *)refreshEndSubject {
    
    if (!_refreshEndSubject) {
        _refreshEndSubject = [RACSubject subject];
    }
    return _refreshEndSubject;
}

- (RACCommand *)refreshDataCommand {
    
    if (!_refreshDataCommand) {
        @weakify(self);
        _refreshDataCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            @strongify(self);
            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                @strongify(self);
                [self.service loadDataWithSuccessBlcok:^(NSArray * dataArray) {
                    NSMutableArray *array = [NSMutableArray new];
                    for (NSString *num in dataArray) {
                        ZHMVCModel *testModel = [ZHMVCModel new];
                        testModel.num = [num integerValue];
                        [array addObject:testModel];
                    }
                    [subscriber sendNext:[array copy]];
                    [subscriber sendCompleted];
                }];
                return nil;
            }];
        }];
    }
    return _refreshDataCommand;
}

@end
