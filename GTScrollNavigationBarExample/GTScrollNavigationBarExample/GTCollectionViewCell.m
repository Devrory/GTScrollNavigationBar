//
//  GTCollectionViewCell.m
//  GTScrollNavigationBarExample
//
//  Created by Rory on 16/5/15.
//  Copyright © 2016年 Luu Gia Thuy. All rights reserved.
//

#import "GTCollectionViewCell.h"

@implementation GTCollectionViewCell

- (id)init
{
    self = [super init];
    if (self)
    {
        // 初始化时加载collectionCell.xib文件
        NSArray *arrayOfViews = [[NSBundle mainBundle] loadNibNamed:@"MyCollectionCell" owner:self options:nil];
        
        // 如果路径不存在，return nil
        if (arrayOfViews.count < 1)
        {
            return nil;
        }
        // 如果xib中view不属于UICollectionViewCell类，return nil
        if (![[arrayOfViews objectAtIndex:0] isKindOfClass:[UICollectionViewCell class]])
        {
            return nil;
        }
        // 加载nib
        self = [arrayOfViews objectAtIndex:0];
    }
    return self;
}

@end
