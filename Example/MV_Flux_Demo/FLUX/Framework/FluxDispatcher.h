//
//  FluxDispatcher.h
//  NeteaseLottery
//
//  Created by ITxiansheng on 1/20/16.
//

#import <Foundation/Foundation.h>

@class FluxAction;
@class FluxStore;
@protocol FluxStore;
@interface FluxDispatcher : NSObject

/**
 *  向Dispatcher注册Store，用于接收Action。
 *  （同一个Store可以重复注册）
 */
+ (BOOL)registerStore:(nonnull FluxStore<FluxStore> *)store;

/**
 *  向Dispatcher注销Store
 *  （同一个Store可以重复反注册）
 *  @warning   在Store释放前必须执行此方法反注册它！！
 */
+ (void)unregisterStore:(nonnull FluxStore<FluxStore> *)store;

/**
 *  向Dispatcher发送一个Action
 *  @warning   此Action会被监听它的Store在主线程中收到！！
 */
+ (void)dispatchAction:(nonnull FluxAction *)action;

@end
