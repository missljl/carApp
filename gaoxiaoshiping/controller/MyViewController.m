//
//  MyViewController.m
//  gaoxiaoshiping
//
//  Created by 1111 on 2017/6/25.
//  Copyright © 2017年 1111. All rights reserved.
//

#import "MyViewController.h"
#import "SDImageCache.h"
#import "MBProgressHUD.h"

#import "SCViewController.h"
#import "SharManger.h"
#import "YijianORXieYiViewController.h"
@interface MyViewController ()
{
    NSArray *ar;
    NSArray *imagar;
    MBProgressHUD *_hud;
}
@end

@implementation MyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title =@"设置";
    [self configUI];
    [self loadData];
    
    
    // Do any additional setup after loading the view.
}
-(void)configUI{

    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH*RATE, SCREEN_HEIGHT-64-49) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    [self.view addSubview:_tableView];

    
    
}
-(void)loadData{

    ar =@[@[@"视频收藏",@"清空缓存"],@[@"给我鼓励",@"意见反馈",@"免责声明"]];

 imagar=@[@[@"wodeshoucang",@"yejianmoshi",@"qingkonghuancun"],@[@"geiwoguli",@"yonghufankui",@"mianzeshengming"]];
    

    
    
    

}



-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{


    return 40;

}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 2;

}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
   
    NSArray *array =ar[section];
    
//    NSArray *ar1=ar[section];
    return array.count;
    
    
}

//-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//
////    if (section==0) {
////        return 150;
////    }else{
////    
////    
////    
////    return 0;
////    }
//    
//    
//    return section?0:150;
//    
//}


//-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//
//
//    UIView *v =[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 150)];
//
//   
//    
//    
//    return v;
//}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static  NSString *cellid =@"cell";
   
    UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellid];
    
    if (cell==nil) {
        
        
        cell =[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellid];
    }
    cell.textLabel.text =ar[indexPath.section][indexPath.row];
    cell.textLabel.font =[UIFont systemFontOfSize:16];
    cell.imageView.image =[UIImage imageNamed:imagar[indexPath.section][indexPath.row]];
    cell.detailTextLabel.font=[UIFont systemFontOfSize:12];
    if ([cell.textLabel.text isEqualToString:@"清空缓存"]) {
        
        
//        cell.accessoryType =UITableViewCellAccessoryNone;
       NSString *path=[NSHomeDirectory() stringByAppendingPathComponent:@"/Library/Caches"];
       CGFloat size=[self folderSizeAtPath:path];
        if (size<=0.02) {
            
            cell.detailTextLabel.text=[NSString stringWithFormat:@"%.2f MB",size];
            cell.detailTextLabel.textColor = [UIColor blackColor];
        }else{
            cell.detailTextLabel.textColor = [UIColor blackColor];
            cell.detailTextLabel.text=[NSString stringWithFormat:@"%.2f MB",size];
        }

        
    }
    
    return cell;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

 [_tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    if (indexPath.section==0&&indexPath.row==1) {
        
        [self jubaotikuang];
        
    }if (indexPath.section==0&&indexPath.row==0) {
        
        NSArray *ar =[[SharManger manager]allModels];
        if (ar.count>0) {
            
            SCViewController *sc =[[SCViewController alloc]init];
             self.navigationController.navigationBar.tintColor = [UIColor blackColor];
            [self.navigationController pushViewController:sc animated:YES];
        }else{
        
            _hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            
            _hud.mode = MBProgressHUDModeText;
            _hud.label.text = @"还木有收藏过视频，赶快去收藏自己喜欢的吧";
            _hud.label.font = [UIFont systemFontOfSize:15];
            
            _hud.label.textColor = [UIColor whiteColor];
            
            _hud.bezelView.color = [UIColor blackColor];
            
            [_hud hideAnimated:YES afterDelay:2.0];
        }

        }if (indexPath.section==1&&indexPath.row==0) {
            
//          [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"itms-apps://itunes.apple.com/- (void)openURL:(NSURL*)url options:(NSDictionary<NSString *, id> *)options completionHandler:(void (^ __nullable)(BOOL success))completion NS_AVAILABLE_IOS(10_0) NS_EXTENSION_UNAVAILABLE_IOS("");cn/app/%E7%AE%80%E9%9F%B3%E6%82%A6/id1246292556?mt=8"]];
            
            NSDictionary *dic=@{@"d":@"d"};
        [[UIApplication sharedApplication]openURL:[NSURL URLWithString:@"itms-apps://itunes.apple.com/cn/app/%E7%AE%80%E9%9F%B3%E6%82%A6/id1246292556?mt=8"] options:dic completionHandler:^(BOOL success) {
            
        }];
        
            
        }if (indexPath.section==1&&indexPath.row==1) {
            
         //   NSLog(@"dddd");
            YijianORXieYiViewController *yivc = [[YijianORXieYiViewController alloc]init];
            yivc.str = @"意见反馈";
            yivc.yijianORxieyi = 0;
            [self presentViewController:yivc animated:YES completion:^{
                
            }];
   
            
            
            
        }if (indexPath.section==1&&indexPath.row==2) {
            
            
            YijianORXieYiViewController *yivc = [[YijianORXieYiViewController alloc]init];
            yivc.str = @"用户协议";
            yivc.yijianORxieyi = 1;
            [self presentViewController:yivc animated:YES completion:^{
                
            }];
 
            
            
        }

    
        
    }


