//
//  ViewController.m
//  OboTag
//
//  Created by obo on 15/8/7.
//  Copyright (c) 2015年 OboTag. All rights reserved.
//

#import "ViewController.h"
#import "TagCell.h"

#define VERTICAL_DISTANCE 10
#define HORIZONTAL_DISTANCE 10

#define CHOOSE_SET_HEIGH 200

@interface ViewController ()
{
    NSMutableArray          *arrayChoosedTags;
    NSMutableArray          *arrayOptionTags;
}


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initPredatas];
    [self initContentView];
}




- (void) initPredatas
{
    arrayChoosedTags = [[NSMutableArray alloc]init];
    arrayOptionTags  = [[NSMutableArray alloc]init];
}


- (void) initContentView
{
    NSArray *titlePool = @[@"美食", @"音乐", @"自由",@"书画",@"obo",@"标签"];
    
    for (int i=0; i<[titlePool count]; i++) {
        TagCell *tagCell = [[TagCell alloc]initWithTitle:[titlePool objectAtIndex:i]];
        tagCell.titleShowLable.textColor = [UIColor blackColor];
        
        
        [tagCell addTarget:self action:@selector(tagClickAction:) forControlEvents:UIControlEventTouchUpInside];
        [arrayOptionTags addObject:tagCell];
    }
    
    [self setPosition];
}


- (void) setPosition
{
    for (int i=0; i<[arrayOptionTags count]; i++) {
        
        TagCell *tagCell = [arrayOptionTags objectAtIndex:i];
        
        [self.view addSubview:tagCell];
        CGRect rect= tagCell.frame;

        if(!i)
        {
            rect.origin.x = HORIZONTAL_DISTANCE;
            rect.origin.y=CHOOSE_SET_HEIGH +VERTICAL_DISTANCE;
        }
        else
        {
            TagCell *lastTagCell = [arrayOptionTags objectAtIndex:i-1];
            
            NSLog(@"%f    %f",self.view.frame.size.width - lastTagCell.frame.origin.y - lastTagCell.frame.size.width,HORIZONTAL_DISTANCE+HORIZONTAL_DISTANCE + tagCell.frame.size.width);
            if(self.view.frame.size.width - lastTagCell.frame.origin.x - lastTagCell.frame.size.width < HORIZONTAL_DISTANCE+HORIZONTAL_DISTANCE + tagCell.frame.size.width)
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
}


- (void) resetPosition
{
    
    [UIView animateWithDuration:0.5 animations:^{
        
        for (int i=0; i<[arrayChoosedTags count]; i++) {
            
            TagCell *tagCell = [arrayChoosedTags objectAtIndex:i];
            CGRect rect= tagCell.frame;

            if(!i)
            {
                rect.origin.x = HORIZONTAL_DISTANCE;
                rect.origin.y= VERTICAL_DISTANCE + 50;
            }
            else
            {
                TagCell *lastTagCell = [arrayChoosedTags objectAtIndex:i-1];
                
                if(self.view.frame.size.width - lastTagCell.frame.origin.x - lastTagCell.frame.size.width < HORIZONTAL_DISTANCE+HORIZONTAL_DISTANCE + tagCell.frame.size.width)
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
            
            TagCell *tagCell = [arrayOptionTags objectAtIndex:i];
            
            CGRect rect= tagCell.frame;
            
            if(!i)
            {
                rect.origin.x = HORIZONTAL_DISTANCE;
                rect.origin.y=CHOOSE_SET_HEIGH +VERTICAL_DISTANCE;
            }
            else
            {
                TagCell *lastTagCell = [arrayOptionTags objectAtIndex:i-1];
                
                if(self.view.frame.size.width - lastTagCell.frame.origin.x - lastTagCell.frame.size.width < HORIZONTAL_DISTANCE+HORIZONTAL_DISTANCE + tagCell.frame.size.width)
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





#pragma mark-----Action-----

- (void) tagClickAction:(TagCell *)sender
{
    
    if([arrayChoosedTags containsObject:sender])
    {
        [arrayChoosedTags removeObject:sender];
        [arrayOptionTags addObject:sender];
        

    }
    else if([arrayOptionTags containsObject:sender])
    {
        
        [arrayOptionTags removeObject:sender];
        [arrayChoosedTags addObject:sender];
        
    }
    
    [self resetPosition];
}





@end
