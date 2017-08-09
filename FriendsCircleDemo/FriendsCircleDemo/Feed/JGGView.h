//
//  JGGView.h
//  FriendsCircleDemo
//
//  Created by weixb on 2017/8/8.
//  Copyright © 2017年 weixb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JGGView : UIView

@property (nonatomic, copy) NSArray *data;
@property (nonatomic, copy) void(^updateHeightBlock)(CGFloat height);

@end
