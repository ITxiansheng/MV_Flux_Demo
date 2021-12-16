//
//  ZHADActionCreator.m
//  MV_Flux_Demo_Example
//
//  Created by ITxiansheng on 2021/12/16.
//  Copyright © 2021 ITxiansheng. All rights reserved.
//

#import "ZHADActionCreator.h"
#import "ZHRefreshAction.h"
#import "ZHOperationAction.h"
#import "FluxDispatcher.h"
#import "ZHADFLUXService.h"

@interface ZHADActionCreator()

@property (nonatomic, copy) NSString *actionIdentifier;
@property (nonatomic, copy) ZHADFLUXService *service;

@end

@implementation ZHADActionCreator

- (instancetype)initWithActionIdentifier:(NSString *)actionIdentifier
{
    self = [super init];
    if (self) {
        _actionIdentifier = actionIdentifier ?: nil;
    }
    return self;
}

- (void)refreshList
{
    _service = [ZHADFLUXService new];
    [_service loadDataWithSuccessBlcok:^(NSArray * array) {
        ZHRefreshAction *action = [[ZHRefreshAction alloc] initWithType:ZHADRefreshActionTypeSucceed data:array identifier:self.actionIdentifier];
        [FluxDispatcher dispatchAction:action];
    }];
}

- (void)add:(NSUInteger)index
{
    ZHOperationAction *action = [[ZHOperationAction alloc] initWithType:ZHADOperationActionTypeAdd identifier:self.actionIdentifier];
    action.currendIndex = index;
    [FluxDispatcher dispatchAction:action];
}

- (void)reduce:(NSUInteger)index
{
    ZHOperationAction *action = [[ZHOperationAction alloc] initWithType:ZHADOperationActionTypeReduce identifier:self.actionIdentifier];
    action.currendIndex = index;
    [FluxDispatcher dispatchAction:action];
}

@end
