//
//  TagCell.m
//  lemonshow
//
//  Created by obo on 15/8/6.
//  Copyright (c) 2015年 OboTag. All rights reserved.
//

#import "ObTagCell.h"

@implementation ObTagCell

- (id)initWithTitle:(NSString *)title
{
    if ([super init]) {
        
        UIFont *font = [UIFont fontWithName:nil size:14];
        
        CGRect rect = [ObTagCell getFontSizeWithString:title withFont:font withMaxWidth:MAXFLOAT withMaxHeight:MAXFLOAT];
        
        self.titleShowLable = [[UILabel alloc]initWithFrame:CGRectMake(20, 10, rect.size.width, rect.size.height)];
        
        [self.titleShowLable setText:title];
        [self.titleShowLable setFont:font];
        [self.titleShowLable setTextColor:[UIColor whiteColor]];
        
        [self addSubview:self.titleShowLable];
        
        self.frame = CGRectMake(0, 0, self.titleShowLable.frame.size.width+40, self.titleShowLable.frame.size.height+20);
        self.layer.cornerRadius = 4;
        self.clipsToBounds = YES;
        
        self.backgroundColor = [UIColor clearColor];
        self.titleShowLable.textColor = [UIColor blackColor];
        self.layer.borderWidth = 1;
        
    }
    
    return self;
}


+ (CGRect)getFontSizeWithString:(NSString *)String withFont:(UIFont *)font withMaxWidth:(CGFloat )maxWidth withMaxHeight:(CGFloat )maxHeight
{
    CGRect rect= [String boundingRectWithSize:CGSizeMake(maxWidth, maxHeight) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObjectsAndKeys:font,NSFontAttributeName, nil] context:nil];
    return rect;
}




@end
