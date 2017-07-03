//
//  YijianORXieYiViewController.m
//  Music
//
//  Created by ljl on 17/4/13.
//  Copyright © 2017年 李金龙. All rights reserved.
//

#import "YijianORXieYiViewController.h"
#import "MBProgressHUD.h"
@interface YijianORXieYiViewController ()<UITextFieldDelegate,MBProgressHUDDelegate>
@property(nonatomic,strong)UIButton *leftbtn;
@property(nonatomic,strong)UIButton *rightBtn;
@property(nonatomic,strong)UITextField *Fieldtext;

@property(nonatomic,strong)UITextView *textview;

@end

@implementation YijianORXieYiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    
    [self NavItems];
    
    
    if (_yijianORxieyi==0) {
        
    
    
    
        [self yijianUI];
    
    }else{
    
        [self yonghuxieyiUI];
    
    }
    
}
-(void)NavItems{
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 10, self.view.frame.size.width, 49)];
    view.userInteractionEnabled = YES;
    view.backgroundColor = [UIColor colorWithRed:0.17 green:0.49 blue:1.0 alpha:1.0];
    [self.view addSubview:view];
    
    UILabel *lable = [[UILabel alloc]initWithFrame:CGRectMake(60, 0,self.view.frame.size.width-120, 49)];
    lable.text =_str;
    lable.textAlignment = NSTextAlignmentCenter;
    lable.textColor = [UIColor whiteColor];
    lable.font = [UIFont systemFontOfSize:19];
    [view addSubview:lable];
    
    
    
    _leftbtn = [[UIButton alloc]initWithFrame:CGRectMake(10, 10, 50, 49)];
    [_leftbtn setImage:[UIImage imageNamed:@"SettingBack@2x"] forState:UIControlStateNormal];
    [_leftbtn addTarget:self action:@selector(leftClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_leftbtn];
    
    
    if (_yijianORxieyi==0) {
        
    
    _rightBtn = [[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width-60, 0,50 , 49)];
    [_rightBtn setTitle:@"发送" forState:UIControlStateNormal];
    [_rightBtn addTarget:self action:@selector(rightCilck1) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:_rightBtn];
    }else{
    
        _rightBtn.hidden = YES;
    
    }
}
-(void)yijianUI{

    _Fieldtext = [[UITextField alloc]initWithFrame:CGRectMake(0, _leftbtn.frame.size.height+5, self.view.frame.size.width, self.view.frame.size.height/2)];
    
    _Fieldtext.borderStyle = UITextBorderStyleRoundedRect;
    
    
    _Fieldtext.placeholder = @"在这里输入你要说的话";
    _Fieldtext.textColor = [UIColor lightGrayColor];
    _Fieldtext.textAlignment = NSTextAlignmentLeft;
    
    _Fieldtext.contentVerticalAlignment = UIControlContentVerticalAlignmentTop;
    _Fieldtext.font = [UIFont systemFontOfSize:15];
    
    _Fieldtext.delegate = self;
    _Fieldtext.clearsOnBeginEditing = YES;
    
    _Fieldtext.keyboardType = UIKeyboardAppearanceDefault;
    
    _Fieldtext.returnKeyType = UIReturnKeySend;
    [self.view addSubview:_Fieldtext];
  
    [_Fieldtext becomeFirstResponder];
    
}
//-(void)showtextFiledContents{
//   
//}
-(void)rightCilck1{

    if (_Fieldtext.text.length<=0) {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        
        hud.mode = MBProgressHUDModeText;
        hud.label.text = @"内容不能为空！！";
        
        hud.label.textColor = [UIColor blueColor];
      
      
        hud.bezelView.color = [UIColor whiteColor];
        
       
        
        [hud hideAnimated:YES afterDelay:2];

        
        
    }else{
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        
        hud.mode = MBProgressHUDModeText;
        hud.label.text = @"已发送成功！！";
        
        hud.label.textColor = [UIColor blueColor];
       
        hud.bezelView.color = [UIColor whiteColor];
        hud.delegate = self;
        
              [hud hideAnimated:YES afterDelay:1];
    
    [_Fieldtext  resignFirstResponder];
    
    }
  

}
-(void)hudWasHidden:(MBProgressHUD *)hud{

    [hud removeFromSuperview];


    
        [self dismissViewControllerAnimated:YES completion:^{
    
        }];

}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{

//   [_Fieldtext  resignFirstResponder];
//    [self dismissViewControllerAnimated:YES completion:^{
//        
//    }];
//    NSLog(@"提示用户啊");
    return YES;


}

