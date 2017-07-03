//
//  XQModel.m
//  gaoxiaoshiping
//
//  Created by 1111 on 2017/6/26.
//  Copyright © 2017年 1111. All rights reserved.
//

#import "XQModel.h"

@implementation XQModel
+(JSONKeyMapper *)keyMapper{
    return [[JSONKeyMapper alloc]initWithDictionary:@{@"id":@"ida",@"title":@"title1"}];
}
@end
