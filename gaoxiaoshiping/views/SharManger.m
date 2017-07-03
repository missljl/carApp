//
//  SharManger.m
//  gaoxiaoshiping
//
//  Created by 1111 on 2017/6/27.
//  Copyright © 2017年 1111. All rights reserved.
//

#import "SharManger.h"
#import "FMDatabase.h"
@implementation SharManger
{
    FMDatabase *_fmdb;
}
+(id)manager
{
    static SharManger *_m = nil;
    if (!_m) {
        _m = [[SharManger alloc]init];
    }
    return _m;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        //path:指数据库文件的位置
        NSString *path = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"]stringByAppendingPathComponent:@"gaoxiaoshar11.db"];
        //        NSLog(@"path%@",path);
        _fmdb = [[FMDatabase alloc]initWithPath:path];
        
        //打开数据库
        //如果这个数据库不存在,则先创建,再打开
        //如果已经存在,直接打开供后面使用
        BOOL success = [_fmdb open];
        if (success) {
            //如果打开成功,创建数据库表
            NSString *sql = @"create table if not exists app(applicationid varchar(32),strid,zan,title1,imagestr)";
            if(![_fmdb executeUpdate:sql])
            {
                NSLog(@"创建数据失败");
            }
        }
    }
    return self;
}



//添加收藏
-(void)addModel:(Sharmodel *)model
{
    //    NSString *sql = [NSString stringWithFormat: @"insert into app (applicationid,name,iconurl) values ('%@','%@','%@')",model.applicationId,model.name,model.iconUrl];
    //    NSLog(@"%@",sql);
    
    NSString *sql = @"insert into app (applicationid,strid,zan,title1,imagestr) values (?,?,?,?,?)";
    BOOL success = [_fmdb executeUpdate:sql,model.ida,model.strid,model.zan_num,model.title1,model.imagestr];
    if (success) {
        NSLog(@"收藏成功");
    }
}

-(void)deleteModel:(Sharmodel *)model
{
    NSString *sql = @"delete from app where applicationid=?";
    [_fmdb executeUpdate:sql,model.ida];
}
-(void)deletes{
    NSString *sql = @"delete from app";
    [_fmdb executeUpdate:sql];
    
}
-(NSMutableArray *)allModels
{
    NSMutableArray *resArr = [[NSMutableArray alloc]init];
    
    NSString *sql = @"select * from app";
    FMResultSet *result = [_fmdb executeQuery:sql];
    while ([result next]) {
        NSString *appid = [result stringForColumn:@"applicationid"];
          NSString *strid = [result stringForColumn:@"strid"];
          NSString *zan_num = [result stringForColumn:@"zan"];
          NSString *title = [result stringForColumn:@"title1"];
         NSString *imagestr = [result stringForColumn:@"imagestr"];
        //      NSString *name = [result stringForColumn:@"name"];
        
        //        LeftModel *model = [[LeftModel alloc]init];
        //        model.geneId = appid;
        //       model.geneName = name;
        
        Sharmodel *model =[[Sharmodel alloc]init];
        model.ida=appid;
        model.strid=strid;
        model.zan_num=zan_num;
        model.title1=title;
        model.imagestr=imagestr;
        [resArr addObject:model];
        
    }
    
    return resArr;
}

-(BOOL)isExists:(id)model
{
    NSString *appid;
    if ([model isKindOfClass:[Sharmodel class]]) {
        appid =[(Sharmodel *)model ida];
    }
    else
    {
        appid = model;
    }
    NSString *sql = @"select * from app where applicationid=?";
    FMResultSet *result = [_fmdb executeQuery:sql,appid];
    return [result next];
}

//事务:一组数据库的操作
- (void)beginTransaction
{
    //在开启事务之后 ,不能再开启事务
    if (![_fmdb inTransaction]) {
        [_fmdb beginTransaction];
    }
}

//当开启事务以后,遇到回滚,那么开启事务之后所做的所有操作全部撤销
- (void)rollback
{
    if ([_fmdb inTransaction]) {
        [_fmdb rollback];
    }
}

//提交,开启事务之后所有操作真实生效
- (void)commit
{
    if ([_fmdb inTransaction]) {
        [_fmdb commit];
    }
}
@end
