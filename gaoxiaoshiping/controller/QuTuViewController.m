//
//  QuTuViewController.m
//  gaoxiaoshiping
//
//  Created by 1111 on 2017/6/25.
//  Copyright © 2017年 1111. All rights reserved.
//
#define kDegreesToRadian(x) (M_PI * (x) / 180.0)

#define kRadianToDegrees(radian) (radian*180.0)/(M_PI)

#import "Define.h"
#import "QuTuViewController.h"
#import "MBProgressHUD.h"
#import "HttpManager.h"
#import "qutumodel.h"


#import "UIImageView+WebCache.h"
#import "qutuCell.h"
#import "TUxiangViewController.h"
static NSString *ID = @"qutucell";
@interface QuTuViewController ()
{
        CGFloat angle;
    UIImageView *imagev;
    

    
}

@end

@implementation QuTuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
//  _currentPage=245515;
     _dataArray = [[NSMutableArray alloc]init];
    self.automaticallyAdjustsScrollViewInsets=NO;
    self.view.backgroundColor =[UIColor whiteColor];
    self.title=@"动图";
    [self configUI];
   [self loadData];
    self.navigationController.navigationBar.barTintColor = [UIColor yellowColor];
    // Do any additional setup after loading the view.
}
-(void)configUI{
    
    [super configUI];
    
    [_tableView registerNib:[UINib nibWithNibName:@"qutuCell" bundle:nil] forCellReuseIdentifier:ID];
[self addRefreshHeader:NO andHaveFooter:YES];
    
    
    
}
-(void)loadData{

//    NSString *a =[NSString stringWithFormat:URL_TU,_currentPage];
    [[HttpManager shareManager]requestWithUrl:@"http://xiaoliao.sinaapp.com/index.php/GIF_38/index/markId/0/lastId/0/sw/1" withDictionary:nil withSuccessBlock:^(id responseObject) {
        
       NSArray *ar =responseObject[@"rows"];
      for (NSDictionary *dic in ar) {
          
          qutumodel *model =[[qutumodel alloc]initWithDictionary:dic error:nil];
         [_dataArray addObject:model];
       }
      [_tableView reloadData];
    } withFailureBlock:^(NSError *error) {
        
    }];
}

-(void)loadDatatwo:(NSString *)cupage{
    
    //http://xiaoliao.sinaapp.com/index.php/GIF_38/index/markId/0/lastId/245509/sw/1
      NSString *a =[NSString stringWithFormat:URL_TU,cupage];
    [[HttpManager shareManager]requestWithUrl:a withDictionary:nil withSuccessBlock:^(id responseObject) {
         [_tableView.mj_footer endRefreshing];
        NSArray *ar =responseObject;
        for (NSDictionary *dic in ar) {
            
            qutumodel *model =[[qutumodel alloc]initWithDictionary:dic error:nil];
            [_dataArray addObject:model];
        }
        [_tableView reloadData];
    } withFailureBlock:^(NSError *error) {
        [_tableView.mj_footer endRefreshing];
    }];
}




- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 230;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    qutuCell *cell = [tableView dequeueReusableCellWithIdentifier:ID forIndexPath:indexPath]; //根据indexPath准确地取出一行，而不是从cell重用队列中取出
    
    
    qutumodel *model= _dataArray[indexPath.row];
    [cell.qutuimageview sd_setImageWithURL:[NSURL URLWithString:model.pic]];
    
    cell.titlelable.text = model.title1;
    cell.timelable.text =model.cTime;
    cell.timelable.textColor =[UIColor lightGrayColor];
    cell.timelable.font =[UIFont systemFontOfSize:13];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{


    //取消tableview选中被禁色
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;


    TUxiangViewController *tu =[[TUxiangViewController alloc]init];
    
    tu.imagear=[_dataArray copy];
    tu.picindex=indexPath.row;
    
    tu.tuzongshu=_dataArray.count;
    
    
    //自定义到行条字体颜色
//    UIBarButtonItem *backItem=[[UIBarButtonItem alloc]init];
//    backItem.title=@"后退";
//    backItem.tintColor=[UIColor colorWithRed:129/255.0 green:129/255.0 blue:129/255.0 alpha:1.0];
//    self.navigationItem.backBarButtonItem = backItem;
    //改到行条按钮颜色
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
//    [[UINavigationBar appearance]setTintColor:[UIColor blackColor]];
    [self.navigationController pushViewController:tu animated:YES];

}

-(void)loadMore{

      [_tableView.mj_footer endRefreshing];
    
    qutumodel *model =_dataArray.lastObject;
//    _currentPage=model.news_id;
   
    [self loadDatatwo:model.news_id];

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
