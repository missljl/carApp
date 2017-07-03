//
//  RootViewController.h
//  gaoxiaoshiping
//
//  Created by 1111 on 2017/6/25.
//  Copyright © 2017年 1111. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Define.h"
#import "MJRefresh.h"
#import "UIImage+WebP.h"
#import "AFNetworking.h"
#import "HttpManager.h"
@interface RootViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>

{
    
    
    NSMutableArray *_dataArray;
    NSInteger _currentPage;
//    NSInteger _totalPage;
    UITableView *_tableView;
    
    
    
}
-(void)configUI;
-(void)loadData;
//UICollectionViewDelegateFlowLayout,UICollectionViewDataSource
-(void)addRefreshHeader:(BOOL)ishavHeader andHaveFooter:(BOOL) havFooter;
//下拉刷新
-(void)reloadData;
//加载跟多
-(void)loadMore;

-(void)addBarBtnItemWithTitle:(NSString *)title withImageName:(NSString *)imageName withPosition:(NSInteger) position;
-(void)leftClick;
-(void)rightClick;



@end
