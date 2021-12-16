//
//  ZHADFLUXService.m
//  MV_Flux_Demo_Example
//
//  Created by ITxiansheng on 2021/12/16.
//  Copyright © 2021 ITxiansheng. All rights reserved.
//

#import "ZHADFLUXService.h"

@implementation ZHADFLUXService

-(void)loadDataWithSuccessBlcok:(void(^)(NSArray*))block{
    //模拟进行网络请求加载。。。。
    dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, 3ull * NSEC_PER_SEC);
    dispatch_after(time, dispatch_get_global_queue(0, 0), ^{
        NSArray *result = @[@"10",@"11",@"12",@"13",@"14",@"15",@"16",@"17",@"18",@"19"];
        if (block) {
            block(result);
        }
    });
}

@end
