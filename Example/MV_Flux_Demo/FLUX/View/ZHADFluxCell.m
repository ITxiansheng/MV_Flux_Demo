//
//  ZHADFluxCell.m
//  MV_Flux_Demo_Example
//
//  Created by ITxiansheng on 2021/12/16.
//  Copyright © 2021 ITxiansheng. All rights reserved.
//

#import "ZHADFluxCell.h"
#import <Masonry/Masonry.h>
#import "ZHADActionCreator.h"

@interface ZHADFluxCell ()

@property (nonatomic, strong)UIButton *addBtn;
@property (nonatomic, strong)UIButton *reduceBtn;
@property (nonatomic, strong)ZHADActionCreator *creator;

@end

@implementation ZHADFluxCell

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

#pragma mark - getter

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

- (void)setStore:(ZHFLUXStore *)store
{
    self.titleL.text = [@"计数值为:" stringByAppendingString:[@(store.dataArray[self.indexPath.row].num) stringValue]];
    if (!_creator) {
        _creator = [[ZHADActionCreator alloc] initWithActionIdentifier:store.identifier];
    }
}

#pragma mark - action

- (void)clickAddBtn:(id)sender
{
    [_creator add:self.indexPath.row];
}

- (void)clickReduceBtn:(id)sender
{
    [_creator reduce:self.indexPath.row];
}


@end
