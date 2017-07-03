//
//  LJLSeachbar.m
//  9.28爱限免1
//
//  Created by qianfeng on 15-9-29.
//  Copyright (c) 2015年 lijinlong. All rights reserved.
//

#import "LJLSeachbar.h"

@implementation LJLSeachbar
{
    UISearchBar *_searchBar;
    NSString *_placeholder;
    UIView *_bgview;//这个是朦层
    //定义代理,遵从协议
    id<LJLSeachbarDelegate> _delegate;

}

-(id)initWithFrame:(CGRect)frame placeholder:(NSString *)placeholder delegate:(id<LJLSeachbarDelegate>)delegate
{
    self = [super initWithFrame:frame];
    if (self) {
        _placeholder = placeholder;//这个是显示的文字
        [self configView];
        _delegate =delegate;//协议
//        _searchBar.searchResultsButtonSelected = YES;
        
    }
    return self;
}
-(void)configView
{
    _searchBar = [[UISearchBar alloc]initWithFrame:self.bounds];
    
    _searchBar.placeholder = _placeholder;
    //设置收索栏的样式
    _searchBar.delegate = self;//这个是_searchBar的协议
//  _searchBar.layer.borderWidth = 0.8;
//    _searchBar.layer.borderColor = [UIColor greenColor].CGColor;
    _searchBar.layer.masksToBounds = YES;
    _searchBar.barTintColor = [UIColor colorWithRed:0.89 green:0.89 blue:0.89 alpha:1.0];
    
//    [[UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:[UISearchBar class]] setTintColor:[UIColor lightGrayColor]];
    
    
    
     [[UIBarButtonItem appearanceWhenContainedIn:[UISearchBar class], nil]setTintColor:[UIColor blackColor]];
//    [[UIBarButtonItem appearanceWhenContainedIn: [UISearchBar class], nil] setTintColor:[UIColor whiteColor]];
    [[UIBarButtonItem appearanceWhenContainedIn: [UISearchBar class], nil] setTitle:@"取消"];
    
    
    [self addSubview:_searchBar];
}
//
-(void)showInView:(UIView *)view
{
    if (!_bgview) {
     _bgview = [[UIView alloc]initWithFrame:view.bounds];
    }
    _bgview.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.8];
    //给梦曾添加一个手势:hiddenKeyBoard点击梦曾的方法
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hiddenKeyBoard)];
    [_bgview addGestureRecognizer:tap];
    _bgview.hidden = YES;//初始化的时候是隐藏的
    [view addSubview:_bgview];
    [view addSubview:self];

}
//secarchBar将要编辑的时候调用的方法
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    //这个是设置cancel按钮是否显示,第一个表示显示,第二个表示动画
    [_searchBar setShowsCancelButton:YES animated:YES];
    _bgview.hidden = YES;
    return YES;

}
//这个是当点击键盘上searbarbutton的时候调用的方法
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    
    [_delegate searchWithKey:_searchBar.text];
    [self hiddenKeyBoard];
   
}
//这个方法是cancel按钮被点击的时候调用的
-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [self hiddenKeyBoard];
    
}




//结束编辑所做的处理
-(void)hiddenKeyBoard{
    //resignFirstResponder让scearchBar取消第一响应者(就是键盘隐藏)
    [_searchBar resignFirstResponder];
    _searchBar.text = @"";
    [_searchBar setShowsCancelButton:NO animated:YES];
    _bgview.hidden = YES;
    
    
}



@end
