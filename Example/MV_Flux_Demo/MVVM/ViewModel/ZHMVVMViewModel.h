//
//  ZHMVVMViewModel.h
//  MV_Flux_Demo_Example
//
//  Created by ITxiansheng on 2021/12/15.
//  Copyright © 2021 wangbaojun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ReactiveCocoa/ReactiveCocoa.h>
@class ZHMVVMModel;

NS_ASSUME_NONNULL_BEGIN

@interface ZHMVVMViewModel : NSObject

@property (nonatomic, strong) RACSubject *refreshEndSubject;

@property (nonatomic, strong) RACCommand *refreshDataCommand;

@property (nonatomic, strong) NSArray<ZHMVVMModel *> *dataArray;

@end

NS_ASSUME_NONNULL_END
