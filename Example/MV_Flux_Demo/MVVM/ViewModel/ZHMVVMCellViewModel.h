//
//  ZHMVVMCellViewModel.h
//  MV_Flux_Demo_Example
//
//  Created by ITxiansheng on 2021/12/15.
//  Copyright © 2021 ITxiansheng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "ZHMVVMModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface ZHMVVMCellViewModel : NSObject

@property (nonatomic, strong) ZHMVVMModel  *model;
@property (nonatomic, strong) RACSubject *addSubject;
@property (nonatomic, strong) RACSubject *reduceSubject;
@property (nonatomic, strong) RACSubject *resultSubject;

@end

NS_ASSUME_NONNULL_END
