//
//  shipingViewController.m
//  gaoxiaoshiping
//
//  Created by 1111 on 2017/6/26.
//  Copyright © 2017年 1111. All rights reserved.
//
#define kScreenWidth CGRectGetWidth([UIScreen mainScreen].bounds)
#define kScreenHeight CGRectGetHeight([UIScreen mainScreen].bounds)
#import "shipingViewController.h"
#import "AFNetworking.h"
#import "Define.h"
#import "XQCell.h"
#import "XQModel.h"
#import "HttpManager.h"
#import "UIImageView+WebCache.h"

#import "FavoriteManager.h"
#import "SharManger.h"
#import "Sharmodel.h"
#import "MBProgressHUD.h"
@interface shipingViewController ()<FMGVideoPlayViewDelegate,UITableViewDelegate,UITableViewDataSource>


/* 全屏控制器 */
@property (nonatomic, strong) FullViewController *fullVc;

@property (nonatomic, assign) BOOL isShowDanmak;
/* 全屏控制器 */
@property (nonatomic, strong) UITableView *tableview;
@property (nonatomic, strong) NSMutableArray *array;
@property(nonatomic,strong)MBProgressHUD *hud;
@end

@implementation shipingViewController
{

    UIImageView *zanimageiiv;
    UILabel *zanlable;
    NSInteger zanshu;
    UIView *zanview;
    BOOL isdianzan;
    BOOL issharbtn;
    
    UIImageView *backview;
    
    
}

+ (instancetype)shareVideoController
{
    static shipingViewController * video = nil;
    static dispatch_once_t token;
    if (video == nil) {
        dispatch_once(&token, ^{
            video = [[shipingViewController alloc] init];
        });
    }
    return video;
}

//- (void)viewWillAppear:(BOOL)animated
//{
//    if ([_strid rangeOfString:@"%2F"].location!=NSNotFound) {
//        
//        NSDictionary *dic =@{@"url":_strid};
//        [self webload:dic];
//        [_playView.player play];
//        _playView.playOrPauseBtn.selected = YES;
//        
//    }else{
//    
//    
//    if (self.playView.urlString != _strid) {
//        [_playView setUrlString:_strid];
//        [_playView.player play];
//        _playView.playOrPauseBtn.selected = YES;
//    
//    
//    }
//        
//        
//    }
//}


- (void)viewDidLoad {
    [super viewDidLoad];
   
    _array =[[NSMutableArray alloc]init];
    
    
    
    
  [self p_play];
   [self cfingui];
    [self loadata];
    
   
    

    
}
/**
 *  播放器
 */
- (void)p_play{
    
    
    self.playView = [FMGVideoPlayView videoPlayView];
    self.playView.delegate = self;
    _playView.index = 0;
    // 视频资源路径
    if ([_strid rangeOfString:@"%2F"].location!=NSNotFound) {
        
        NSDictionary *dic =@{@"url":_strid};
        [self webload:dic];
       
        [_playView.player play];
        _playView.playOrPauseBtn.selected = YES;
        // 指定一个作为播放的控制器
        _playView.contrainerViewController = self;
         _playView.frame = CGRectMake(0, 22, kScreenWidth, kScreenWidth/2+30);
          [self.view addSubview:_playView];
        
    }else{
    
      [_playView setUrlString:_strid];
    // 播放器显示位置（竖屏时）
   _playView.frame = CGRectMake(0, 22, kScreenWidth, kScreenWidth/2+30);
    // 添加到当前控制器的view上
    [self.view addSubview:_playView];
    [_playView.player play];
    _playView.playOrPauseBtn.selected = YES;
    // 指定一个作为播放的控制器
    _playView.contrainerViewController = self;
//    _playView.danmakuView.delegate = self;
    }
    
    
}
-(void)cfingui{
    
    
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 44, 44);
    [btn setImage:[UIImage imageNamed:@"btn_back"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btns) forControlEvents:UIControlEventTouchUpInside];
    [_playView addSubview:btn];
    
    
    _tableview = [[UITableView alloc]initWithFrame:CGRectMake(0,kScreenWidth/2+52, self.view.frame.size.width, SCREEN_HEIGHT-64-49-kScreenWidth/2+30) style:UITableViewStyleGrouped];
    _tableview.delegate = self;
    _tableview.dataSource = self;
    
    [self.view addSubview:_tableview];
    
    [_tableview registerNib:[UINib nibWithNibName:@"XQCell" bundle:nil] forCellReuseIdentifier:@"xqcell"];
    backview =[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 150,150)];
    backview.center =CGPointMake(CGRectGetWidth(_tableview.frame)/2, CGRectGetHeight(_tableview.frame)/2);
    backview.image =[UIImage imageNamed:@"shafa"];
//    backview.hidden =NO;
    [_tableview addSubview:backview];
    
    
