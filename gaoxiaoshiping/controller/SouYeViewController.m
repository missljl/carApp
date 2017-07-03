//
//  SouYeViewController.m
//  gaoxiaoshiping
//
//  Created by 1111 on 2017/6/25.
//  Copyright © 2017年 1111. All rights reserved.
//

#import "SouYeViewController.h"
#import "RootTableViewCell.h"
#import "FMGVideoPlayView.h"
#import "FullViewController.h"
#import "SYModel.h"
#import "LJLSeachbar.h"
#import "MJRefresh.h"

#import "UIImageView+WebCache.h"
#import "shipingViewController.h"

#import "SeachViewController.h"

@interface SouYeViewController ()<FMGVideoPlayViewDelegate,LJLSeachbarDelegate>


//@property (nonatomic, strong) NSArray * videoSidArray; // videoSid数组
@property (nonatomic, strong) NSMutableArray * videoArray; // video数组
@property (nonatomic, strong) FMGVideoPlayView * fmVideoPlayer; // 播放器
/* 全屏控制器 */
@property (nonatomic, strong) FullViewController *fullVc;

@property (nonatomic, strong) LJLSeachbar *seachbarview;

@property(nonatomic,strong)NSIndexPath *indexpath;

@end

@implementation SouYeViewController

{
    NSString *webstring;
    
}
static NSString *ID = @"cell";
- (void)viewDidLoad {
    [super viewDidLoad];
//    self.navigationController.navigationBarHidden = NO;
    
    
       [self configUI];
    [self loadData];
     _currentPage=40150;
    
    
    
    [self addBarBtnItemWithTitle:@"" withImageName:@"" withPosition:1];
    
//    self.view.backgroundColor =[UIColor whiteColor];
    // Do any additional setup after loading the view.
}
-(void)configUI{


    [super configUI];
  [_tableView registerClass:[RootTableViewCell class] forCellReuseIdentifier:ID];
    self.fmVideoPlayer =[FMGVideoPlayView videoPlayView];
    self.fmVideoPlayer.delegate =self;
    [self addRefreshHeader:NO andHaveFooter:YES];
    
       self.title =@"搞笑视频";
//    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
   self.navigationController.navigationBar.barTintColor = [UIColor yellowColor];
    
//    UIImageView *tiview =[[UIImageView alloc]init];
//    tiview.frame =CGRectMake(0, 0, 100, 28);
//    tiview.backgroundColor=[UIColor redColor];
//    [self.navigationItem.titleView addSubview:tiview];
    
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 290;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    return 60;

}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    RootTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID forIndexPath:indexPath]; //根据indexPath准确地取出一行，而不是从cell重用队列中取出

