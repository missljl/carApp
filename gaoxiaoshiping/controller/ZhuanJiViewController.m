//
//  ZhuanJiViewController.m
//  gaoxiaoshiping
//
//  Created by 1111 on 2017/6/25.
//  Copyright © 2017年 1111. All rights reserved.
//

#import "ZhuanJiViewController.h"
#import "zhuanjimodel.h"
#import "ZJCell.h"
#import "UIImageView+WebCache.h"
#import "ZJTWOCell.h"

#import "ZhjiTwoViewController.h"


static NSString *ID = @"zhuanjicell";
static NSString *idtwo=@"twocell";
@interface ZhuanJiViewController ()

@end

@implementation ZhuanJiViewController
{

    NSString *idas;

}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self configUI];
    [self loadData:@"0"];
}
-(void)configUI{

   
    [super configUI];
  [_tableView registerNib:[UINib nibWithNibName:@"ZJCell" bundle:nil] forCellReuseIdentifier:ID];
      [_tableView registerNib:[UINib nibWithNibName:@"ZJTWOCell" bundle:nil] forCellReuseIdentifier:idtwo];
    [self addRefreshHeader:NO andHaveFooter:YES];
    self.title=@"专辑";

}
-(void)loadData:(NSString*)str{
//    http://gaoxiaoshipin.vipappsina.com/index.php/NewZhuan38/index/lastId/0/sw/1
//http://gaoxiaoshipin.vipappsina.com/index.php/NewZhuan38/index/lastId/0/sw/1
//    http://gaoxiaoshipin.vipappsina.com/index.php/NewZhuan38/index/lastId/58/sw/1
    NSString *s =[NSString stringWithFormat:@"http://gaoxiaoshipin.vipappsina.com/index.php/NewZhuan38/index/lastId/%@/sw/1",str];
    HttpManager *manger =[HttpManager shareManager];
    [manger requestWithUrl:s withDictionary:nil withSuccessBlock:^(id responseObject) {
        
        
         [_tableView.mj_footer endRefreshing];
        
        NSArray *a =responseObject;
        for (NSArray*subar in a) {
            
            for (NSDictionary *dic in subar) {
                
                zhuanjimodel *model =[[zhuanjimodel alloc]initWithDictionary:dic error:nil];
                
                [_dataArray addObject:model];
                
            }
                 }
        
        [_tableView reloadData];
    } withFailureBlock:^(NSError *error) {
     [_tableView.mj_footer endRefreshing];    
        
    }];
    


}
-(void)loadMore{
    
    
 [_tableView.mj_footer endRefreshing];
    zhuanjimodel *model =_dataArray.lastObject;
    NSString *lastr =model.ida;
    [self loadData:lastr];

}



-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{


    if (indexPath.row==0) {
        
        
        return 0;
    }else{
    
    
        return 150;
    }

}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    if (indexPath.row%2==0) {
        
      
        
        
        ZJCell *cell = [tableView dequeueReusableCellWithIdentifier:ID forIndexPath:indexPath]; //根据indexPath准确地取出一行，而不是从cell重用队列中取出
        
        zhuanjimodel *model= _dataArray[indexPath.row];
        [cell.zhanjiiamgeview sd_setImageWithURL:[NSURL URLWithString:model.pic]];
        
        cell.zhanjilable.text = model.title1;
        cell.zhanjiiamgeview.frame =CGRectMake(0, 0, self.view.frame.size.width/2, 150);
        cell.zhanjilable.frame =CGRectMake(self.view.frame.size.width/2, 0, self.view.frame.size.width/2, 150);
        
        if (indexPath.row==0) {
            
            cell.hidden =YES;
            
        }else{
        
            cell.hidden=NO;
        }
        
        
        //    cell.timelable.text =model.cTime;
        //    cell.zhanjilable.textColor =[UIColor lightGrayColor];
   
        return cell;
        
    }else{
        ZJTWOCell *cell = [tableView dequeueReusableCellWithIdentifier:idtwo forIndexPath:indexPath]; //根据indexPath准确地取出一行，而不是从cell重用队列中取出
        zhuanjimodel *model= _dataArray[indexPath.row];
        [cell.twoimageview sd_setImageWithURL:[NSURL URLWithString:model.pic]];
        
        cell.twolable.text = model.title1;
        
        cell.twolable.frame =CGRectMake(0, 0, self.view.frame.size.width/2, 150);
        cell.twoimageview.frame =CGRectMake(self.view.frame.size.width/2, 0, self.view.frame.size.width/2, 150);

        //    cell.timelable.text =model.cTime;
        //    cell.zhanjilable.textColor =[UIColor lightGrayColor];
    return cell;
    
    }
    
    
    
    
    return nil;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    //取消tableview选中被禁色
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    ZhjiTwoViewController *twovc =[[ZhjiTwoViewController alloc]init];
    zhuanjimodel *model =_dataArray[indexPath.row];
    twovc.title=model.title1;
    twovc.sidatring=model.ida;
     self.navigationController.navigationBar.tintColor = [UIColor blackColor];
        [self.navigationController pushViewController:twovc animated:YES];
    

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