//    _tableview.backgroundColor =[UIColor redColor];
    
}
-(void)btns{
    
    if (_playView.frame.size.width>550) {
        
        [self.fullVc dismissViewControllerAnimated:NO completion:^{
            [self.view addSubview:_playView];
            _playView.frame = CGRectMake(0,  22, kScreenWidth, (kScreenWidth-20)/2+30);
        }];
  
        
    }else{
    
    
    [_playView.player pause];
    [_playView.player setRate:0];
    _playView.playOrPauseBtn.selected = NO;
    [self.navigationController popViewControllerAnimated:YES];
    self.navigationController.navigationBarHidden = NO;
    
    }
    
}

#pragma tableviewdelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if (_array.count>0) {
        
        backview.hidden=YES;
        
    }else{
        backview.hidden=NO;
    }
    return _array.count;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{


    return 1;

}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *cellid =@"xqcell";
    
    XQCell *cell =[tableView dequeueReusableCellWithIdentifier:cellid forIndexPath:indexPath];
    XQModel *model =_array[indexPath.row];
    [cell.nameimageivew sd_setImageWithURL:[NSURL URLWithString:model.profileImg]];
    cell.titlelable.text =model.uname;
    cell.timelable.text =model.cTime;
    cell.delable.text=model.con;
    cell.delable.font=[UIFont systemFontOfSize:15];
    cell.delable.numberOfLines=0;
    
    if ([model.con rangeOfString:@"@"].location!=NSNotFound) {
        
            NSMutableAttributedString *textColor = [[NSMutableAttributedString alloc]initWithString:model.con];
//        NSRange rangel = [[textColor string] rangeOfString:[_bookPrice.text substringFromIndex:6]];
        [textColor addAttribute:NSForegroundColorAttributeName value:[UIColor blueColor] range: [self textnstr:model.con]];
        [textColor addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15] range: [self textnstr:model.con]];
        
        [cell.delable setAttributedText:textColor];
        
        
        
    }
return cell;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 90;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 110;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    
       //取消tableview选中被禁色
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    [self jubaotikuang];
 

    
    
}





//组头
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    
    UIView *view =[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 90)];
    view.userInteractionEnabled=YES;
    UILabel *lable=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 60)];
    lable.font =[UIFont systemFontOfSize:15];
    lable.textColor =[UIColor blackColor];
    lable.numberOfLines=0;
    lable.text = _titlestr;
    [view addSubview:lable];
    view.backgroundColor =[UIColor whiteColor];
    
    zanview =[[UIView alloc]initWithFrame:CGRectMake(0, view.frame.size.height-30, 60, 30)];
//    zanview.userInteractionEnabled =YES;
    
     zanview.layer.borderWidth = 2;
          zanview.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    [view addSubview:zanview];
    
    zanimageiiv =[[UIImageView alloc]initWithFrame:CGRectMake(0, 5, 20, 17)];
//    zanimageiiv.userInteractionEnabled=YES;
    
    isdianzan =[[FavoriteManager manager]isExists:_ida];
    zanimageiiv.image =[UIImage imageNamed:isdianzan?@"dianzaned":@"dianzan"];
    if (isdianzan) {
        
        zanview.userInteractionEnabled=NO;
        
    }else{
    
        zanview.userInteractionEnabled=YES;
    
    }
    
    
    [zanview addSubview:zanimageiiv];
    
    zanlable =[[UILabel alloc]initWithFrame:CGRectMake(26, 0, 34, 25)];
    zanlable.textColor =[UIColor lightGrayColor];
    zanlable.userInteractionEnabled=YES;
    zanlable.font =[UIFont systemFontOfSize:15];
    zanlable.text =_zanstr;
    zanshu= (long)[_zanstr integerValue];
    [zanview addSubview:zanlable];
    UITapGestureRecognizer *tap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap)];
    [zanview addGestureRecognizer:tap];
    
    UIButton *sharbtn =[[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width-50,zanview.frame.origin.y, 30, 30)];
    sharbtn.layer.borderWidth = 2;
    issharbtn =[[SharManger manager]isExists:_ida];
    [sharbtn setImage:[UIImage imageNamed:issharbtn?@"wodeshoucang":@"video_favo"] forState:UIControlStateNormal];
    
    sharbtn.layer.borderColor = [[UIColor lightGrayColor] CGColor];
