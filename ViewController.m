//
//  ViewController.m
//  ScrollViewDemo
//
//  Created by Baird-weng on 16/6/19.
//  Copyright © 2016年 Baird-weng. All rights reserved.
//

#import "ViewController.h"
#import "scoreBoardView.h"
#import "sbViewmodel.h"
#import "SBItem.h"
@interface ViewController ()<scoreBoardViewdelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    scoreBoardView *boardView = [[scoreBoardView alloc]initWithFrame:CGRectMake(0, 30, self.view.frame.size.width, 330)];
    boardView.delegate = self;
    [self.view addSubview:boardView];
    
    
    sbViewmodel *Viewmodel = [[sbViewmodel alloc]init];
    Viewmodel.LeftItemWidth = 50;
    Viewmodel.itemWidth = 60;
    Viewmodel.lineWide = 0.5f;
    Viewmodel.lineColor = [UIColor blackColor];
    NSMutableArray *leftItems  = [[NSMutableArray alloc]init];
    NSMutableArray *AllItems = [[NSMutableArray alloc]init];
    for (int i = 0; i<10; i++){
        SBItem *item = [[SBItem alloc]init];
        item.Title = [NSString stringWithFormat:@"菜单%d",i];
        [leftItems addObject:item];
        item.isCanclick = YES;
        [AllItems addObject:[self GetItemArrayswithSection:i]];
    }
    Viewmodel.leftItems = leftItems;
    Viewmodel.allItems = AllItems;
    boardView.Viewmodel = Viewmodel;
    // Do any additional setup after loading the view, typically from a nib.
}


-(NSMutableArray *)GetItemArrayswithSection:(NSInteger)Section{
    //横向item
    NSMutableArray *transverseItems  = [[NSMutableArray alloc]init];
    for (int i = 0; i<10; i++){
        SBItem *item = [[SBItem alloc]init];
        item.Title = [NSString stringWithFormat:@"横向%d",i];

        //设置第三列的背景。
        if (i == 2){
            item.isCanclick = YES;
            item.backgroundColor = [UIColor purpleColor];
        }
        //设置第10行显示的是Textfield.
        if (Section == 9) {
            item.itemType = ItemforTextField;
        }
        [transverseItems addObject:item];
    }
    return transverseItems;
}



-(void)ClickOnTheItem:(UIView *)View WithSection:(NSInteger)section withRow:(NSInteger)row{
    NSLog(@"对象是%@====点击了第%ld列的第%ld行",[View class],(long)row+1,(long)section+1);
}

-(void)ClickOnTheLeftItem:(UIView *)View Withindex:(NSInteger)index{
    NSLog(@"对象是%@====点击了第%ld个菜单",[View class],index+1);

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
