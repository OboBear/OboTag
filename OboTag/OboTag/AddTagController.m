//
//  AddTagController.m
//  lemonshow
//
//  Created by apple on 15/8/6.
//  Copyright (c) 2015年 LemonShow. All rights reserved.
//

#import "AddTagController.h"
#import "TagCell.h"

#define VERTICAL_DISTANCE 10
#define HORIZONTAL_DISTANCE 10

#define CHOOSE_SET_HEIGH 200

@interface AddTagController ()
{
    NSMutableArray          *arrayChoosedTags;
    NSMutableArray          *arrayOptionTags;
    
    NSArray                 *colorPool ;
    
    CGFloat                 lineBottom;

}

@end

@implementation AddTagController



- (void)viewDidLoad {
    [super viewDidLoad];
    [self initPredatas];
    [self initNavBar];
    [self initContentView];
}

- (void) initPredatas
{
    arrayChoosedTags = [[NSMutableArray alloc]init];
    arrayOptionTags  = [[NSMutableArray alloc]init];
}

-(void)initNavBar
{
    CATextLayer *navTextLayer = [CATextLayer layer];
    navTextLayer = [UIUtils textLayer:navTextLayer withSize:15 andString:@"标记标签" color:[UIColor blackColor].CGColor];
    navTextLayer.alignmentMode = @"center";
    navTextLayer.frame = CGRectMake(10, 11, 200, 20);
    navTextLayer.position = CGPointMake(ScreenWidth*0.5, 22);
    [self.navBar.layer addSublayer:navTextLayer];
    
    UIButton * backBtn = [AddTagController navButtonWithFrame:CGRectMake(0, 0, 60, self.navBar.height) Title:nil];
    [backBtn addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    [self.navBar addSubview:backBtn];
    
    UIButton *  saveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    saveBtn.frame = CGRectMake(ScreenWidth-44, 0, 44, 44);
    [saveBtn setTitle:@"发布" forState:UIControlStateNormal];
    saveBtn.titleLabel.font = [UIFont systemFontOfSize:14.0f];
    [saveBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [saveBtn addTarget:self action:@selector(saveAction) forControlEvents:UIControlEventTouchUpInside];
    [self.navBar addSubview:saveBtn];
    
}


- (void) initContentView
{
    NSString *tipString = @"点击添加标签";
    UIFont *tipFont = [UIFont fontWithName:nil size:14];
    CGRect rect = [UIUtils getFontSizeWithString:tipString withFont:tipFont withMaxWidth:MAXFLOAT withMaxHeight:MAXFLOAT];
    
    UILabel * tipLable = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, rect.size.width, rect.size.height)];
    [tipLable setText:tipString];
    [tipLable setFont:tipFont];
    [tipLable setTextColor:[UIColor grayColor]];
    tipLable.center = CGPointMake(ScreenWidth/2, self.navBar.bottom + 10 + tipLable.height/2);
    [self.view addSubview:tipLable];
    
    CALayer *lineLayer = [CALayer layer];
    lineLayer.frame = CGRectMake(0, tipLable.bottom + 10, ScreenWidth  , 0.5);
    lineLayer.backgroundColor = [UIUtils colorWithHexString:@"AAAAAA" alpha:1].CGColor;
    [self.view.layer addSublayer:lineLayer];
    lineBottom = lineLayer.frame.origin.y;
    
    
    colorPool = @[@"#7ecef4", @"#84ccc9", @"#88abda",@"#7dc1dd",@"#b6b8de"];
    
    NSArray *titlePool = @[@"旅行", @"摄影", @"美食",@"文艺",@"旅行",@"搞笑"];
   
    for (int i=0; i<[titlePool count]; i++) {
        TagCell *tagCell = [[TagCell alloc]initWithTitle:[titlePool objectAtIndex:i]];
        tagCell.backgroundColor = [UIColor clearColor];
        tagCell.layer.borderColor = [UIColor grayColor].CGColor;
        tagCell.layer.borderWidth = 1;
        tagCell.titleShowLable.textColor = [UIColor blackColor];
        
        [tagCell addTarget:self action:@selector(tagClickAction:) forControlEvents:UIControlEventTouchUpInside];
        [arrayOptionTags addObject:tagCell];
    }
    
    UIView * backWhiteView = [[UIView alloc]initWithFrame:CGRectMake(0, CHOOSE_SET_HEIGH + self.navBar.bottom, ScreenWidth, ScreenHeight - CHOOSE_SET_HEIGH - self.navBar.bottom)];
    [self.view addSubview:backWhiteView];
    backWhiteView.backgroundColor = [UIColor whiteColor];
    
    [self setPosition];
}