//    [sharbtn setImage:[UIImage imageNamed:@"video_favo"] forState:UIControlStateNormal];
    [sharbtn addTarget:self action:@selector(sharbtn:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:sharbtn];
   
    
    UIView *lasview =[[UIView alloc]initWithFrame:CGRectMake(0, view.frame.size.height-5, self.view.frame.size.width, 5)];
    lasview.backgroundColor =[UIColor lightGrayColor];
    
    

//    
   return view;
    
}//点赞动作事件
-(void)tap{

    zanimageiiv.image =[UIImage imageNamed:@"dianzaned"];
    zanlable.text =[NSString stringWithFormat:@"%ld",(long)zanshu+1];
    zanview.userInteractionEnabled=NO;
    
    AFHTTPSessionManager *manger =[AFHTTPSessionManager manager];
    NSDictionary *dic =@{@"news_id":_ida,@"url_type":@"index"};
      manger.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"text/json",@"text/plain",@"application/json",@"text/html",nil];
    [manger POST:@"http://gaoxiaoshipin.vipappsina.com/index.php/NewApi38/doZan" parameters:dic progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
       
    }];
    
    
    
   [[FavoriteManager manager]addModel:_ida];
    
    
    


}
//收藏按钮
-(void)sharbtn:(UIButton *)btn{


    if (issharbtn) {
        
        Sharmodel *model =[[Sharmodel alloc]init];
        model.strid=_strid;
        model.ida=_ida;
        model.title1=_titlestr;
        model.zan_num=_zanstr;
        model.imagestr=_imagestr;
        [[SharManger manager]deleteModel:model];
        
    }else{
    
        Sharmodel *model =[[Sharmodel alloc]init];
        model.strid=_strid;
        model.ida=_ida;
        model.title1=_titlestr;
        model.zan_num=_zanstr;
        model.imagestr=_imagestr;
        [[SharManger manager]addModel:model];
    
    }
    
    issharbtn=!issharbtn;
    [btn setImage:[UIImage imageNamed:issharbtn?@"wodeshoucang":@"video_favo"] forState:UIControlStateNormal];


}
#pragma mark - 懒加载代码
- (FullViewController *)fullVc
{
    if (_fullVc == nil) {
        _fullVc = [[FullViewController alloc] init];
    }
    return _fullVc;
}







#pragma mark - 视频代理方法

- (void)videoplayViewSwitchOrientation:(BOOL)isFull
{
    if (isFull) {
        [self.navigationController presentViewController:self.fullVc animated:NO completion:^{
            [self.fullVc.view addSubview:self.playView];
            _playView.center = self.fullVc.view.center;
            
            [UIView animateWithDuration:0.2 delay:0.0 options:UIViewAnimationOptionLayoutSubviews animations:^{
                _playView.frame = self.fullVc.view.bounds;
//                self.playView.danmakuView.frame = self.playView.frame;
                
            } completion:nil];
        }];
    } else {
        [self.fullVc dismissViewControllerAnimated:NO completion:^{
            [self.view addSubview:_playView];
            _playView.frame = CGRectMake(0,  22, kScreenWidth, (kScreenWidth-20)/2+30);
        }];
    }
    
}
#pragma 网络请求

-(void)loadata{


    HttpManager *manger =[HttpManager shareManager];
    NSString *str =[NSString stringWithFormat:URL_XINAGQIN,_ida];
    [manger requestWithUrl:str withDictionary:nil withSuccessBlock:^(id responseObject) {
        
        
        NSArray *a =responseObject[@"new"];
        for (NSDictionary *dic in a) {
            
            XQModel *model =[[XQModel alloc]initWithDictionary:dic error:nil];
            
            [_array addObject:model];
            
              }
        [_tableview reloadData];
    } withFailureBlock:^(NSError *error) {
        
    }];

    
    
    
    
    
    
}







//web网络请求
-(void)webload:(NSDictionary *)dic{
    
    
    AFHTTPSessionManager *manger =[AFHTTPSessionManager manager];
    manger.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"text/json",@"text/plain",@"application/json",@"text/html",nil];
    
    [manger POST:URL_WEB_SOUYE parameters:dic progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        //        webstring =responseObject[@"url"];
        //        NSLog(@"webstring%@",responseObject[@"url"]);
        
        [_playView setUrlString:responseObject[@"url"]];
        //        [_playView.player play];
        //        _playView.playOrPauseBtn.selected = YES;
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        
        
    }];
    
    
    
    
}
-(NSRange)textnstr:(NSString *)str{


    NSRange
    startRange = [str rangeOfString:@"//"];
    
    NSRange
    endRange = [str rangeOfString:@":"];
    
    NSRange
    range = NSMakeRange(startRange.location
                        + startRange.length,
                        endRange.location
                        - startRange.location
                        - startRange.length);
//    NSString *a =[str substringWithRange:range];
    
    return range;
}

-(void)jubaotikuang{

    UIAlertController *alercoller =[UIAlertController alertControllerWithTitle:@"提示" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    //分别按顺序放入每个按钮；
    [alercoller addAction:[UIAlertAction actionWithTitle:@"举报该评论" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        //点击按钮的响应事件；
        
     
        _hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        
        _hud.mode = MBProgressHUDModeText;
        _hud.label.text = @"举报成功，我们会尽快作出处理!";
        _hud.label.font = [UIFont systemFontOfSize:15];
        
        _hud.label.textColor = [UIColor whiteColor];
        
        _hud.bezelView.color = [UIColor blackColor];
        
        [_hud hideAnimated:YES afterDelay:2.0];

        
    }]];
    [alercoller addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //点击按钮的响应事件；
//        [self dismissViewControllerAnimated:true completion:nil];
       
    }]];
    //弹出提示框；
    [self presentViewController:alercoller animated:true completion:nil];


}

//-(UIStatusBarStyle)preferredStatusBarStyle
//
//{
//    
//    return 1;  //默认的值是黑色的
//    
//}
- (BOOL)prefersStatusBarHidden

{
    
    return NO; // 是否隐藏状态栏
    
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
