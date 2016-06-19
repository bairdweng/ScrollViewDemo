//
//  SBItem.h
//  ScrollViewDemo
//
//  Created by Baird-weng on 16/6/19.
//  Copyright © 2016年 Baird-weng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,ItemType){
    ItemforLabel = 0,
    ItemforTextField,
};

@interface SBItem : NSObject
@property(nonatomic,strong)NSString *Title;
@property(nonatomic,strong)UIColor *backgroundColor;
//是否可以点击。
@property(nonatomic,assign)BOOL isCanclick;
//Item类型，可以是label或者TextField,默认是label。
@property(nonatomic,assign)ItemType itemType;
@end
