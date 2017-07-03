//
//  ViewController.m
//  gaoxiaoshiping
//
//  Created by 1111 on 2017/6/25.
//  Copyright © 2017年 1111. All rights reserved.
//


#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
//屏幕的高
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
//宽的比例
#define RATE SCREEN_WIDTH/320.0


#import "ViewController.h"
#import "RootViewController.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
   
    [self createViewController];
    
    [self customTabBar];
    
    [self lastSelected];
    
    
    
    
    // Do any additional setup after loading the view.
}
-(void)createViewController
{
    NSArray *vcName = @[@"SouYeViewController",@"QuTuViewController",@"ZhuanJiViewController",@"MyViewController",];
    NSArray *titleNarray = @[@"首页",@"动图",@"专辑",@"个人"];
    NSMutableArray *viewControllers = [[NSMutableArray alloc] init];
    for (NSInteger i=0; i<vcName.count; i++) {
        Class class = NSClassFromString(vcName[i]);
        if (class) {
            RootViewController *vc =[[class alloc]init];
            UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:vc];
//            [nav.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"bc_topBg@2x"] forBarMetrics: UIBarMetricsDefaultPrompt ];
            [viewControllers addObject:nav];
//            vc.title = titleNarray[i];
            //修改导航栏字体颜色
            [nav.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor orangeColor], NSForegroundColorAttributeName, [UIFont systemFontOfSize:20], NSFontAttributeName, nil]];
        }
    }
    //写copy的原因:避免tab.viewControllers指向的数组是可变的,提高安全性,和稳定性
    self.viewControllers =viewControllers;
    
}
-(void)customTabBar
{
    self.tabBar.hidden = YES;//影藏标签栏
    _iamgeview = [[UIImageView alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height-49, self.view.frame.size.width, 49)];
    // _iamgeview.image = [UIImage imageNamed:@"25_2.jpg"];
    _iamgeview.alpha = 0.7;
    _iamgeview.userInteractionEnabled = YES;
    [self.view addSubview:_iamgeview];
    _iamgeview.backgroundColor = [UIColor whiteColor];
    
}
-(void)lastSelected
{
    NSArray *titileArray = @[@"首页",@"动图",@"专辑",@"个人"];
    
    NSArray *imageArray = @[@"home",@"dongtu",@"zhuanji",@"geren"];
    
    NSArray *imageselectedArray =@[@"home_sel",@"dongtushoucang",@"zhuanji_sel",@"geren_sel"];
    
    for (NSInteger i=0; i<titileArray.count; i++) {
        
            UIButton *btnitem = [[UIButton alloc]initWithFrame:CGRectMake((10+75*i)*RATE, 11, 65*RATE, 49)];
        [_iamgeview addSubview:btnitem];
        
        [btnitem addTarget:self action:@selector(btnCilck:) forControlEvents:UIControlEventTouchUpInside];
        btnitem.tag=100+i;
        [btnitem setTitle:titileArray[i] forState:UIControlStateNormal];
        [btnitem setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [btnitem setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
        btnitem.titleLabel.font = [UIFont systemFontOfSize:10];
        //第一个是上
        btnitem.titleEdgeInsets = UIEdgeInsetsMake(15, -18, 0, 0);
        btnitem.imageEdgeInsets = UIEdgeInsetsMake(-25,0 ,0 ,-24*RATE);
        [btnitem setImage:[UIImage imageNamed:imageArray[i]] forState:UIControlStateNormal];
        [btnitem setImage:[UIImage imageNamed:imageselectedArray[i]] forState:UIControlStateSelected];
//        if (i==1||i==3) {
//            NSLog(@"111");
//            btnitem.titleEdgeInsets = UIEdgeInsetsMake(15, -5, 0, 0);
////            btnitem.frame=CGRectMake((5+63*i)*RATE, 11, 66*RATE, 74-11);
//            
//        }
        btnitem.adjustsImageWhenHighlighted = YES;
        _iamgeview.userInteractionEnabled = YES;
        if (i==0) {
            btnitem.selected = YES;
            
            btnitem.userInteractionEnabled = NO;
        }
    }
    
}
-(void)btnCilck:(UIButton *)btnitem
{
    NSInteger index = btnitem.tag-100;
    self.selectedIndex = index;
    for (UIButton *btnitem in _iamgeview.subviews) {
        btnitem.selected = NO;
        btnitem.userInteractionEnabled = YES;
    }
    btnitem.selected = YES;
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
