//
//  scoreBoardView.m
//  ScrollViewDemo
//
//  Created by Baird-weng on 16/6/19.
//  Copyright © 2016年 Baird-weng. All rights reserved.
//

#import "scoreBoardView.h"
#import "SBItem.h"



@interface scoreBoardView()


@property(nonatomic,strong)UIView *blackView;

@property(nonatomic,strong)UIScrollView *ScrollView;
@end
@implementation scoreBoardView
-(void)setViewmodel:(sbViewmodel *)Viewmodel{
    _Viewmodel = Viewmodel;
    [self.blackView removeFromSuperview];
    self.blackView = nil;
    if (self.blackView==nil) {
        self.blackView = [[UIView alloc]initWithFrame:self.bounds];
        [self addSubview:self.blackView];
        
        self.blackView.layer.borderColor = self.Viewmodel.lineColor.CGColor;
        self.blackView.layer.borderWidth = self.Viewmodel.lineWide;
    }
    //加载左边菜单
    [self didLoadLeftItem];
    //加载scrollview
    [self didLoadScrollView];
    //加边框以及细线。
    [self didloadborder];
}

-(void)didLoadLeftItem{
    NSInteger leftItemCount = [self.Viewmodel.leftItems count];
    //左边固定的item。
    CGFloat itemHeight = self.frame.size.height/leftItemCount;
    for (int i = 0; i<[self.Viewmodel.leftItems count]; i++){
        SBItem *item = self.Viewmodel.leftItems[i];
        UILabel *LeftItem = [[UILabel alloc]initWithFrame:CGRectMake(0, itemHeight*i, self.Viewmodel.LeftItemWidth, itemHeight)];
        LeftItem.text = item.Title;
        LeftItem.textAlignment = 1;
        LeftItem.tag = i;
        LeftItem.userInteractionEnabled = YES;
        if (item.isCanclick) {
            UITapGestureRecognizer *Tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(ClickOntheLeftItem:)];
            [LeftItem addGestureRecognizer:Tap];
        }
        LeftItem.backgroundColor = item.backgroundColor;
        LeftItem.font = [UIFont systemFontOfSize:14];
        [self.blackView addSubview:LeftItem];
    }
}

-(void)didLoadScrollView{
    NSInteger leftItemCount = [self.Viewmodel.leftItems count];
    CGFloat itemHeight = self.frame.size.height/leftItemCount;
    UIScrollView *ScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(self.Viewmodel.LeftItemWidth, 0, self.frame.size.width-self.Viewmodel.LeftItemWidth, leftItemCount*itemHeight)];
    ScrollView.backgroundColor = [UIColor clearColor];
    [self.blackView addSubview:ScrollView];
    NSInteger crossItemCount = 0;
    for (int i = 0; i<[self.Viewmodel.leftItems count]; i++){
        NSMutableArray *transverseItems  = self.Viewmodel.allItems[i];
        crossItemCount = transverseItems.count;
        for (int j = 0; j<[transverseItems count]; j++) {
            SBItem *sbItem = transverseItems[j];
            if (sbItem.itemType == ItemforTextField) {
                UITextField *textField = [[UITextField alloc]initWithFrame:CGRectMake(self.Viewmodel.itemWidth*j, itemHeight*i, self.Viewmodel.itemWidth, itemHeight)];
                textField.text = sbItem.Title;
                textField.text = sbItem.Title;
                textField.textAlignment = 1;
                textField.tag = 1000*i+j;
                textField.font = [UIFont systemFontOfSize:14];
                [ScrollView addSubview:textField];
            }
            else{
                UILabel *ItemLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.Viewmodel.itemWidth*j, itemHeight*i, self.Viewmodel.itemWidth, itemHeight)];
                ItemLabel.text = sbItem.Title;
                ItemLabel.textAlignment = 1;
                ItemLabel.tag = 1000*i+j;
                ItemLabel.userInteractionEnabled = YES;
                if (sbItem.isCanclick) {
                    UITapGestureRecognizer *Tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(ClickOntheTap:)];
                    [ItemLabel addGestureRecognizer:Tap];
                }
                ItemLabel.backgroundColor = sbItem.backgroundColor;
                ItemLabel.font = [UIFont systemFontOfSize:14];
                [ScrollView addSubview:ItemLabel];
            }
        }
    }
    CGFloat Content_x = self.Viewmodel.itemWidth*crossItemCount;
    if (Content_x<=ScrollView.contentSize.width) {
        Content_x = ScrollView.contentSize.width;
    }
    ScrollView.bounces = YES;
    [ScrollView setContentSize:CGSizeMake(self.Viewmodel.itemWidth*crossItemCount, 0)];
    self.ScrollView = ScrollView;
}



-(void)didloadborder{
    //左边固定的item。
    NSInteger leftItemCount = [self.Viewmodel.leftItems count];
    CGFloat itemHeight = self.frame.size.height/leftItemCount;
    CALayer *lineLayer = [CALayer layer];
    lineLayer.frame = CGRectMake(self.Viewmodel.LeftItemWidth,0, self.Viewmodel.lineWide, leftItemCount*itemHeight);
    lineLayer.borderWidth = self.Viewmodel.lineWide;
    lineLayer.borderColor = self.Viewmodel.lineColor.CGColor;
    [self.blackView.layer addSublayer:lineLayer];
    for (int i = 0; i<[self.Viewmodel.leftItems count]; i++){
        if (i>0&&i<[self.Viewmodel.leftItems count]){
            CALayer *lineLayer = [CALayer layer];
            lineLayer.frame = CGRectMake(0,itemHeight*i,self.frame.size.width, self.Viewmodel.lineWide);
            lineLayer.borderWidth = self.Viewmodel.lineWide;
            lineLayer.borderColor = self.Viewmodel.lineColor.CGColor;
            [self.blackView.layer addSublayer:lineLayer];
        }
    }
    NSInteger crossItemCount = 0;
    if ([self.Viewmodel.allItems count]>0){
        NSArray *Temple = self.Viewmodel.allItems[0];
        crossItemCount = [Temple count];
    }
    for (int i = 1; i<crossItemCount+1; i++){
        CALayer *lineLayer = [CALayer layer];
        lineLayer.frame = CGRectMake(self.Viewmodel.itemWidth*i,0, self.Viewmodel.lineWide, leftItemCount*itemHeight);
        lineLayer.borderWidth = self.Viewmodel.lineWide;
        lineLayer.borderColor = self.Viewmodel.lineColor.CGColor;
        [self.ScrollView.layer addSublayer:lineLayer];
    }
}
-(void)ClickOntheTap:(UITapGestureRecognizer *)Tap{
    NSInteger section = Tap.view.tag/1000;
    NSInteger row = Tap.view.tag%1000;
    if ([self.delegate respondsToSelector:@selector(ClickOnTheItem:WithSection:withRow:)]) {
        [self.delegate ClickOnTheItem:Tap.view WithSection:section withRow:row];
    }
}


-(void)ClickOntheLeftItem:(UITapGestureRecognizer *)Tap{
    if ([self.delegate respondsToSelector:@selector(ClickOnTheLeftItem:Withindex:)]) {
        [self.delegate ClickOnTheLeftItem:Tap.view Withindex:Tap.view.tag];
    }

}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
@end
