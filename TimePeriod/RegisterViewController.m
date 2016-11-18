//
//  RegisterViewController.m
//  TimePeriod
//
//  Created by dhc1256436519 on 16/4/17.
//  Copyright © 2016年 dhc1256436519. All rights reserved.
//
#import "UIView+Toast.h"
#import "RegisterViewController.h"
#import "Masonry.h"
#import "GlobalConstant.h"
#import "AFNetworking.h"
#import "MainViewController.h"
#import "DetailViewController.h"
#import <CommonCrypto/CommonDigest.h>
#import "MD5.h"

#import "UIColor+CreateMethod.h"
@interface RegisterViewController ()
{
    UIView *containerV;
    UILabel *nameLabel;
    UILabel *phoneLabel;
    UILabel *passwordLabel;
    UIImageView *nameLine;
    UIImageView *phoneLine;
    UIImageView *passwordLine;
    UITextField *textPhone;
    UITextField *textPassword;
    UITextField *textUserName;
    UIButton *registeBtn;
    UIButton *backBtn;
}
@end
@implementation RegisterViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:YES];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    containerV = [UIView new];
    nameLabel = [UILabel new];
    phoneLabel = [UILabel new];
    passwordLabel = [UILabel new];
    textUserName=[UITextField new];
    textPhone=[UITextField new];
    textPassword=[UITextField new];
    textPassword.secureTextEntry = YES;
    registeBtn=[UIButton new];
    backBtn = [UIButton new];
    nameLine = [UIImageView new];
    phoneLine = [UIImageView new];
    passwordLine = [UIImageView new];
    [self.view addSubview:containerV];
    [containerV addSubview:nameLabel];
    [containerV addSubview:phoneLabel];
    [containerV addSubview:passwordLabel];
    [containerV addSubview:textUserName];
    [containerV addSubview:textPhone];
    [containerV addSubview:textPassword];
    [containerV addSubview:registeBtn];
    [containerV addSubview:nameLine];
    [containerV addSubview:phoneLine];
    [containerV addSubview:passwordLine];
    [self.view addSubview:backBtn];
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapped:)];
    tap1.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tap1];
    [registeBtn setTitle:@"注册" forState:UIControlStateNormal];
    [registeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    registeBtn.titleLabel.font = [UIFont systemFontOfSize:14];
 //   [btnRegister setFont:[UIFont systemFontOfSize:14]];
  //  containerV.backgroundColor = [UIColor redColor];
    [containerV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).with.offset(232);
        make.centerX.mas_equalTo(self.view);
        make.width.mas_equalTo(250);
        make.height.mas_equalTo(232);
    }];
    nameLabel.textColor = [UIColor colorWithHex:@"#864602" alpha:1.0];
    nameLabel.text = @"昵称:";
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(containerV.mas_top);
        make.left.equalTo(containerV.mas_left).with.offset(0);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(20);
    }];
    [textUserName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(containerV.mas_top);
        make.left.equalTo(nameLabel.mas_right).with.offset(0);
        make.width.mas_equalTo(190);
        make.height.mas_equalTo(20);
    }];
    nameLine.backgroundColor =[UIColor colorWithHex:@"#864602" alpha:1.0];
    [nameLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(textUserName.mas_bottom).with.offset(16);
        make.left.mas_equalTo(containerV.mas_left);
        make.width.mas_equalTo(250);
        make.height.mas_equalTo(1);
    }];
    phoneLabel.textColor = [UIColor colorWithHex:@"#864602" alpha:1.0];
    phoneLabel.text = @"手机号:";
    [phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(nameLine.mas_bottom).with.offset(29);
        make.left.equalTo(containerV.mas_left).with.offset(0);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(20);
    }];
    [textPhone mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(phoneLabel.mas_top);
        make.left.equalTo(phoneLabel.mas_right).with.offset(0);
        make.width.mas_equalTo(190);
        make.height.mas_equalTo(20);
    
    }];
    phoneLine.backgroundColor =[UIColor colorWithHex:@"#864602" alpha:1.0];
    [phoneLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(textPhone.mas_bottom).with.offset(16);
        make.left.mas_equalTo(containerV.mas_left);
        make.width.mas_equalTo(250);
        make.height.mas_equalTo(1);
    }];
    passwordLabel.textColor = [UIColor colorWithHex:@"#864602" alpha:1.0];
    passwordLabel.text = @"密码:";
    [passwordLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(phoneLine.mas_bottom).with.offset(29);
        make.left.equalTo(containerV.mas_left).with.offset(0);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(20);
    }];
    [textPassword mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(passwordLabel.mas_top);
        make.left.equalTo(passwordLabel.mas_right).with.offset(0);
        make.width.mas_equalTo(190);
        make.height.mas_equalTo(20);
    }];
    passwordLine.backgroundColor =[UIColor colorWithHex:@"#864602" alpha:1.0];
    [passwordLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(textPassword.mas_bottom).with.offset(16);
        make.left.mas_equalTo(containerV.mas_left);
        make.width.mas_equalTo(250);
        make.height.mas_equalTo(1);
    }];
    [registeBtn setBackgroundColor:[UIColor colorWithHex:@"#864602" alpha:1.0]];
    [registeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(passwordLine.mas_bottom).with.offset(30);
        make.left.mas_equalTo(containerV.mas_left);
        make.width.mas_equalTo(250);
        make.height.mas_equalTo(33);
    }];
    
    [registeBtn addTarget:self action:@selector(clickRegister) forControlEvents:UIControlEventTouchDown];
    
    [backBtn setBackgroundImage:[UIImage imageNamed:@"detail_back.png"] forState:UIControlStateNormal];
    [backBtn setBackgroundImage:[UIImage imageNamed:@"detail_back.png"] forState:UIControlEventTouchUpInside];
    [backBtn addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
    [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view).with.offset(-11);
        make.right.equalTo(self.view).with.offset(-58);
        make.width.mas_equalTo(38);
        make.height.mas_equalTo(44);
    }];
}
-(void)viewTapped:(UITapGestureRecognizer*)tap1
{
    
    [self.view endEditing:YES];
    
}
-(void)backClick
{
    [self.navigationController popViewControllerAnimated:NO];
}
- (void)clickRegister
{
    NSMutableString *muStr=[NSMutableString string];
    [muStr appendString:TServerBaseURL];
    [muStr appendString:TclientRegister];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    //申明返回的结果是json类型
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    //申明请求的数据是json类型
 //   manager.requestSerializer=[AFJSONRequestSerializer serializer];
    //如果报接受类型不一致请替换一致text/html或别的
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    NSString *str =[MD5 md5:textPassword.text];
//    NSDictionary *parameters=@{
//                              @"phone":@"13366047237",
//                              @"password":[MD5 md5:@"123"],
//                              @"username":@"nancy"
//                              };
    
    NSDictionary *parameters=@{
                               @"phone":textPhone.text,
                               @"password":[MD5 md5:str],
                               @"username":textUserName.text
                               };

    NSLog(@"%@",muStr);
    [manager POST:muStr parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        [self.view makeToast:@"注册成功"];
        
        [self.navigationController popViewControllerAnimated:YES];
       
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
    //ViewController *V=[[ViewController alloc]init];
    // DetailViewController *mainVC=[[DetailViewController alloc]init];
    //MainViewController *mainVC=[[MainViewController alloc]init];
    //AppDelegate *delegate=(AppDelegate *)[[UIApplication sharedApplication]delegate];
    //LoginViewController *login=[[LoginViewController alloc]init];
    //[self.navController pushViewController:login animated:YES];
   // [self.navigationController pushViewController:mainVC animated:YES];
}
@end
