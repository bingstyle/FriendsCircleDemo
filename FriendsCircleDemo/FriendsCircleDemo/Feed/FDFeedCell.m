//
//  FDFeedCell.m
//  Demo
//
//  Created by sunnyxx on 15/4/17.
//  Copyright (c) 2015年 forkingdog. All rights reserved.
//

#import "FDFeedCell.h"
#import <Masonry.h>
#import "JGGView.h"

// 语法糖
#define WeakObj(o) autoreleasepool{} __weak typeof(o) o##Weak = o;
#define StrongObj(o) autoreleasepool{} __strong typeof(o) o = o##Weak;

@interface FDFeedCell ()

@property (nonatomic, strong)  UILabel *titleLabel;
@property (nonatomic, strong)  UILabel *contentLabel;
@property (nonatomic, strong)  JGGView *contentImageView;
@property (nonatomic, strong)  UILabel *usernameLabel;
@property (nonatomic, strong)  UILabel *timeLabel;

@end

@implementation FDFeedCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self autoLayoutSubViews];
    }
    return self;
}

- (void)autoLayoutSubViews {
    self.titleLabel = [UILabel new];
    self.contentLabel = [UILabel new];
    self.contentLabel.numberOfLines = 2;
    self.contentImageView = [JGGView new];
    self.usernameLabel = [UILabel new];
    self.timeLabel = [UILabel new];
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.contentLabel];
    [self.contentView addSubview:self.contentImageView];
    [self.contentView addSubview:self.usernameLabel];
    [self.contentView addSubview:self.timeLabel];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(10);
        make.left.offset(16);
        make.right.offset(-16);
    }];
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-10);
        make.left.equalTo(self.titleLabel);
        make.top.equalTo(self.titleLabel.mas_bottom).offset(6);
    }];
    [self.contentImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-16);
        make.top.equalTo(self.contentLabel.mas_bottom).offset(8);
        make.left.equalTo(self.titleLabel);
    }];
    [self.usernameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLabel);
        make.top.equalTo(self.contentImageView.mas_bottom).offset(8);
        make.bottom.offset(-4);
    }];
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-10);
        make.bottom.equalTo(self.usernameLabel);
    }];
}

- (void)setEntity:(FDFeedEntity *)entity
{
    _entity = entity;
    
    self.titleLabel.text = entity.title;
    self.contentLabel.text = entity.content;
    self.contentImageView.data = entity.imgList;
    self.usernameLabel.text = entity.username;
    self.timeLabel.text = entity.time;
}


@end