- (void) setPosition
{
    for (int i=0; i<[arrayOptionTags count]; i++) {
        
        TagCell *tagCell = [arrayOptionTags objectAtIndex:i];
        
        [self.view addSubview:tagCell];
        
        if(!i)
        {
            tagCell.top = self.navBar.bottom + CHOOSE_SET_HEIGH +VERTICAL_DISTANCE;
            tagCell.left = HORIZONTAL_DISTANCE;
        }
        else
        {
            TagCell *lastTagCell = [arrayOptionTags objectAtIndex:i-1];
            
            if(ScreenWidth - lastTagCell.right < HORIZONTAL_DISTANCE+HORIZONTAL_DISTANCE + tagCell.width)
            {
                tagCell.top = lastTagCell.bottom + VERTICAL_DISTANCE;
                
                tagCell.left = HORIZONTAL_DISTANCE;
            }
            else
            {
                tagCell.top = lastTagCell.top;
                
                tagCell.left = lastTagCell.right+HORIZONTAL_DISTANCE;
            }
        }
    }
}


- (void) resetPosition
{
    
    [UIView animateWithDuration:0.5 animations:^{
       
        for (int i=0; i<[arrayChoosedTags count]; i++) {
            
            TagCell *tagCell = [arrayChoosedTags objectAtIndex:i];
            
            if(!i)
            {
                tagCell.top = lineBottom +VERTICAL_DISTANCE;
                tagCell.left = HORIZONTAL_DISTANCE;
            }
            else
            {
                TagCell *lastTagCell = [arrayChoosedTags objectAtIndex:i-1];
                
                if(ScreenWidth - lastTagCell.right < HORIZONTAL_DISTANCE+HORIZONTAL_DISTANCE + tagCell.width)
                {
                    tagCell.top = lastTagCell.bottom + VERTICAL_DISTANCE;
                    
                    tagCell.left = HORIZONTAL_DISTANCE;
                }
                else
                {
                    tagCell.top = lastTagCell.top;
                    
                    tagCell.left = lastTagCell.right+HORIZONTAL_DISTANCE;
                }
            }
        }
        
        
        for (int i=0; i<[arrayOptionTags count]; i++) {
            
            TagCell *tagCell = [arrayOptionTags objectAtIndex:i];
            
            if(!i)
            {
                tagCell.top = self.navBar.bottom + CHOOSE_SET_HEIGH +VERTICAL_DISTANCE;
                tagCell.left = HORIZONTAL_DISTANCE;
            }
            else
            {
                TagCell *lastTagCell = [arrayOptionTags objectAtIndex:i-1];
                
                if(ScreenWidth - lastTagCell.right < HORIZONTAL_DISTANCE+HORIZONTAL_DISTANCE + tagCell.width)
                {
                    tagCell.top = lastTagCell.bottom + VERTICAL_DISTANCE;
                    
                    tagCell.left = HORIZONTAL_DISTANCE;
                }
                else
                {
                    tagCell.top = lastTagCell.top;
                    
                    tagCell.left = lastTagCell.right+HORIZONTAL_DISTANCE;
                }
            }
        }
        
    }];
    
}





#pragma mark-----Action-----

- (void) tagClickAction:(TagCell *)sender
{
    
    if([arrayChoosedTags containsObject:sender])
    {
        [arrayChoosedTags removeObject:sender];
        [arrayOptionTags addObject:sender];
        
        
        sender.backgroundColor = [UIColor clearColor];
        sender.titleShowLable.textColor = [UIColor blackColor];
        sender.layer.borderWidth = 1;
    }
    else if([arrayOptionTags containsObject:sender])
    {
        
        [arrayOptionTags removeObject:sender];
        [arrayChoosedTags addObject:sender];
        
        sender.backgroundColor = [UIUtils colorWithHexString:[colorPool objectAtIndex:random()%5] alpha:1];
        sender.titleShowLable.textColor = [UIColor whiteColor];
        sender.layer.borderWidth = 0;
    }
    
    [self resetPosition];
}


- (void)backAction{
    
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)saveAction{
    

}





@end
