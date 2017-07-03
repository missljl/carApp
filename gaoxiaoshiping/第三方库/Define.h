//
//  Define.h
//  Comic island
//
//  Created by qianfeng on 15-10-21.
//  Copyright (c) 2015年 李金龙. All rights reserved.
//

#ifndef Comic_island_Define_h
#define Comic_island_Define_h
#define kScreenWidth CGRectGetWidth([UIScreen mainScreen].bounds)
#define kScreenHeight CGRectGetHeight([UIScreen mainScreen].bounds)
//清缓存宏定义
#define _CH @"Cache"

//title的key
#define TITLE @"TITLE"

//navgationBar的title的key
#define NAV_TITLE @"NAV_TITLE"

//tabar的title的key
#define TAB_TITLE @"TAB_TITLE"

//tabarItem 图片
#define TABAR_ITEM_IMAGE @"TABAR_ITEM_IMAGE"

//选中的图片
#define TABAR_SET_ITEM_IMAGE @"TABAR_SET_ITEM_IMAGE"

//字体颜色
#define TITLE_COLOR [UIColor colorWithRed:0.95f green:0.53f blue:0.40f alpha:1.00f]

//屏幕的宽
#define TABLEVIEW_COLOR [UIColor colorWithRed:30/255.0 green:160/255.0 blue:230/255.0 alpha:1]
//屏幕的宽
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
//屏幕的高
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
//宽的比例
#define RATE SCREEN_WIDTH/320.0
//左边按钮
#define LEFT_BARITEM 1
//右边按钮
#define RIGHT_BARITEM (@"web")

#define KWS(weakSelf) __weak __typeof(&*self) weakSelf=self

//自定义颜色
#define COLOR(r,g,b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]


#pragma mark - 网络请求

//推荐(post)
#define URL_SOUYE (@"http://gaoxiaoshipin.vipappsina.com/index.php/NewApi38/index/markId/0/random/0/sw/1")

#define URL_WEB_SOUYE (@"http://gaoxiaoshipin.vipappsina.com/index.php/NewApi38/getVideoMp4Url")

///专题
#define URL_PROJECT (@"http://gaoxiaoshipin.vipappsina.com/index.php/NewApi38/index/lastId/%ld/random_more/0/sw/1")

//书架
#define URL_XINAGQIN (@"http://gaoxiaoshipin.vipappsina.com/index.php/Comment/index/newsId/%@/lastId/0")

#define URL_TU (@"http://xiaoliao.sinaapp.com/index.php/GIF_38/index/markId/0/lastId/%@/sw/1")
#endif
