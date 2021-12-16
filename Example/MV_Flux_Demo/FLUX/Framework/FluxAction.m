//
//  FluxAction.m
//  NeteaseLottery
//
//  Created by ITxiansheng on 1/20/16.
//

#import "FluxAction.h"

@implementation FluxAction

- (nonnull instancetype)init
{
    return [self initWithType:-1];
}

- (nonnull instancetype)initWithType:(NSInteger)type
{
    return [self initWithType:type data:nil identifier:nil];
}

- (nonnull instancetype)initWithType:(NSInteger)type identifier:(nullable NSString *)identifier
{
    return [self initWithType:type data:nil identifier:identifier];
}

- (nonnull instancetype)initWithType:(NSInteger)type data:(nullable id)data
{
    return [self initWithType:type data:data identifier:nil];
}

- (nonnull instancetype)initWithType:(NSInteger)type data:(nullable id)data identifier:(nullable NSString *)identifier
{
    self = [super init];
    if (self) {
        _type = type;
        _data = data;
        _identifier = identifier;
    }
    return self;
}

@end