-(void)jubaotikuang{
    
    UIAlertController *alercoller =[UIAlertController alertControllerWithTitle:@"提示" message:@"是否要清除缓存" preferredStyle:UIAlertControllerStyleActionSheet];
    
    //分别按顺序放入每个按钮；
    [alercoller addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        //点击按钮的响应事件；
        
        
            NSString *path=[NSHomeDirectory() stringByAppendingPathComponent:@"/Library/Caches"];
        
        [self clearCache:path];
         [_tableView reloadData];
        
        _hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        
        _hud.mode = MBProgressHUDModeText;
        _hud.label.text = @"清除成功！！";
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




-(float)fileSizeAtPath:(NSString *)path{
    NSFileManager *fileManager=[NSFileManager defaultManager];
    if([fileManager fileExistsAtPath:path]){
        long long size=[fileManager attributesOfItemAtPath:path error:nil].fileSize;
        return size/1024.0/1024.0;
    }
    return 0;
}
-(float)folderSizeAtPath:(NSString *)path{
    NSFileManager *fileManager=[NSFileManager defaultManager];
    float folderSize=0;
    if ([fileManager fileExistsAtPath:path]) {
        NSArray *childerFiles=[fileManager subpathsAtPath:path];
        for (NSString *fileName in childerFiles) {
            NSString *absolutePath=[path stringByAppendingPathComponent:fileName];
            folderSize +=[self fileSizeAtPath:absolutePath];
        }
        //SDWebImageÊ°ÜÊû∂Ëá™Ë∫´ËÆ°ÁÆóÁºìÂ≠òÁöÑÂÆûÁé∞
        folderSize+=[[SDImageCache sharedImageCache] getSize]/1024.0/1024.0;
        return folderSize;
    }
    return 0;
}
-(void)clearCache:(NSString *)path{
    
    NSFileManager *fileManager=[NSFileManager defaultManager];
    
    if ([fileManager fileExistsAtPath:path]) {
        NSArray *childerFiles=[fileManager subpathsAtPath:path];
        
        for (NSString *fileName in childerFiles) {
            //Â¶ÇÊúâÈúÄË¶ÅÔºåÂä†ÂÖ•Êù°‰ª∂ÔºåËøáÊª§Êéâ‰∏çÊÉ≥Âà†Èô§ÁöÑÊñá‰ª∂
            
            NSString *absolutePath=[path stringByAppendingPathComponent:fileName];
            [fileManager removeItemAtPath:absolutePath error:nil];
        }
    }
    [[SDImageCache sharedImageCache]clearDiskOnCompletion:^{
        
    }];
//    [[SDImageCache sharedImageCache] cleanDisk];
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
