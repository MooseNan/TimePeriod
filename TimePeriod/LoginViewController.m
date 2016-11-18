//
//  LoginViewController.m
//  TimePeriod
//
//  Created by dhc1256436519 on 16/4/16.
//  Copyright © 2016年 dhc1256436519. All rights reserved.
//

#import "LoginViewController.h"
#import "AFNetworking.h"
#import "UIColor+CreateMethod.h"
#import "GlobalConstant.h"
#import "Masonry.h"
#import "RegisterViewController.h"
#import "ViewController.h"
#import "AppDelegate.h"
#import "MD5.h"
#import "DetailViewController.h"
#import "HomeViewController.h"
#import "ArticleInfoModel.h"
#import "ArticleListModel.h"
#import "UIView+Toast.h"
@interface LoginViewController ()
{
    UITextField *textUserName;
    UIImageView *nameImg;
    UITextField *textUserPassword;
    UIImageView *passwordImg;
    UIButton *btnLogin;
    UIButton *btnCancel;
    UILabel *labelRegister;
}
@end

@implementation LoginViewController

- (void)viewDidLoad {
   
    [super viewDidLoad];
    self.navigationController.navigationBarHidden=  YES;
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithHex:@"#864602" alpha:1.0]];
    UIColor * color = [UIColor whiteColor];
    
    //这里我们设置的是颜色，还可以设置shadow等，具体可以参见api
    NSDictionary * dict = [NSDictionary dictionaryWithObject:color forKey:NSForegroundColorAttributeName];
    
    //大功告成
    self.navigationController.navigationBar.titleTextAttributes = dict;
    self.view.backgroundColor=[UIColor whiteColor];
    
    textUserName=[UITextField new];
    textUserPassword=[UITextField new];
    nameImg = [UIImageView new];
    passwordImg = [UIImageView new];
    btnLogin=[UIButton new];
    btnCancel=[UIButton new];
    labelRegister=[UILabel new];
    UIImageView *container=[UIImageView new];
    container.userInteractionEnabled = YES;
    container.image = [UIImage imageNamed:@"login_bg.png"];
    [self.view addSubview:container];
    container.backgroundColor=[UIColor whiteColor];

    [container mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).with.offset(276);
        make.centerX.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(254, 90));
    }];
    
    [container addSubview:textUserName];
    [container addSubview:textUserPassword];
    [container addSubview:nameImg];
    [container addSubview:passwordImg];
    nameImg.image = [UIImage imageNamed:@"login_name.png"];
    [nameImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(container.mas_top).with.offset(5);
        make.left.equalTo(container.mas_left).with.offset(0);
        make.width.mas_equalTo(nameImg.image.size.width);
        make.height.mas_equalTo(nameImg.image.size.height);
    }];
    [textUserName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(container.mas_top).with.offset(15);
        make.left.equalTo(nameImg.mas_right).with.offset(0);
        make.width.mas_equalTo(210);
        make.height.mas_equalTo(20);
    }];
    textUserName.textColor =[UIColor blackColor];
    textUserPassword.textColor = [UIColor blackColor];
    passwordImg.image = [UIImage imageNamed:@"login_password.png"];
    [passwordImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(container.mas_top).with.offset(50);
        make.left.equalTo(container.mas_left).with.offset(0);
        make.width.mas_equalTo(nameImg.image.size.width);
        make.height.mas_equalTo(nameImg.image.size.width);
    }];
    textUserPassword.secureTextEntry = YES; //密码类型
    textUserName.backgroundColor=[UIColor whiteColor];
    [textUserPassword mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(container.mas_top).with.offset(60);
        make.left.equalTo(passwordImg.mas_right).with.offset(0);
        make.width.mas_equalTo(210);
        make.height.mas_equalTo(20);
    }];
    [self.view addSubview:btnLogin];
    [self.view addSubview:btnCancel];
    [self.view addSubview:labelRegister];
    
    [btnLogin mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(container.mas_bottom).with.offset(8);
        make.left.equalTo(container.mas_left);
        make.width.mas_equalTo(90);
        make.height.mas_equalTo(27);
    }];
    [btnLogin setBackgroundImage:[UIImage imageNamed:@"login_logBtn.png"] forState:UIControlStateNormal];
    [btnLogin addTarget:self action:@selector(loginClick) forControlEvents:UIControlEventTouchUpInside];
   
    [btnCancel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(container.mas_bottom).with.offset(8);
        make.right.equalTo(container.mas_right);
        make.width.mas_equalTo(90);
        make.height.mas_equalTo(27);
    }];
    [btnCancel setBackgroundImage:[UIImage imageNamed:@"login_cancel.png"] forState:UIControlStateNormal];
    [btnCancel addTarget:self action:@selector(cancelBtnClick) forControlEvents:UIControlEventTouchUpInside];
    labelRegister.text=@"新人注册";
    labelRegister.textColor= [UIColor colorWithHex:@"#864602" alpha:1.0];
    labelRegister.textAlignment=NSTextAlignmentRight;
    [labelRegister setFont:[UIFont systemFontOfSize:14]];
    [labelRegister mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(btnCancel.mas_bottom).with.offset(15);
        make.right.equalTo(container.mas_right);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(20);

    }];
    labelRegister.userInteractionEnabled=YES;
    UITapGestureRecognizer *labelTapGestureRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(registClick:)];
    
    [labelRegister addGestureRecognizer:labelTapGestureRecognizer];
    textUserPassword.backgroundColor=[UIColor whiteColor];
    
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated
{
}
-(void)cancelBtnClick
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)autoLogin
{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSString *name = [userDefault objectForKey:@"name"];
    NSString *token=[userDefault objectForKey:@"token"];
    if (name!=nil&&token!=nil) {
        HomeViewController *mainVC=[[HomeViewController alloc]init];
        [self.navigationController pushViewController:mainVC animated:NO];
    }
    
}
-(void)getNetworkData:(int)pageC
{
    NSMutableString *requestURL=[NSMutableString string];
    [requestURL appendString:TServerBaseURL];
    [requestURL appendString:TclientMainList];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    //申明返回的结果是json类型
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    //申明请求的数据是json类型
    manager.requestSerializer=[AFJSONRequestSerializer serializer];
    //如果报接受类型不一致请替换一致text/html或别的
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    NSNumber *page = [NSNumber numberWithInt:pageC];
    NSNumber *pageSize = @3;
    NSDictionary *parameters=@{
                               @"page":page,
                               @"pageSize":pageSize
                               };
    
    NSLog(@"%@",requestURL);
    [manager GET:requestURL parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@",responseObject);
        NSDictionary *dic = responseObject;
        dic =[dic objectForKey:@"data"];
        NSError *error;
        ArticleListModel *articleModel = [[ArticleListModel alloc]initWithDictionary:dic error:&error];
        [self getNetworkData:2];
        [self getNetworkData:3];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"error%@",error);
    }];
    
    
}

