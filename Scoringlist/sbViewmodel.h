//
//  sbViewmodel.h
//  ScrollViewDemo
//
//  Created by Baird-weng on 16/6/19.
//  Copyright © 2016年 Baird-weng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface sbViewmodel : NSObject
//横向items。
@property(nonatomic,assign)NSMutableArray *allItems;

//左边固定不动的Item.
@property(nonatomic,strong)NSMutableArray *leftItems;

//左边的Item宽度
@property(nonatomic,assign)CGFloat LeftItemWidth;

//item的宽度
@property(nonatomic,assign)CGFloat itemWidth;

//线的颜色
@property(nonatomic,assign)UIColor *lineColor;

//线的宽度
@property(nonatomic,assign)CGFloat lineWide;
@end
