//
//  ZHADFluxCell.h
//  MV_Flux_Demo_Example
//
//  Created by ITxiansheng on 2021/12/16.
//  Copyright © 2021 ITxiansheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZHFLUXStore.h"

NS_ASSUME_NONNULL_BEGIN


@protocol ZHADFluxCellDelegate <NSObject>



@end

@interface ZHADFluxCell : UITableViewCell

- (void)setStore:(ZHFLUXStore *)store;

@property (nonatomic,strong) UILabel *titleL;
@property (nonatomic,strong) NSIndexPath *indexPath;

@end

NS_ASSUME_NONNULL_END
