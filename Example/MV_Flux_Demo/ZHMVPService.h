//
//  ZHMVPService.h
//  MV_Flux_Demo_Example
//
//  Created by ITxiansheng on 2021/12/14.
//  Copyright © 2021 itxiansheng. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZHMVPService : NSObject

-(void)loadDataWithSuccessBlcok:(void(^)(NSArray*))block;

@end

NS_ASSUME_NONNULL_END
