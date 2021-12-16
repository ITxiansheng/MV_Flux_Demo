//
//  ZHOperationAction.h
//  MV_Flux_Demo_Example
//
//  Created by ITxiansheng on 2021/12/16.
//  Copyright © 2021 ITxiansheng. All rights reserved.
//

#import "FluxAction.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, ZHADOperationActionType) {
    ZHADOperationActionTypeAdd = 0,
    ZHADOperationActionTypeReduce = 1,
};

@interface ZHOperationAction : FluxAction

@property (nonatomic, assign) NSUInteger currendIndex;

- (instancetype)initWithActionIdentifier:(nullable __kindof UIViewController *)actionIdentifier type:(ZHADOperationActionType)type;

@end

NS_ASSUME_NONNULL_END
