//
//  ZHMVVMCell.m
//  MV_Flux_Demo_Example
//
//  Created by ITxiansheng on 2021/12/15.
//  Copyright © 2021 wangbaojun. All rights reserved.
//

#import "ZHMVVMCell.h"
#import <Masonry/Masonry.h>
#import <ReactiveCocoa/ReactiveCocoa.h>

@interface ZHMVVMCell ()

@property (nonatomic, strong)UIButton *addBtn;
@property (nonatomic, strong)UIButton *reduceBtn;
@property (nonatomic, strong)ZHMVVMCellViewModel *viewModel;

@end

@implementation ZHMVVMCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

-(void)setViewModel:(ZHMVVMCellViewModel *)viewModel
{
    _viewModel = viewModel;
    self.titleL.text = [@"计数值为:" stringByAppendingString:[@(viewModel.model.num) stringValue]];
    [_viewModel.resultSubject subscribeNext:^(NSNumber * x) {
        self.titleL.text = [@"计数值为:" stringByAppendingString: [x stringValue]];
    }];
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

#pragma mark - action

- (void)clickAddBtn:(id)sender
{
    [self.viewModel.addSubject sendNext:nil];
}

- (void)clickReduceBtn:(id)sender
{
    [self.viewModel.reduceSubject sendNext:nil];
}

@end
