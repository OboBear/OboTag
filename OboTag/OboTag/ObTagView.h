//
//  ObTagView.h
//  OboTag
//
//  Created by obo on 15/8/9.
//  Copyright (c) 2015年 ObTag. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ObTagView : UIView

- (id) initWithFrame:(CGRect)frame withOptionTags:(NSMutableArray *)optionString withChoosedTags:(NSMutableArray *)choosedString;
- (NSMutableArray *)getResultChoosedTags;

@end
