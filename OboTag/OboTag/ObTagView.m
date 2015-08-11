//
//  ObTagView.m
//  OboTag
//
//  Created by obo on 15/8/9.
//  Copyright (c) 2015年 ObTag. All rights reserved.
//

#import "ObTagView.h"
#import "ObTagCell.h"

#define VERTICAL_DISTANCE 10
#define HORIZONTAL_DISTANCE 10
#define CHOOSE_SET_HEIGH 200

@implementation ObTagView
{
    NSMutableArray          *arrayChoosedTags;
    NSMutableArray          *arrayOptionTags;
    NSMutableArray          *arrayColor;
}

- (id) initWithFrame:(CGRect)frame withOptionTags:(NSMutableArray *)optionString withChoosedTags:(NSMutableArray *)choosedString
{
    if([super initWithFrame:frame])
    {
        [self initPreDatas];
        [self initContentViewWithOptionTags:optionString withChoosedTags:choosedString];
    }
    return self;
}

- (void)initPreDatas
{
    arrayColor = [[NSMutableArray alloc]initWithArray:@[
                                                        [UIColor colorWithRed:255/255.0 green:200/255.0 blue:160/255.0 alpha:1],
                                                        [UIColor colorWithRed:199/255.0  green:230/255.0  blue:220/255.0  alpha:1],
                                                        [UIColor colorWithRed:200/255.0  green:190/255.0  blue:240/255.0  alpha:1]
                                                        ]];
}

- (void) initContentViewWithOptionTags:(NSMutableArray *)optionString withChoosedTags:(NSMutableArray *)choosedString
{
    arrayChoosedTags    = [[NSMutableArray alloc]init];
    arrayOptionTags     = [[NSMutableArray alloc]init];
    
    for (int i=0; i<[choosedString count]; i++) {
        ObTagCell *tagCell = [[ObTagCell alloc]initWithTitle:[choosedString objectAtIndex:i]];
        tagCell.titleShowLable.textColor = [UIColor blackColor];
        
        [tagCell addTarget:self action:@selector(tagClickAction:) forControlEvents:UIControlEventTouchUpInside];
        tagCell.backgroundColor = [arrayColor objectAtIndex:rand()%[arrayColor count]];
        [arrayChoosedTags addObject:tagCell];
        [self addSubview:tagCell];
    }
    
    for (int i=0; i<[optionString count]; i++) {
        ObTagCell *tagCell = [[ObTagCell alloc]initWithTitle:[optionString objectAtIndex:i]];
        tagCell.titleShowLable.textColor = [UIColor blackColor];
        
        [tagCell addTarget:self action:@selector(tagClickAction:) forControlEvents:UIControlEventTouchUpInside];
        [arrayOptionTags addObject:tagCell];
        [self addSubview:tagCell];
    }
    
    [self resetPosition];
    
}


- (void) resetPosition
{
    [UIView animateWithDuration:0.5 animations:^{
        
        for (int i=0; i<[arrayChoosedTags count]; i++) {
            
            ObTagCell *tagCell = [arrayChoosedTags objectAtIndex:i];
            CGRect rect= tagCell.frame;
            
            if(!i)
            {
                rect.origin.x = HORIZONTAL_DISTANCE;
                rect.origin.y= VERTICAL_DISTANCE + 50;
            }
            else
            {
                ObTagCell *lastTagCell = [arrayChoosedTags objectAtIndex:i-1];
                
                if(self.frame.size.width - lastTagCell.frame.origin.x - lastTagCell.frame.size.width < HORIZONTAL_DISTANCE+HORIZONTAL_DISTANCE + tagCell.frame.size.width)
                {
                    rect.origin.y = lastTagCell.frame.origin.y
                    + lastTagCell.frame.size.height+ VERTICAL_DISTANCE;
                    
                    rect.origin.x = HORIZONTAL_DISTANCE;
                }
                else
                {
                    rect.origin.y = lastTagCell.frame.origin.y;
                    
                    rect.origin.x = lastTagCell.frame.origin.x + lastTagCell.frame.size.width+HORIZONTAL_DISTANCE;
                }
            }
            
            tagCell.frame= rect;
        }
        
        
        for (int i=0; i<[arrayOptionTags count]; i++) {
            
            ObTagCell *tagCell = [arrayOptionTags objectAtIndex:i];
            
            CGRect rect= tagCell.frame;
            
            if(!i)
            {
                rect.origin.x = HORIZONTAL_DISTANCE;
                rect.origin.y=CHOOSE_SET_HEIGH +VERTICAL_DISTANCE;
            }
            else
            {
                ObTagCell *lastTagCell = [arrayOptionTags objectAtIndex:i-1];
                
                if(self.frame.size.width - lastTagCell.frame.origin.x - lastTagCell.frame.size.width < HORIZONTAL_DISTANCE+HORIZONTAL_DISTANCE + tagCell.frame.size.width)
                {
                    rect.origin.y = lastTagCell.frame.origin.y
                    + lastTagCell.frame.size.height+ VERTICAL_DISTANCE;
                    
                    rect.origin.x = HORIZONTAL_DISTANCE;
                }
                else
                {
                    rect.origin.y = lastTagCell.frame.origin.y;
                    
                    rect.origin.x = lastTagCell.frame.origin.x + lastTagCell.frame.size.width+HORIZONTAL_DISTANCE;
                }
            }
            
            tagCell.frame= rect;
        }
        
    }];
    
}



#pragma mark------ClickAction-----

- (void) tagClickAction:(ObTagCell *)sender
{
    
    if([arrayChoosedTags containsObject:sender])
    {
        [arrayChoosedTags removeObject:sender];
        [arrayOptionTags addObject:sender];
        sender.backgroundColor = [UIColor clearColor];
    }
    else if([arrayOptionTags containsObject:sender])
    {
        [arrayOptionTags removeObject:sender];
        [arrayChoosedTags addObject:sender];
        sender.backgroundColor = [arrayColor objectAtIndex:rand()%[arrayColor count]];
    }
    
    [self resetPosition];
}


#pragma mark------getResult-----
- (NSMutableArray *)getResultChoosedTags
{
    
    NSMutableArray * resultChoosedTagStrings = [[NSMutableArray alloc]init];
    
    for (int i=0; i<[arrayChoosedTags count]; i++) {
        
        ObTagCell *tagCell = [arrayChoosedTags objectAtIndex:i];
        
        [resultChoosedTagStrings addObject:tagCell.titleShowLable.text];
    }
    
    return resultChoosedTagStrings;
}

@end
