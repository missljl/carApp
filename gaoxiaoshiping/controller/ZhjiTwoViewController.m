//
//  ZhjiTwoViewController.m
//  gaoxiaoshiping
//
//  Created by 1111 on 2017/6/28.
//  Copyright © 2017年 1111. All rights reserved.
//

#import "ZhjiTwoViewController.h"
#import "SYModel.h"

#import "RootTableViewCell.h"

#import "UIImageView+WebCache.h"

static NSString *ID = @"cell";
#import "FullViewController.h"
#import "shipingViewController.h"
@interface ZhjiTwoViewController ()<FMGVideoPlayViewDelegate>

@property (nonatomic, strong) FMGVideoPlayView * fmVideoPlayer; // 播放器
/* 全屏控制器 */
@property (nonatomic, strong) FullViewController *fullVc;




@end

@implementation ZhjiTwoViewController
{
    NSString *webstring;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self configUI];
    [self loadData];
    // Do any additional setup after loading the view.
}

-(void)configUI{

    [super configUI];
    
    self.fmVideoPlayer =[FMGVideoPlayView videoPlayView];
    self.fmVideoPlayer.delegate =self;

    [self addRefreshHeader:NO andHaveFooter:YES];
      [_tableView registerClass:[RootTableViewCell class] forCellReuseIdentifier:ID];
//pinglun
//http://gaoxiaoshipin.vipappsina.com/index.php/Comment/index/newsId/zhuan_2279/lastId/0

}
-(void)loadData{

    
    
    NSString *urlstr =[NSString stringWithFormat:@"http://gaoxiaoshipin.vipappsina.com/index.php/NewZhuan38/videoList/cid/%@/lastId/0/sw/1",_sidatring];
    
    
    HttpManager *manger =[HttpManager shareManager];
    [manger requestWithUrl:urlstr withDictionary:nil withSuccessBlock:^(id responseObject) {
    
        NSArray *ar =responseObject[@"rows"];
        
        for (NSDictionary *dic in ar) {
            
            SYModel *model =[[SYModel alloc]initWithDictionary:dic error:nil];
            
            [_dataArray addObject:model];
            
        }
        
        [_tableView reloadData];
    
} withFailureBlock:^(NSError *error) {
    
    
    
}];

}

-(void)loadData:(NSString *)string{


    NSString *urlstr =[NSString stringWithFormat:@"http://gaoxiaoshipin.vipappsina.com/index.php/NewZhuan38/videoList/cid/%@/lastId/%@/sw/1",_sidatring,string];
    
    
    HttpManager *manger =[HttpManager shareManager];
    [manger requestWithUrl:urlstr withDictionary:nil withSuccessBlock:^(id responseObject) {
        
        
        [_tableView.mj_footer endRefreshing];
        NSArray *ar =responseObject;
        
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

    SYModel *model =_dataArray.lastObject;

    [self loadData:model.ida];
    
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 280;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
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
    
    UIView *v =[[UIView alloc]initWithFrame:CGRectMake(0, cell.frame.size.height-8, cell.frame.size.width, 8)];
    v.backgroundColor =[UIColor lightGrayColor];
    v.alpha=0.3;
    [cell.contentView  addSubview:v];
    
    return cell;
    
    
   
    
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
    videoController.ida =[NSString stringWithFormat:@"zhuan_%@",model.ida];
    //    videoController.video = self.videoArray[indexPath.row];
    [self.navigationController pushViewController:videoController animated:YES];
    self.navigationController.navigationBarHidden = YES;
    
    
    //    VideoViewController *videoController = [VideoViewController shareVideoController];
    //    videoController.video = self.videoArray[indexPath.row];
    //    [self.navigationController pushViewController:videoController animated:YES];
}








// 根据点击的Cell控制播放器的位置
- (void)playButtonAction:(UIButton *)sender{
    _fmVideoPlayer.index = sender.tag - 100;
    SYModel * model = _dataArray[sender.tag - 100];
    
    if ([model.mp4_url isEqualToString:RIGHT_BARITEM]) {
        NSString *str =[NSString stringWithFormat:@"%@",model.url];
        str =[str stringByReplacingOccurrencesOfString:@":" withString:@"%3A"];
        str =[str stringByReplacingOccurrencesOfString:@"/" withString:@"%2F"];
        NSDictionary *dic =@{@"url":str};
        [self webload:dic];
        
    }else{
        
        [_fmVideoPlayer setUrlString:model.mp4_url];
        
    }
    
    _fmVideoPlayer.frame = CGRectMake(0, 280*(sender.tag - 100) + 49, kScreenWidth, (self.view.frame.size.width-20)/2);
    [_tableView addSubview:_fmVideoPlayer];
    _fmVideoPlayer.contrainerViewController = self;
    [_fmVideoPlayer.player play];
    [_fmVideoPlayer showToolView:NO];
    _fmVideoPlayer.playOrPauseBtn.selected = YES;
    _fmVideoPlayer.hidden = NO;
    
    
    
    
}
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

-(void)dealloc{


    [_fmVideoPlayer.player pause];
    [_fmVideoPlayer.player setRate:0];
    _fmVideoPlayer.playOrPauseBtn.selected = NO;

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