- (void)loginClick
{
   
     NSMutableString *muStr=[NSMutableString string];
    [muStr appendString:TServerBaseURL];
    [muStr appendString:TclientLogin];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    //申明返回的结果是json类型
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    //申明请求的数据是json类型
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    NSDictionary *parameters=@{
                               @"phone":textUserName.text,
                               @"password":[MD5 md5:textUserPassword.text],
                               };
    
    NSLog(@"%@",muStr);
    [manager POST:muStr parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@",responseObject);
       
        NSDictionary *dic = [NSDictionary dictionaryWithDictionary:responseObject];
        if ([dic[@"return_code"] isEqual:@"-100004"]) {
            [self.view makeToast:@"用户名或者密码不正确"];
            return ;
        }
        dic =[dic objectForKey:@"data"];
        NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
        
        [userDefault setObject:[dic objectForKey:@"token"] forKey:@"token"];
        [userDefault setObject:[dic objectForKey:@"username"] forKey:@"name"];
        [userDefault synchronize];
         HomeViewController *mainVC=[[HomeViewController alloc]init];
        [self.navigationController pushViewController:mainVC animated:YES];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
    
}

-(void) registClick:(UITapGestureRecognizer *)recognizer{
    
    UILabel *label=(UILabel*)recognizer.view;
    RegisterViewController *registerViewController=[[RegisterViewController alloc]init];
    [self.navigationController pushViewController:registerViewController animated:YES];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
