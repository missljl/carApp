//
//  SharManger.h
//  gaoxiaoshiping
//
//  Created by 1111 on 2017/6/27.
//  Copyright © 2017年 1111. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Sharmodel.h"
@interface SharManger : NSObject

+(id)manager;

//添加收藏
-(void)addModel:(Sharmodel*)model;

-(void)deleteModel:(Sharmodel *)model;

-(NSMutableArray *)allModels;

-(BOOL)isExists:(id)model;

-(void)deletes;

//事务:一组数据库的操作
- (void)beginTransaction;

//当开启事务以后,遇到回滚,那么开启事务之后所做的所有操作全部撤销
- (void)rollback;

//提交,开启事务之后所有操作真实生效
- (void)commit;
@end
