//
//  SeachViewController.m
//  gaoxiaoshiping
//
//  Created by 1111 on 2017/6/28.
//  Copyright © 2017年 1111. All rights reserved.
//


#define URL_SEACH @"http://gaoxiaoshipin.vipappsina.com/index.php/NewApi38/index/search/%@/sw/1"

#import "SeachViewController.h"
#import "HttpManager.h"
#import "UIImageView+WebCache.h"


#import "SYModel.h"
#import "RootTableViewCell.h"
#import "shipingViewController.h"
static NSString *ID = @"cell";
@interface SeachViewController ()

@end

@implementation SeachViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self configUI];
    [self loadData];
    // Do any additional setup after loading the view.
}

-(void)configUI{

    [super configUI];
 [_tableView registerClass:[RootTableViewCell class] forCellReuseIdentifier:ID];
}
-(void)loadData{

    HttpManager *manger =[HttpManager shareManager];
    
    
    NSString *str =[NSString stringWithFormat:URL_SEACH,_seachtring];
    
    [manger requestWithUrl:str withDictionary:nil withSuccessBlock:^(id responseObject) {
        
        NSArray *ar = responseObject[@"rows"];
        
        for (NSDictionary *dic in ar) {
            
            SYModel *model =[[SYModel alloc]initWithDictionary:dic error:nil];
            [_dataArray addObject:model];
            
            
        }
        [_tableView reloadData];
        
        
    } withFailureBlock:^(NSError *error) {
        
    }];




}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 280;
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
//    [cell.playButton setBackgroundImage:[UIImage imageNamed:@"play"] forState:UIControlStateNormal];
    cell.playCountImage.image = [UIImage imageNamed:@"dianzanda"];
    //    self.playCountImage.backgroundColor =[UIColor redColor];
    cell.timeImage.image = [UIImage imageNamed:@"time"];
//    
//    [cell.playButton addTarget:self action:@selector(playButtonAction:) forControlEvents:UIControlEventTouchUpInside];
//    cell.playButton.tag = 100 + indexPath.row;
    
    UIView *v =[[UIView alloc]initWithFrame:CGRectMake(0, cell.frame.size.height-8, cell.frame.size.width, 8)];
    v.backgroundColor =[UIColor lightGrayColor];
    v.alpha=0.3;
    [cell.contentView  addSubview:v];
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    [_fmVideoPlayer.player pause];
//    _fmVideoPlayer.hidden = YES;
    
    
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
