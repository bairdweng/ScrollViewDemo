//
//  scoreBoardView.h
//  ScrollViewDemo
//
//  Created by Baird-weng on 16/6/19.
//  Copyright © 2016年 Baird-weng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "sbViewmodel.h"

@protocol scoreBoardViewdelegate <NSObject>
-(void)ClickOnTheItem:(UIView *)View WithSection:(NSInteger)section withRow:(NSInteger)row;
-(void)ClickOnTheLeftItem:(UIView *)View Withindex:(NSInteger)index;
@end


@interface scoreBoardView : UIView
@property(nonatomic,strong)sbViewmodel *Viewmodel;

@property(nonatomic,assign)id<scoreBoardViewdelegate>delegate;
@end