-(void)yonghuxieyiUI{


    _textview = [[UITextView alloc]initWithFrame:CGRectMake(0, 49, self.view.frame.size.width, self.view.frame.size.height-49)];
    [self.view addSubview:_textview];
    
    

    
    NSString *ss = @"欢迎并感谢你使用此应用服务！\n在使用搞笑视频前，请您务必仔细阅读并透彻理解本声明。您可以选择不使用搞笑视频，但如果您使用搞笑视频，您的使用行为将被视为对本声明全部内容的认可。搞笑视频中的视频内容均为搞笑视频以非人工检索方式、根据您键入或选择的关键字自动生成到第三方网页的链接，除搞笑视频注明之服务条款外，其他一切因使用搞笑视频而可能遭致的意外、疏忽、侵权及其造成的损失（包括因下载被搜索链接到的第三方网站内容而感染电脑病毒），搞笑视频对其概不负责，亦不承担任何法律责任。任何通过使用搞笑视频而搜索链接到的第三方网页均系他人制作或提供，您可能从该第三方网页上获得视频及享用服务，搞笑视频对其合法性概不负责，亦不承担任何法律责任。搞笑视频搜索结果根据您键入或选择的关键字自动搜索获得并生成，不代表搞笑视频赞成被搜索链接到的第三方网页上的内容或立场。您应该对使用搜索引擎的结果自行承担风险。搞笑视频不做任何形式的保证：不保证搜索结果满足您的要求，不保证搜索服务不中断，不保证搜索结果的安全性、正确性、及时性、合法性。因网络状况、通讯线路、第三方网站等任何原因而导致您不能正常使用搞笑视频，搞笑视频不承担任何法律责任。搞笑视频尊重并保护所有使用搞笑视频用户的个人隐私权，您注册的用户名、电子邮件地址等个人资料，非经您亲自许可或根据相关法律、法规的强制性规定，搞笑视频不会主动地泄露给第三方。搞笑视频提醒您：您在使用搜索引擎时输入的关键字将不被认为是您的个人隐私资料。任何网站如果不想被搞笑视频收录（即不被搜索到），应该及时向搞笑视频反映，或者在其网站页面中根据拒绝蜘蛛协议（Robots Exclusion Protocol）加注拒绝收录的标记，否则，搞笑视频将依照惯例视其为可收录网站。任何单位或个人认为通过搞笑视频搜索链接到的第三方网页内容可能涉嫌侵犯其信息网络传播权，应该及时向搞笑视频提出书面权利通知，并提供身份证明、权属证明及详细侵权情况证明。搞笑视频在收到上述法律文件后，将会依法尽快断开相关链接内容。";

 _textview.editable = NO;
    NSMutableParagraphStyle *paragestryle = [[NSMutableParagraphStyle alloc]init];
    paragestryle.lineHeightMultiple = 20.f;
    paragestryle.maximumLineHeight = 20.f;
    paragestryle.minimumLineHeight = 20.f;
    
    
    // 设置段落
    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 10;
    
    
    
    NSDictionary *attributes = @{ NSParagraphStyleAttributeName:paragraphStyle,NSKernAttributeName:@1.7f};
    
       NSMutableAttributedString *attri1 = [[NSMutableAttributedString alloc] initWithString:ss attributes:attributes];
    
    
    [attri1 addAttribute:NSFontAttributeName
     
                   value:[UIFont systemFontOfSize:15.0]
     
                   range:NSMakeRange(0, attri1.length)];
    
    [attri1 addAttribute:NSForegroundColorAttributeName
     
                   value:[UIColor lightGrayColor]
                   range:NSMakeRange(0, attri1.length)];

    
    _textview.attributedText = attri1;
    
    _textview.textAlignment = NSTextAlignmentCenter;
    
    
    
    
    
}




-(void)leftClick{
    
    
    [_Fieldtext  resignFirstResponder];
    
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
    
    
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
