//
//  RootViewController.m
//  gaoxiaoshiping
//
//  Created by 1111 on 2017/6/25.
//  Copyright © 2017年 1111. All rights reserved.
//

#import "RootViewController.h"

@interface RootViewController ()

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
    self.view.backgroundColor = [UIColor whiteColor];
    
    _dataArray = [[NSMutableArray alloc]init];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
//    [self loadData];

  self.navigationController.navigationBar.barTintColor = [UIColor yellowColor];
    
}
-(void)configUI
{
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH*RATE, SCREEN_HEIGHT-64-49) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    [self.view addSubview:_tableView];
    
}
-(void)loadData
{
   // NSLog(@"子类要重写");
    
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return nil;
    
}

-(void)addRefreshHeader:(BOOL)ishavHeader andHaveFooter:(BOOL) havFooter
{
    //风格要一致,要么用block,要么用第一个
    if (ishavHeader) {
        _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(reloadData)];
        //这个是开始加载数据
        [_tableView.mj_header beginRefreshing];
    }
    if(havFooter){
        KWS(ws);
        _tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            //上啦加载更多
            [ws loadMore];
        }];
        
    }
}
//下拉刷新
-(void)reloadData
{
   // NSLog(@"子类要重写");
}
//加载跟多
-(void)loadMore
{
   // NSLog(@"子类要重写");
    
}
-(void)addBarBtnItemWithTitle:(NSString *)title withImageName:(NSString *)imageName withPosition:(NSInteger)position
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 44, 44);
    if (title.length>0) {
        [btn setTitle:title forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
        btn.titleLabel.font = [UIFont systemFontOfSize:16];
    }
    if (imageName.length>0) {
        UIImage *image = [UIImage imageNamed:imageName];
        if (image) {
            [btn setImage:image forState:UIControlStateNormal];
        }
    }
    UIBarButtonItem *BarItme = [[UIBarButtonItem alloc]initWithCustomView:btn];
    if (position==LEFT_BARITEM) {
        [btn addTarget:self action:@selector(leftClick) forControlEvents:UIControlEventTouchUpInside];
        self.navigationItem.leftBarButtonItem =BarItme;
    }else{
        [btn addTarget:self action:@selector(rightClick) forControlEvents:UIControlEventTouchUpInside];
        self.navigationItem.rightBarButtonItem = BarItme;
    }
    
}
-(void)leftClick
{
}
-(void)rightClick
{
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
