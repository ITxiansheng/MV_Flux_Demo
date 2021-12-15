//
//  ZHMVPCellTableViewCell.h
//  MV_Flux_Demo_Example
//
//  Created by ITxiansheng on 2021/12/14.
//  Copyright © 2021 itxiansheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZHMVPProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZHMVPCellTableViewCell : UITableViewCell

@property (nonatomic,strong) id <ZHMVPProtocol> delegate;
@property (nonatomic,strong) UILabel *titleL;
@property (nonatomic,strong) NSIndexPath *indexPath;

@end

NS_ASSUME_NONNULL_END
