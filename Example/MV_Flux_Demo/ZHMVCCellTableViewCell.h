//
//  ZHMVCCellTableViewCell.h
//  MV_Flux_Demo_Example
//
//  Created by ITxiansheng on 2021/12/15.
//  Copyright © 2021 itxiansheng. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol ZHMVCCellTableViewCellDelegate <NSObject>

-(void)clickAddBtnWithIndex:(NSIndexPath*)indexPath;
-(void)clickReduceBtnWithIndex:(NSIndexPath*)indexPath;

@end


@interface ZHMVCCellTableViewCell : UITableViewCell

@property (nonatomic,weak)id <ZHMVCCellTableViewCellDelegate>delegate;
@property (nonatomic,strong) UILabel *titleL;
@property (nonatomic,strong) NSIndexPath *indexPath;

@end

NS_ASSUME_NONNULL_END
