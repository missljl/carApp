//
//  TUxiangViewController.m
//  gaoxiaoshiping
//
//  Created by 1111 on 2017/6/27.
//  Copyright © 2017年 1111. All rights reserved.
//

#import "TUxiangViewController.h"
#import "UIImageView+WebCache.h"
#import "qutumodel.h"
#import "FLAnimatedImage.h"

#import "AnimatedGif.h"
#import "MBProgressHUD.h"
@interface TUxiangViewController ()
@property(nonatomic,strong)UILabel  *titlelabel;
@property(nonatomic,strong) FLAnimatedImageView *imageview;
@property(nonatomic,strong)MBProgressHUD *hud;
@end

@implementation TUxiangViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    
    NSString *s =[NSString stringWithFormat:@"%ld/%ld",_picindex+1,_tuzongshu+1];
    self.title=s;
    
    [self configUI];
}
-(void)configUI{

qutumodel *model =_imagear[_picindex];
    
  
    _titlelabel =[[UILabel alloc]initWithFrame:CGRectMake(0, 96,self.view.frame.size.width-10 , 30)];
    _titlelabel.textColor =[UIColor blackColor];
    _titlelabel.text =model.title1;
    _titlelabel.font =[UIFont systemFontOfSize:17];
    _titlelabel.backgroundColor =[UIColor whiteColor];
    [self.view addSubview:_titlelabel];
   
//    CGFloat withd =[model.pic_w floatValue];
    CGFloat htir =[model.pic_h floatValue];
//    NSLog(@"%@,%@",model.pic_h,model.pic_w);
    _imageview =[[FLAnimatedImageView alloc]init];

    
   
    FLAnimatedImage *image =[FLAnimatedImage animatedImageWithGIFData:[NSData dataWithContentsOfURL:[NSURL URLWithString:model.mp4_url]]];
    _imageview.frame =CGRectMake(20,_titlelabel.frame.size.height+100,self.view.frame.size.width-40,htir);
//    FLAnimatedImageView *anview =[[FLAnimatedImageView alloc]init];
     _imageview.animatedImage =image;
    

  _imageview.userInteractionEnabled =YES;
    
  _imageview.tag=300;
    
    [self.view addSubview:_imageview];
    
    
//        这个是清扫手势,一个手势只能监听一个方向
    UISwipeGestureRecognizer *left =[[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeGeture:)];
    //设置手势监听的方向lift左,right右,up上,down下
    left.direction = UISwipeGestureRecognizerDirectionLeft;
    //设置手势血药的手指数
    left.numberOfTouchesRequired =1;
    [_imageview addGestureRecognizer:left];
    
    //左手势
    UISwipeGestureRecognizer *right = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeGeture:)];
    right.direction = UISwipeGestureRecognizerDirectionRight;
    [_imageview addGestureRecognizer:right];
    
//
    
    
    
    
}
-(void)swipeGeture:(UISwipeGestureRecognizer *)swipe
{
    if (swipe.direction==UISwipeGestureRecognizerDirectionUp) {
        //        _imageView.alpha =0.1;
        [UIView animateWithDuration:0.5 animations:^{
            
        }];
        
    }else if (swipe.direction==UISwipeGestureRecognizerDirectionDown){
        
        
        
        
        
    }else if (swipe.direction ==UISwipeGestureRecognizerDirectionLeft){
        
        if (_picindex==14) {
            
            //NSLog(@"加载更多");
            
            
            
            
        }else{
            
            
            _picindex++;
            
            for (UIImageView *subviews in [self.view subviews]) {
                if (subviews.tag==300) {
                    [subviews removeFromSuperview];
                }
            }
            _imageview =[[FLAnimatedImageView alloc]init];
            qutumodel *model =_imagear[_picindex];
            _titlelabel.text =model.title1;
//            CGFloat withd =[model.pic_w floatValue];
            CGFloat htir =[model.pic_h floatValue];
            NSURL *url =[NSURL URLWithString:model.mp4_url];
        
             FLAnimatedImage *image =[FLAnimatedImage animatedImageWithGIFData:[NSData dataWithContentsOfURL:url]];
            _imageview.animatedImage=image;
            NSString *s =[NSString stringWithFormat:@"%ld/%ld",_picindex+1,_tuzongshu+1];
            self.title=s;
            _imageview.frame =CGRectMake(20,_titlelabel.frame.size.height+100,self.view.frame.size.width-40, htir);
            _imageview.userInteractionEnabled =YES;
            
            _imageview.tag=300;
            //    这个是清扫手势,一个手势只能监听一个方向
            UISwipeGestureRecognizer *left =[[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeGeture:)];
            //设置手势监听的方向lift左,right右,up上,down下
            left.direction = UISwipeGestureRecognizerDirectionLeft;
            //设置手势血药的手指数
            left.numberOfTouchesRequired =1;
            [_imageview addGestureRecognizer:left];
            
            //左手势
            UISwipeGestureRecognizer *right = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeGeture:)];
            right.direction = UISwipeGestureRecognizerDirectionRight;
            [_imageview addGestureRecognizer:right];
            
            [self.view addSubview:_imageview];
        }

        
//        [self lastBtClick];
        
    }else if (swipe.direction==UISwipeGestureRecognizerDirectionRight){
        
        if (_picindex==0) {
            
            _hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            
            _hud.mode = MBProgressHUDModeText;
            _hud.label.text = @"亲，已经是第一页了";
            _hud.label.font = [UIFont systemFontOfSize:15];
            
            _hud.label.textColor = [UIColor whiteColor];
            
            _hud.bezelView.color = [UIColor blackColor];
            
            [_hud hideAnimated:YES afterDelay:2.0];
            
            
        }else{
            
            _picindex--;
            
            for (UIImageView *subviews in [self.view subviews]) {
                if (subviews.tag==300) {
                    [subviews removeFromSuperview];
                }
            }_imageview =[[FLAnimatedImageView alloc]init];
//        _imageview =[[UIImageView alloc]init];
          qutumodel *model =_imagear[_picindex];
          _titlelabel.text =model.title1;
//           CGFloat withd =[model.pic_w floatValue];
            CGFloat htir =[model.pic_h floatValue];
           NSURL *url =[NSURL URLWithString:model.mp4_url];
             FLAnimatedImage *image =[FLAnimatedImage animatedImageWithGIFData:[NSData dataWithContentsOfURL:url]];
            _imageview.animatedImage=image;
            
          NSString *s =[NSString stringWithFormat:@"%ld/%ld",_picindex+1,_tuzongshu+1];
           self.title=s;
            _imageview.frame =CGRectMake(20,_titlelabel.frame.size.height+100,self.view.frame.size.width-40, htir);
            _imageview.userInteractionEnabled =YES;
            
            _imageview.tag=300;
            //    这个是清扫手势,一个手势只能监听一个方向
            UISwipeGestureRecognizer *left =[[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeGeture:)];
            //设置手势监听的方向lift左,right右,up上,down下
            left.direction = UISwipeGestureRecognizerDirectionLeft;
            //设置手势血药的手指数
            left.numberOfTouchesRequired =1;
            [_imageview addGestureRecognizer:left];
            
            //左手势
            UISwipeGestureRecognizer *right = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeGeture:)];
            right.direction = UISwipeGestureRecognizerDirectionRight;
            [_imageview addGestureRecognizer:right];

            [self.view addSubview:_imageview];
        }

    
        
//        NSLog(@"优化是上一页");
//        [self nextBtClick];
        
        
        
    }
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
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
