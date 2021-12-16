//
//  ZHMVVMCellViewModel.m
//  MV_Flux_Demo_Example
//
//  Created by ITxiansheng on 2021/12/15.
//  Copyright © 2021 ITxiansheng. All rights reserved.
//

#import "ZHMVVMCellViewModel.h"

@implementation ZHMVVMCellViewModel


- (instancetype)init {
    if (self = [super init]) {
        [self setRACSignal];
    }
    return self;
}

- (void)setRACSignal {
    //处理登录点击:创建登录命令。（只要处理事件，就要用到RACCommand）
    [self.addSubject subscribeNext:^(id x) {
        NSLog(@"addSubject");
        self.model.num++;//修改model
        [self.resultSubject sendNext:@(self.model.num)];
    }];
    [self.reduceSubject subscribeNext:^(id x) {
        NSLog(@"reduce");
        self.model.num --;//修改model
        [self.resultSubject sendNext:@(self.model.num)];
    }];
}


#pragma mark - getter

- (RACSubject *)addSubject {
    
    if (!_addSubject) {
        _addSubject = [RACSubject subject];
    }
    return _addSubject;
}

- (RACSubject *)reduceSubject {
    
    if (!_reduceSubject) {
        _reduceSubject = [RACSubject subject];
    }
    return _reduceSubject;
}

- (RACSubject *)resultSubject {
    
    if (!_resultSubject) {
        _resultSubject = [RACSubject subject];
    }
    return _resultSubject;
}

@end