//    RootTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath]; //根据indexPath准确地取出一行，而不是从cell重用队列中取出
//    if (cell == nil) {
//        cell = [[RootTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
//    }
    
    
    
 SYModel *video = _dataArray[indexPath.row];
    
    cell.title.text = video.title1;
    //    self.descriptionLabel.text = video.title1;
    [cell.backImage sd_setImageWithURL:[NSURL URLWithString:video.pic] placeholderImage:[UIImage imageNamed:@"logo"]];
    //    [self.backImage ]
    cell.playCountLabel.text = [NSString stringWithFormat:@"%@次",video.zan_num];
    cell.timeLabel.text = video.cTime;
   
    [cell.playButton setBackgroundImage:[UIImage imageNamed:@"play"] forState:UIControlStateNormal];
    cell.playCountImage.image = [UIImage imageNamed:@"dianzanda"];
    //    self.playCountImage.backgroundColor =[UIColor redColor];
    cell.timeImage.image = [UIImage imageNamed:@"time"];
    
    [cell.playButton addTarget:self action:@selector(playButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    
    cell.playButton.tag = 100 + indexPath.row;
    
//    _indexpath=cell.playButton.tag;
  
    
    
    
//     CGRectMake(0, 280*(sender.tag - 100) + (kScreenWidth*RATE)/5, kScreenWidth, (self.view.frame.size.width-20)/2)
    
    UIView *v =[[UIView alloc]initWithFrame:CGRectMake(0, cell.frame.size.height-8, cell.frame.size.width, 8)];
    v.backgroundColor =[UIColor lightGrayColor];
    v.alpha=0.3;
    [cell.contentView  addSubview:v];
    
    return cell;
}

// 根据点击的Cell控制播放器的位置
- (void)playButtonAction:(UIButton *)sender{
    _fmVideoPlayer.index = sender.tag - 100;
    SYModel * model = _dataArray[sender.tag - 100];
    
    
    
    
    
//    NSLog(@"======%f",sender.frame.origin.y);
    
  //UITableViewCell * cell = (UITableViewCell *)[[sender superview] superview];
 //   NSIndexPath * path = [_tableView indexPathForCell:cell];
  
//    NSLog(@"+++++%ld",[path row]);
    
//     CGRect  popoverRect = [_tableView convertRect:[_tableView rectForRowAtIndexPath:path] toView:[_tableView superview]];
    
//    NSLog(@"-----%f",popoverRect.origin.y);
    
    
    if ([model.mp4_url isEqualToString:RIGHT_BARITEM]) {
        NSString *str =[NSString stringWithFormat:@"%@",model.url];
        str =[str stringByReplacingOccurrencesOfString:@":" withString:@"%3A"];
        str =[str stringByReplacingOccurrencesOfString:@"/" withString:@"%2F"];
        NSDictionary *dic =@{@"url":str};
     [self webload:dic];
    
    }else{
    
    [_fmVideoPlayer setUrlString:model.mp4_url];
    
    }
    
//    NSLog(@"se%f",self.view.frame.size.height);
    
//    if (self.view.frame.size.height==480) {
     _fmVideoPlayer.frame = CGRectMake(0, 290*(sender.tag - 100)+109, kScreenWidth, (self.view.frame.size.width-20)/2);
//    }else{
//
//     CGRectMake(0, 280*(sender.tag - 100) + (kScreenWidth*RATE)/5, kScreenWidth, (self.view.frame.size.width-20)/2)
//        _fmVideoPlayer.frame =CGRectMake(0, popoverRect.origin.y, kScreenWidth, (self.view.frame.size.width-20)/2);
    
    
//    }
    [_tableView addSubview:_fmVideoPlayer];
    _fmVideoPlayer.contrainerViewController = self;
      [_fmVideoPlayer.player play];
  
    _fmVideoPlayer.playOrPauseBtn.selected = YES;
        _fmVideoPlayer.hidden = NO;
    
    
    
    
}
// 根据Cell位置隐藏并暂停播放(这个代理方法是消失的cell)
- (void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.row == _fmVideoPlayer.index) {
        
        
        
        [_fmVideoPlayer.player pause];
        _fmVideoPlayer.hidden = YES;
    }
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [_fmVideoPlayer.player pause];
    _fmVideoPlayer.hidden = YES;
    
    
     UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
     cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
   shipingViewController *videoController = [[shipingViewController alloc]init];
    
    SYModel *model =_dataArray[indexPath.row];
    
    if ([model.mp4_url isEqualToString:RIGHT_BARITEM]) {
        NSString *str =[NSString stringWithFormat:@"%@",model.url];
        str =[str stringByReplacingOccurrencesOfString:@":" withString:@"%3A"];
        str =[str stringByReplacingOccurrencesOfString:@"/" withString:@"%2F"];
//        NSDictionary *dic =@{@"url":str};
//        [self webload:dic];
 
        videoController.strid =str;
        
          }else{
    
              videoController.strid=model.mp4_url;
    
    
    }
    videoController.zanstr=model.zan_num;
    videoController.titlestr =model.title1;
    videoController.ida =model.ida;
    videoController.imagestr=model.pic;
//    videoController.video = self.videoArray[indexPath.row];
    [self.navigationController pushViewController:videoController animated:YES];
    self.navigationController.navigationBarHidden = YES;
    
    
    //    VideoViewController *videoController = [VideoViewController shareVideoController];
    //    videoController.video = self.videoArray[indexPath.row];
    //    [self.navigationController pushViewController:videoController animated:YES];
}


