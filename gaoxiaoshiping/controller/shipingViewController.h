//
//  shipingViewController.h
//  gaoxiaoshiping
//
//  Created by 1111 on 2017/6/26.
//  Copyright © 2017年 1111. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FMGVideoPlayView.h"

#import "FullViewController.h"


@interface shipingViewController : UIViewController



@property(nonatomic,copy)NSString *strid;
@property (nonatomic, strong) FMGVideoPlayView *playView;
@property (nonatomic, assign) NSInteger index;
@property (nonatomic, strong) UIButton * fanhuiButton;
@property (nonatomic, strong) UIButton * hiddenButton;


@property(nonatomic,copy)NSString *titlestr;
@property(nonatomic,copy)NSString *zanstr;
@property(nonatomic,copy)NSString *ida;


@property(nonatomic,copy)NSString *imagestr;


@end
