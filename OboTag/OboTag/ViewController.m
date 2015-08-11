//
//  ViewController.m
//  OboTag
//
//  Created by obo on 15/8/7.
//  Copyright (c) 2015年 ObTag. All rights reserved.
//

#import "ViewController.h"
#import "ObTagCell.h"
#import "ObTagView.h"

#define VERTICAL_DISTANCE 10
#define HORIZONTAL_DISTANCE 10
#define CHOOSE_SET_HEIGH 200

@interface ViewController ()
{
    ObTagView       *obTagView;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSMutableArray *optionString    = [NSMutableArray arrayWithArray:@[@"美食", @"音乐",@"code4app"]];
    NSMutableArray *choosedString   = [NSMutableArray arrayWithArray:@[@"uuu1993",@"书画",@"obo",@"标签"]];
    
    obTagView = [[ObTagView alloc]initWithFrame:self.view.frame withOptionTags:optionString withChoosedTags:choosedString];
    [self.view addSubview:obTagView];
    
    //获取被选中的标签按钮
    UIButton *btnGetResult = [[UIButton alloc]initWithFrame:CGRectMake(10, 300, 90, 60)];
    [btnGetResult setTitle:@"获取标签" forState:UIControlStateNormal];
    btnGetResult.backgroundColor = [UIColor blueColor];
    [btnGetResult addTarget:self action:@selector(makeSureAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnGetResult];
    
}



- (void) makeSureAction
{
    NSMutableArray *result= [obTagView getResultChoosedTags];
    
    for (int i=0; i<[result count]; i++) {
        NSLog(@"%@",[result objectAtIndex:i]);
    }
    
}


@end
