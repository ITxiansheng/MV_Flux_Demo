//
//  ZHFLUXStore.m
//  MV_Flux_Demo_Example
//
//  Created by ITxiansheng on 2021/12/16.
//  Copyright © 2021 ITxiansheng. All rights reserved.
//

#import "ZHFLUXStore.h"
#import "FluxDispatcher.h"
#import "ZHRefreshAction.h"
#import "ZHOperationAction.h"

@implementation ZHFLUXStore

- (instancetype)initWithIdentifier:(UIViewController *)identifier
{
    NSString *storeIdentifier = identifier ? [NSString stringWithFormat:@"%p", identifier] : nil;
    if (self = [super initWithIdentifier:storeIdentifier]) {
    }
    return self;
}

- (void)dealloc
{
    [FluxDispatcher unregisterStore:self];
}

- (NSDictionary *)actionRecieverDict
{
    return @{NSStringFromClass([ZHOperationAction class]) :
                 NSStringFromSelector(@selector(handleOperationAction:)),
             NSStringFromClass([ZHRefreshAction class]) :
                 NSStringFromSelector(@selector(handleRefreshAction:))
    };
}


#pragma mark - handle Action

- (void)handleRefreshAction:(ZHRefreshAction *)action
{
    switch (action.type) {
        case ZHADRefreshActionTypeSucceed:
            [self handleRefreshData:action.data];
            break;
    }
}

- (void)handleOperationAction:(ZHOperationAction *)action
{
    switch (action.type) {
        case ZHADOperationActionTypeAdd:
            [self handleAdd:action.currendIndex];
            break;
        case ZHADOperationActionTypeReduce:
            [self handleReduce:action.currendIndex];
            break;
    }
}


- (void)handleRefreshData:(NSArray *)data
{
    NSMutableArray *array = [NSMutableArray new];
    for (NSString *num in data) {
        ZHFLUXModel *testModel = [ZHFLUXModel new];
        testModel.num = [num integerValue];
        [array addObject:testModel];
    }
    self.dataArray = [array copy];
    if ([self.delegate respondsToSelector:@selector(storeRefreshCompleted:)]) {
        [self.delegate storeRefreshCompleted:self];
    }
}

- (void)handleAdd:(NSUInteger)index
{
    self.dataArray[index].num++;
    if ([self.delegate respondsToSelector:@selector(storeAdd:)]) {
        [self.delegate storeAdd:self];
    }
}

- (void)handleReduce:(NSUInteger)index
{
    self.dataArray[index].num--;
    if ([self.delegate respondsToSelector:@selector(storeReduce:)]) {
        [self.delegate storeReduce:self];
    }
}

@end
