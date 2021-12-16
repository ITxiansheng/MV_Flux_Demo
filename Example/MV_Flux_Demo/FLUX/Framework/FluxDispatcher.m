//
//  FluxDispatcher.m
//  NeteaseLottery
//
//  Created by ITxiansheng on 1/20/16.
//

#import "FluxDispatcher.h"
#import "FluxAction.h"
#import "FluxStore.h"

NSString * const ZHADActionDispatchNotification = @"ZHADActionDispatchNotification";
NSString * const ZHADEventDispatchNotification = @"ZHADEventDispatchNotification";


@interface FluxStore ()

- (nonnull SEL)actionHandler;

@end


@interface FluxDispatcher ()

@property (nonatomic, strong) NSNotificationCenter *notificationCenter;

@end


@implementation FluxDispatcher

+ (FluxDispatcher *)sharedDispatcher
{
    static FluxDispatcher *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [FluxDispatcher new];
    });
    return instance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.notificationCenter = [NSNotificationCenter new];
    }
    return self;
}

+ (BOOL)registerStore:(nonnull FluxStore<FluxStore> *)store
{
    if ([store respondsToSelector:@selector(actionRecieverDict)]) {
        NSDictionary *dict = [store actionRecieverDict];
        [dict enumerateKeysAndObjectsUsingBlock:^(__kindof NSString * _Nonnull key, __kindof NSString * _Nonnull obj, BOOL * _Nonnull stop) {
            Class actionClass = NSClassFromString(key);
            SEL actionRecieveSelector = NSSelectorFromString(obj);
            if (actionClass && actionRecieveSelector && [store respondsToSelector:actionRecieveSelector]) {
                [[self sharedDispatcher].notificationCenter removeObserver:store name:ZHADActionDispatchNotification object:actionClass];
                [[self sharedDispatcher].notificationCenter addObserver:store selector:[store actionHandler] name:ZHADActionDispatchNotification object:actionClass];
            }
        }];
        return YES;
    }
    return NO;
}

+ (void)unregisterStore:(nonnull FluxStore<FluxStore> *)store
{
    if ([store respondsToSelector:@selector(actionRecieverDict)]) {
        NSDictionary *dict = [store actionRecieverDict];
        [dict enumerateKeysAndObjectsUsingBlock:^(__kindof NSString * _Nonnull key, __kindof NSString * _Nonnull obj, BOOL * _Nonnull stop) {
            Class actionClass = NSClassFromString(key);
            SEL actionRecieveSelector = NSSelectorFromString(obj);
            if (actionClass && actionRecieveSelector && [store respondsToSelector:actionRecieveSelector]) {
                [[self sharedDispatcher].notificationCenter removeObserver:store name:ZHADActionDispatchNotification object:actionClass];
            }
        }];
    }
}

+ (void)dispatchAction:(nonnull FluxAction *)action
{
    if (action) {
        dispatch_async(dispatch_get_main_queue(), ^ {
            [[self sharedDispatcher].notificationCenter postNotificationName:ZHADActionDispatchNotification object:[action class] userInfo:@{@"action" : action}];
        });
    }
}

@end
