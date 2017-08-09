//
//  JGGView.m
//  FriendsCircleDemo
//
//  Created by weixb on 2017/8/8.
//  Copyright © 2017年 weixb. All rights reserved.
//

#import "JGGView.h"
#import <Masonry.h>

static CGFloat const item_space = 5;

@implementation JGGView

#pragma mark - private
- (void)createItem {
    /*! 图片创建 */
    CGFloat item_width = (self.superview.bounds.size.width - 2 * item_space)/3;
    CGFloat item_height = 0;
    NSArray *photosArr = self.data;
    // 限制item最大数量
    if (photosArr.count > 9) {
        photosArr = [photosArr subarrayWithRange:NSMakeRange(0, 9)];
    }
    if (photosArr.count == 1) {
        UIImage *image = [UIImage imageNamed:photosArr.firstObject];
        item_width = image.size.width;
        item_height = image.size.height;
    } else {
        item_height = item_width;
    }
    
    long perRowItemCount = [self perRowItemCountForPicPathArray:photosArr];
    [photosArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIImageView *imageView = [UIImageView new];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.clipsToBounds = YES;
        [self addSubview:imageView];
        
        long columnIndex = 0;
        if (photosArr.count == 4) {
            columnIndex = idx % 2;
        }
        else {
            columnIndex = idx % 3;
        }
        
        long rowIndex = idx / perRowItemCount;
        CGFloat leftMargin = columnIndex * (item_width + item_space);
        CGFloat topMargin = rowIndex * (item_height + item_space);
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(leftMargin);
            make.top.offset(topMargin);
            make.width.mas_equalTo(item_width);
            make.height.mas_equalTo(item_height);
            make.bottom.mas_lessThanOrEqualTo(0);
        }];
        UIImage *image = [UIImage imageNamed:photosArr[idx]];
        imageView.image = image;
    }];
}

- (NSInteger)perRowItemCountForPicPathArray:(NSArray *)array
{
    if(array.count == 4)
    {
        return 2;
    }
    else if (array.count <= 2)
    {
        return array.count;
    }
    else
    {
        return 3;
    }
}

#pragma mark - setter
- (void)setData:(NSArray *)data {
    _data = data;
    [self createItem];
}


@end
