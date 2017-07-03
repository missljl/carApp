//
//  SCViewController.m
//  gaoxiaoshiping
//
//  Created by 1111 on 2017/6/28.
//  Copyright © 2017年 1111. All rights reserved.
//

#import "SCViewController.h"
#import "SharManger.h"

#import "RootTableViewCell.h"


#import "Sharmodel.h"
#import "UIImageView+WebCache.h"
#import "shipingViewController.h"
static NSString *ID = @"cell";
@interface SCViewController ()

@end

@implementation SCViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.title=@"视频收藏";
    [self configUI];
    [self loadData];
    // Do any additional setup after loading the view.
}

-(void)configUI{


    [super configUI];
 [_tableView registerClass:[RootTableViewCell class] forCellReuseIdentifier:ID];

}
-(void)loadData{

    
    _dataArray=[[SharManger manager]allModels];
    
    [_tableView reloadData];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{


    return _dataArray.count;

}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{


    return 200;

}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    
    RootTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID forIndexPath:indexPath]; //根据indexPath准确地取出一行，而不是从cell重用队列中取出
    
    //    RootTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath]; //根据indexPath准确地取出一行，而不是从cell重用队列中取出
    //    if (cell == nil) {
    //        cell = [[RootTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    //    }
    
    Sharmodel *video = _dataArray[indexPath.row];

    cell.title.text = video.title1;
    //    self.descriptionLabel.text = video.title1;
    [cell.backImage sd_setImageWithURL:[NSURL URLWithString:video.imagestr] placeholderImage:[UIImage imageNamed:@"logo"]];
    //    [self.backImage ]
    cell.playCountLabel.text = [NSString stringWithFormat:@"%@次",video.zan_num];
//    cell.timeLabel.text = video.cTime;
//    [cell.playButton setBackgroundImage:[UIImage imageNamed:@"play"] forState:UIControlStateNormal];
    cell.playCountImage.image = [UIImage imageNamed:@"dianzanda"];
    //    self.playCountImage.backgroundColor =[UIColor redColor];
//    cell.timeImage.image = [UIImage imageNamed:@"time"];



    return cell;

}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{


    shipingViewController *videoController = [[shipingViewController alloc]init];
    
    Sharmodel *model =_dataArray[indexPath.row];
    videoController.strid=model.strid;
    videoController.zanstr=model.zan_num;
    videoController.titlestr =model.title1;
    videoController.ida =model.ida;
    videoController.imagestr=model.imagestr;
    //    videoController.video = self.videoArray[indexPath.row];
    [self.navigationController pushViewController:videoController animated:YES];
    self.navigationController.navigationBarHidden = YES;



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
