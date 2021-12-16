//
//  ZHFLUXStore.h
//  MV_Flux_Demo_Example
//
//  Created by ITxiansheng on 2021/12/16.
//  Copyright © 2021 ITxiansheng. All rights reserved.
//

#import "FluxStore.h"
#import "ZHFLUXModel.h"
@class ZHFLUXStore;

NS_ASSUME_NONNULL_BEGIN

@protocol ZHFLUXStoreDelegate <NSObject>

- (void)storeRefreshCompleted:(ZHFLUXStore *)store;

- (void)storeAdd:(ZHFLUXStore *)store;

- (void)storeReduce:(ZHFLUXStore *)store;

@end

@interface ZHFLUXStore : FluxStore<FluxStore>

@property (nonatomic,strong)id<ZHFLUXStoreDelegate> delegate;

@property (nonatomic, strong) NSArray<ZHFLUXModel *> *dataArray;

- (instancetype)initWithIdentifier:(nullable __kindof UIViewController *)identifier;

@end

NS_ASSUME_NONNULL_END
