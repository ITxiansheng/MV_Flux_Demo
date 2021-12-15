//
//  ZHMVCCellTableViewCell.m
//  MV_Flux_Demo_Example
//
//  Created by ITxiansheng on 2021/12/15.
//  Copyright © 2021 itxiansheng. All rights reserved.
//

#import "ZHMVCCellTableViewCell.h"
#import <Masonry/Masonry.h>

@interface ZHMVCCellTableViewCell ()

@property (nonatomic, strong)UIButton *addBtn;
@property (nonatomic, strong)UIButton *reduceBtn;

@end

@implementation ZHMVCCellTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
   if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
       
       [self.contentView addSubview:self.titleL];
       [self.contentView addSubview:self.addBtn];
       [self.contentView addSubview:self.reduceBtn];

       [self.titleL mas_makeConstraints:^(MASConstraintMaker *make) {
           make.left.top.bottom.equalTo(self.contentView);
           make.width.equalTo(@(100));
       }];
       
       [self.addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
           make.left.equalTo(self.titleL.mas_right).offset(100);
           make.top.bottom.equalTo(self.contentView);
           make.width.equalTo(@(50));
       }];
       
       [self.reduceBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                  make.left.equalTo(self.addBtn.mas_right);
                  make.top.bottom.equalTo(self.contentView);
                  make.width.equalTo(@(50));
       }];
   }
   return self;
}

- (UILabel *)titleL
{
    if (!_titleL) {
        _titleL = [UILabel new];
        _titleL.font = [UIFont systemFontOfSize:18];
    }
    return _titleL;
}

- (UIButton *)addBtn {
    if (!_addBtn) {
        _addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _addBtn.backgroundColor = [UIColor grayColor];
        [_addBtn setTitle:@"+1" forState:UIControlStateNormal];
        [_addBtn addTarget:self action:@selector(clickAddBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _addBtn;
}

- (UIButton *)reduceBtn {
    if (!_reduceBtn) {
        _reduceBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _reduceBtn.backgroundColor = [UIColor redColor];
        [_reduceBtn setTitle:@"-1" forState:UIControlStateNormal];
        [_reduceBtn addTarget:self action:@selector(clickReduceBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _reduceBtn;
}

#pragma mark - action

- (void)clickAddBtn:(id)sender
{
    if ([self.delegate respondsToSelector:@selector(clickAddBtnWithIndex:)]) {
        [self.delegate clickAddBtnWithIndex:self.indexPath];
    }
}

- (void)clickReduceBtn:(id)sender
{
    if ([self.delegate respondsToSelector:@selector(clickReduceBtnWithIndex:)]) {
        [self.delegate clickReduceBtnWithIndex:self.indexPath];
    }
}


@end
