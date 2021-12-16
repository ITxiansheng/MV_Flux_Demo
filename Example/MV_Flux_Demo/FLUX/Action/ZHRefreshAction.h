//
//  ZHRefrshAction.h
//  MV_Flux_Demo_Example
//
//  Created by ITxiansheng on 2021/12/16.
//  Copyright © 2021 ITxiansheng. All rights reserved.
//

#import "FluxAction.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, ZHADRefreshActionType) {
    ZHADRefreshActionTypeSucceed = 1,
    ZHADRefreshActionTypeFailed  = 2
};

@interface ZHRefreshAction : FluxAction

- (instancetype)initWithActionIdentifier:(nullable __kindof UIViewController *)actionIdentifier type:(ZHADRefreshActionType)type;

@end

NS_ASSUME_NONNULL_END
