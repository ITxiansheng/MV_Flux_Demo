//
//  ZHMVPPresenter.h
//  MV_Flux_Demo_Example
//
//  Created by ITxiansheng on 2021/12/14.
//  Copyright © 2021 itxiansheng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZHMVPProtocol.h"
typedef void(^Block)(void);

NS_ASSUME_NONNULL_BEGIN

@interface ZHMVPPresenter : NSObject<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,copy) Block dataSuccessBlock;

-(void)loadDataWithSuccessblock:(Block)successBlock;

-(void)bindTableView:(UITableView*)testTableView control:(id<ZHMVPProtocol>)control;

@end

NS_ASSUME_NONNULL_END
