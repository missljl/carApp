//
//  qutumodel.m
//  gaoxiaoshiping
//
//  Created by 1111 on 2017/6/27.
//  Copyright © 2017年 1111. All rights reserved.
//

#import "qutumodel.h"

@implementation qutumodel
+(JSONKeyMapper *)keyMapper{
    return [[JSONKeyMapper alloc]initWithDictionary:@{@"id":@"ida",@"title":@"title1"}];
}
@end
