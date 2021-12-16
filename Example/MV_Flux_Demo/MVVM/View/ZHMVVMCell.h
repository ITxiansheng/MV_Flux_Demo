//
//  ZHMVVMCell.h
//  MV_Flux_Demo_Example
//
//  Created by ITxiansheng on 2021/12/15.
//  Copyright © 2021 wangbaojun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZHMVVMCellViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZHMVVMCell : UITableViewCell

@property (nonatomic,strong) UILabel *titleL;
@property (nonatomic,strong) NSIndexPath *indexPath;

-(void)setViewModel:(ZHMVVMCellViewModel *)viewModel;

@end

NS_ASSUME_NONNULL_END
