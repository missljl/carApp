//
//  juhuaView.m
//  gaoxiaoshiping
//
//  Created by 1111 on 2017/6/26.
//  Copyright © 2017年 1111. All rights reserved.
//
#define kDegreesToRadian(x) (M_PI * (x) / 180.0)

#define kRadianToDegrees(radian) (radian*180.0)/(M_PI)



#import "juhuaView.h"

@implementation juhuaView
{

    UIImageView *imagev;
    
        CGFloat angle;
//    UIImageView *imagev;
//    }

}

-(id)initWithFrame:(CGRect)frame{

    if (self=[super initWithFrame:frame]) {
        self.backgroundColor =[UIColor blackColor];
        [self cfingui];
    }
    return self;

}
-(id)initWithCoder:(NSCoder *)aDecoder
{
    
    if (self=[super initWithCoder:aDecoder]) {
        self.backgroundColor =[UIColor blackColor];
//        self.userInteractionEnabled = YES;
        [self cfingui];
    }
    return self;
}
-(void)cfingui{

    imagev =[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 50,50)];
    
     imagev.center =CGPointMake(CGRectGetWidth(self.frame)/2,CGRectGetHeight(self.frame)/2);
    
    imagev.image =[UIImage imageNamed:@"find_loading"];
    
  [imagev.layer addAnimation:[self rotation:0.5 degree:kRadianToDegrees(-90) direction:1 repeatCount:MAXFLOAT] forKey:nil];
[self addSubview:imagev];
    
    
}
-(CABasicAnimation *)rotation:(float)dur degree:(float)degree direction:(int)direction repeatCount:(int)repeatCount
{
    
    
  //  NSLog(@"zoulmei");
    CATransform3D rotationTransform = CATransform3DMakeRotation(degree, 0, 0, direction);
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform"];
    animation.toValue = [NSValue valueWithCATransform3D:rotationTransform];
    animation.duration  =  dur;
    //    animation.autoreverses = NO;
    animation.cumulative = YES;
    //    animation.repeatCount=10000;
    //    animation.fillMode = kCAFillModeForwards;
    animation.repeatCount = repeatCount;
//     animation.delegate = self;
    
    return animation;
    
}
//-(CABasicAnimation *)rotation:(float)dur degree:(float)degree direction:(int)direction repeatCount:(int)repeatCount
//{
//    CATransform3D rotationTransform = CATransform3DMakeRotation(degree, 0, 0, direction);
//    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform"];
//    animation.toValue = [NSValue valueWithCATransform3D:rotationTransform];
//    animation.duration  =  dur;
//    //    animation.autoreverses = NO;
//    animation.cumulative = YES;
//    //    animation.repeatCount=10000;
//    //    animation.fillMode = kCAFillModeForwards;
//    animation.repeatCount = repeatCount;
//    //  ／  animation.delegate = self;
//    
//    return animation;
//    
//}


-(void)isstop:(BOOL)isstop{
    if (isstop) {
        
         [self.layer removeAllAnimations];
        
    }


}


//-(void)stopRotate {
//    [self.layer removeAllAnimations];
//}
@end
