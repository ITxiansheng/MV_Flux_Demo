//
//  ZHADActionCreator.h
//  MV_Flux_Demo_Example
//
//  Created by ITxiansheng on 2021/12/16.
//  Copyright © 2021 ITxiansheng. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZHADActionCreator : NSObject

- (instancetype)initWithActionIdentifier:(NSString *)actionIdentifier;

- (void)refreshList;

- (void)add:(NSUInteger)index;

- (void)reduce:(NSUInteger)index;

@end

NS_ASSUME_NONNULL_END