//组头
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{


    
    _seachbarview = [[LJLSeachbar alloc]initWithFrame:CGRectMake(0,0, SCREEN_WIDTH, 44) placeholder:@"搜索视频" delegate:self];
    [_seachbarview showInView:self.view];
    
    return _seachbarview;

}
//代理搜索借口代理
-(void)searchWithKey:(NSString *)key
{
//    NSLog(@"%@",key);
//    NSString *a =[key stringByAddingPercentEncodingWithAllowedCharacters:NSUTF8StringEncoding];
    NSString *encodeString = [key stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    SeachViewController *seach =[[SeachViewController alloc]init];
    
    seach.seachtring=encodeString;
    
    seach.title=@"搜索";
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
    [self.navigationController pushViewController:seach animated:YES];
    
    
//    _str=encodeString;
//    [self configUI];
//    [self loadData];
    
}




#pragma mark - 懒加载代码播放器全频按钮代理
- (FullViewController *)fullVc
{
    if (_fullVc == nil) {
        _fullVc = [[FullViewController alloc] init];
    }
    return _fullVc;
}

- (void)videoplayViewSwitchOrientation:(BOOL)isFull{
    if (isFull) {
        [self.navigationController presentViewController:self.fullVc animated:NO completion:^{
            [self.fullVc.view addSubview:self.fmVideoPlayer];
            _fmVideoPlayer.center = self.fullVc.view.center;
          
            
            [UIView animateWithDuration:0.2 delay:0.0 options:UIViewAnimationOptionLayoutSubviews animations:^{
                
               
                _fmVideoPlayer.frame = self.fullVc.view.bounds;
                
//                self.fmVideoPlayer.danmakuView.frame = self.fmVideoPlayer.frame;
                
            } completion:nil];
        }];
    } else {
        [self.fullVc dismissViewControllerAnimated:NO completion:^{
           
            _fmVideoPlayer.frame = CGRectMake(0,  280 * _fmVideoPlayer.index + kScreenWidth/5 + 35, kScreenWidth, (kScreenWidth-20)/2);
        }];
  

         [_tableView addSubview:_fmVideoPlayer];
        
        
    }
    
}

#pragma 网络请求

//web网络请求
-(void)webload:(NSDictionary *)dic{

    
    AFHTTPSessionManager *manger =[AFHTTPSessionManager manager];
    manger.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"text/json",@"text/plain",@"application/json",@"text/html",nil];
    
    [manger POST:URL_WEB_SOUYE parameters:dic progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        webstring =responseObject[@"url"];
//        NSLog(@"webstring%@",responseObject[@"url"]);
        [_fmVideoPlayer setUrlString:webstring];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
       
        
        
    }];
    
  
   

}
-(void)loadData{
    
    
    HttpManager *manger =[HttpManager shareManager];
    [manger requestWithUrl:URL_SOUYE withDictionary:nil withSuccessBlock:^(id responseObject) {
        
        NSArray *ar = responseObject[@"rows"];
        
        for (NSDictionary *dic in ar) {
            
            SYModel *model =[[SYModel alloc]initWithDictionary:dic error:nil];
            [_dataArray addObject:model];
            
            
        }
        [_tableView reloadData];
        
        //        NSLog(@"%@",responseObject);
        
    } withFailureBlock:^(NSError *error) {
        
    }];
    
    
    
    
}
-(void)loadDatatwo:(NSInteger)index{
    
    
    
    
    HttpManager *manger =[HttpManager shareManager];
   
    NSString *sr =[NSString stringWithFormat:URL_PROJECT,index];
    
    [manger requestWithUrl:sr withDictionary:nil withSuccessBlock:^(id responseObject) {
        
        
        [_tableView.mj_footer endRefreshing];
        
        NSArray *ar = responseObject;
        for (NSDictionary *dic in ar) {
            
            SYModel *model =[[SYModel alloc]initWithDictionary:dic error:nil];
            [_dataArray addObject:model];
            
        }
        [_tableView reloadData];
        
    } withFailureBlock:^(NSError *error) {
        [_tableView.mj_footer endRefreshing];
    }];
    
    
}

-(void)loadMore{

    [_tableView.mj_footer endRefreshing];
    _currentPage=_currentPage-15;
  
    [self loadDatatwo:_currentPage];
    
}


-(UIInterfaceOrientationMask)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskPortrait;
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
