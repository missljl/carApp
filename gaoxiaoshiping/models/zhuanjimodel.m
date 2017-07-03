//
//  zhuanjimodel.m
//  gaoxiaoshiping
//
//  Created by 1111 on 2017/6/28.
//  Copyright © 2017年 1111. All rights reserved.
//

#import "zhuanjimodel.h"

@implementation zhuanjimodel
+(JSONKeyMapper *)keyMapper{
    return [[JSONKeyMapper alloc]initWithDictionary:@{@"id":@"ida",@"title":@"title1"}];
}
@end
