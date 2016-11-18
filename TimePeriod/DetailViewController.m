//
//  DetailViewController.m
//  TimePeriod
//
//  Created by linan on 16/4/18.
//  Copyright (c) 2016年 dhc1256436519. All rights reserved.
//

#import "DetailViewController.h"
#import "Masonry.h"
#import "UIColor+CreateMethod.h"
#import "AFNetworking.h"
#import "GlobalConstant.h"
#import "UIImageView+AFNetworking.h"
#import "GeocodeDemoViewController.h"
#import <CommonCrypto/CommonDigest.h>
#import "DiscountView.h"
#import "UIView+Toast.h"

@interface DetailViewController ()<UIWebViewDelegate>
{
    UIScrollView *containerView;
    UIImageView *coverImg;
    UILabel *title;
    UIImageView *icon;
    UILabel *name;
    UIButton *position;
    UIButton *phone;
    UIImageView *moneyIcon;
    UILabel *money;
    DiscountView *discountView;
    UIImageView *lineTop;
    UIImageView *lineBottom;
    UILabel *giftMoney;
    UIWebView *detailView;
    UILabel *detailLabel;
    UIButton *backBtn;
    CGRect webFrame;
    
    int isLogin;
}
@end

@implementation DetailViewController

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
//   // containerView.contentSize = CGSizeMake(self.view.frame.size.width, self.view.frame.size.height*6);
//    CGRect frame = detailView.frame;
//    frame.size.height = 1;
//    detailView.frame = frame;
}
-(void)viewDidLayoutSubviews
{
  //   containerView.contentSize = CGSizeMake(self.view.frame.size.width, self.view.frame.size.height*6);
   
}
-(void)viewWillDisappear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:NO];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:YES];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSString *username = [userDefault objectForKey:@"name"];
    if (username==nil) {
        isLogin = false;
    }
    else
        isLogin = true;
    [self getNetworkData];
    containerView = [UIScrollView new];
    coverImg = [UIImageView new];
    title = [UILabel new];
    icon = [UIImageView new];
    name = [UILabel new];
    position = [UIButton new];
    phone = [UIButton new];
    moneyIcon = [UIImageView new];
    money = [UILabel new];
    discountView=[DiscountView new];
    discountView = [[DiscountView alloc]initWithFrame:CGRectMake(0, 0, 100, 100)];
    giftMoney = [UILabel new];
    detailView = [UIWebView new];
    detailLabel = [UILabel new];
    backBtn = [UIButton new];
    lineTop = [UIImageView new];
    lineBottom = [UIImageView new];
    [self.view addSubview:containerView];
    [self.view addSubview:backBtn];
    [containerView addSubview:coverImg];
    [containerView addSubview:title];
    [containerView addSubview:icon];
    [containerView addSubview:name];
    [containerView addSubview:lineTop];
    [containerView addSubview:lineBottom];
    [containerView addSubview:position];
    [containerView addSubview:phone];
    [containerView addSubview:moneyIcon];
    [containerView addSubview:money];
    [containerView addSubview:discountView];
    [detailView addSubview:detailLabel];
    detailView.delegate =self;

    [containerView addSubview:detailView];
  
    containerView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    containerView.contentSize = CGSizeMake(self.view.frame.size.width, self.view.frame.size.height*2);
    containerView.showsHorizontalScrollIndicator = NO;
    containerView.showsVerticalScrollIndicator = NO;
    containerView.scrollEnabled = YES;
    containerView.userInteractionEnabled = YES;
    containerView.alwaysBounceVertical  =YES;
    containerView.directionalLockEnabled = YES;
    [coverImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(containerView.mas_top).with.offset(0);
        make.left.equalTo(containerView.mas_left).with.offset(0);
        make.width.mas_equalTo(containerView.mas_width);
        make.height.mas_equalTo(450*self.view.frame.size.width/960);
    }];
    coverImg.contentMode = UIViewContentModeScaleAspectFill;
    coverImg.clipsToBounds =YES;

    [title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(coverImg.mas_bottom).with.offset(22);
        make.left.equalTo(coverImg.mas_left).with.offset(20);
        make.width.mas_equalTo(self.view.frame.size.width-20);
        make.height.mas_equalTo(20);
    }];
    title.textColor = [UIColor colorWithHex:@"#864602" alpha:1.0];
    [title setFont:[UIFont fontWithName:nil size:18]];
    [icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(title.mas_bottom).with.offset(22);
        make.left.equalTo(containerView).with.offset(22);
        make.width.mas_equalTo(31);
        make.height.mas_equalTo(31);
    }];
    icon.layer.masksToBounds = YES;
    icon.layer.cornerRadius = 10.0;
    [name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(icon.mas_top);
        make.left.equalTo(icon.mas_right).with.offset(20);
        make.width.mas_equalTo(200);
        make.height.mas_equalTo(31);
    }];
    name.textColor = [UIColor colorWithHex:@"#864602" alpha:1.0];
    [position mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(icon.mas_bottom).with.offset(10);
        make.left.equalTo(containerView).with.offset(62);
        make.width.mas_equalTo(self.view.frame.size.width-62);
        make.height.mas_equalTo(21);
    }];

    [position setImage:[UIImage imageNamed:@"detail_position.png"] forState:UIControlStateNormal];
    [position setTitleColor:[UIColor colorWithHex:@"#864602" alpha:1.0] forState:UIControlStateNormal];
    position.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    position.titleEdgeInsets = UIEdgeInsetsMake(0, 12, 0, 0);
    position.titleLabel.font= [UIFont fontWithName:nil size:16];
    [position addTarget:self action:@selector(getBaiduMap) forControlEvents:UIControlEventTouchUpInside];

    [phone mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(position.mas_bottom).with.offset(13);
        make.left.equalTo(containerView).with.offset(62);
        make.width.mas_equalTo(self.view.frame.size.width-62);
        make.height.mas_equalTo(21);
    }];
    [phone setImage:[UIImage imageNamed:@"detail_phone.png"] forState:UIControlStateNormal];
    [phone setTitleColor:[UIColor colorWithHex:@"#864602" alpha:1.0] forState:UIControlStateNormal];
    phone.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    phone.titleEdgeInsets = UIEdgeInsetsMake(0, 12, 0, 0);
    phone.titleLabel.font= [UIFont fontWithName:nil size:16];
    [phone addTarget:self action:@selector(phoneClick) forControlEvents:UIControlEventTouchUpInside];
    
    [moneyIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(phone.mas_bottom).with.offset(13);
        make.left.equalTo(containerView).with.offset(62);
        make.width.mas_equalTo(16);
        make.height.mas_equalTo(19);
    }];
    moneyIcon.image = [UIImage imageNamed:@"detail_money.png"];
    [money mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(moneyIcon.mas_top);
        make.left.equalTo(moneyIcon.mas_right).with.offset(12);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(moneyIcon.mas_height);
    }];
    money.textColor =[UIColor colorWithHex:@"#864602" alpha:1.0];
    [lineTop mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(money.mas_bottom).with.offset(5);
        make.left.equalTo(containerView).with.offset(0);
        make.width.mas_equalTo(self.view.frame.size.width);
        make.height.mas_equalTo(1);
    }];
    lineTop.image = [UIImage imageNamed:@"line.png"];

    [discountView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineTop.mas_bottom).with.offset(16);
        make.left.equalTo(containerView).with.offset(0);
        make.width.mas_equalTo(self.view.frame.size.width);
        make.height.mas_equalTo(134);
    }];
    [discountView.getBtn addTarget:self action:@selector(getDiscoutBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [lineBottom mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(discountView.mas_bottom).with.offset(0);
        make.left.equalTo(containerView).with.offset(0);
        make.width.mas_equalTo(self.view.frame.size.width);
        make.height.mas_equalTo(1);
    }];
    lineBottom.image = [UIImage imageNamed:@"line.png"];

    [detailView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineBottom.mas_bottom).with.offset(0);
        make.left.equalTo(containerView).with.offset(15);
        make.width.mas_equalTo(self.view.frame.size.width-30);
        make.height.mas_equalTo(6000);
    }];
    detailView.backgroundColor =[UIColor clearColor];
    detailView.userInteractionEnabled = NO;
    [backBtn setBackgroundImage:[UIImage imageNamed:@"detail_back.png"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
    [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view).with.offset(-11);
        make.right.equalTo(self.view).with.offset(-58);
        make.width.mas_equalTo(38);
        make.height.mas_equalTo(44);
    }];
    detailView.opaque = NO;
 
}
- (void)webViewDidFinishLoad:(UIWebView *)webView

{
    
    webFrame = webView.frame;
    webFrame.size.height = 1;
    webView.frame = webFrame;
    webFrame.size.height = webView.scrollView.contentSize.height;
    webView.frame = webFrame;
    containerView.contentSize = CGSizeMake(0, webView.frame.size.height+webView.frame.origin.y);

    [detailView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineBottom.mas_bottom).with.offset(0);
        make.left.equalTo(containerView).with.offset(15);
        make.width.mas_equalTo(self.view.frame.size.width-30);
        make.height.mas_equalTo(webFrame.size.height);
    }];
     [self.view layoutIfNeeded];
 }

-(void)phoneClick
{
    NSString *number = phone.titleLabel.text;
    NSString *num =[[NSString alloc]initWithFormat:@"telprompt://%@",number];
    [[UIApplication sharedApplication]openURL:[NSURL URLWithString:num]];
    
}
-(void)backClick
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)getBaiduMap
{
    GeocodeDemoViewController *mapVC = [[GeocodeDemoViewController alloc]init];
    mapVC.area = position.titleLabel.text;
    [self.navigationController pushViewController:mapVC animated:YES];
}

-(void)getDiscoutBtnClick
{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSString *token = [userDefault objectForKey:@"token"];
    NSString *username =[userDefault objectForKey:@"name"];
    if (!isLogin) {
        [self.view makeToast:@"请登录后再领取优惠券，领取后您的优惠券会躺在我的优惠券中"];
    }
    else
    {
    NSMutableString *requestURL=[NSMutableString string];
    [requestURL appendString:TServerBaseURL];
    [requestURL appendString:TclientGetDiscount];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    //申明返回的结果是json类型
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    //申明请求的数据是json类型
    manager.requestSerializer=[AFJSONRequestSerializer serializer];
    //如果报接受类型不一致请替换一致text/html或别的
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
  
    NSNumber *discountNum = [NSNumber numberWithInt:self.discoutID];
    NSDictionary *parameters=@{
                               @"token":token,
                               @"couponID":discountNum
                               };

    NSLog(@"%@",requestURL);
    [manager GET:requestURL parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [discountView.getBtn setTitle:@"已领取" forState:UIControlStateNormal];
        discountView.userInteractionEnabled = NO;
          } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"error%@",error);
    }];
    }
    
    

}
-(void)getNetworkData
{
 //   [self getToken];
    NSMutableString *requestURL=[NSMutableString string];
    [requestURL appendString:TServerBaseURL];
    [requestURL appendString:TclinetGetDetail];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    //申明返回的结果是json类型
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    //申明请求的数据是json类型
    manager.requestSerializer=[AFJSONRequestSerializer serializer];
    //如果报接受类型不一致请替换一致text/html或别的
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSString *token = [userDefault objectForKey:@"token"];
    NSString *articleStr = [NSString stringWithFormat:@"%ld",(long)self.articleID];
    if (token==nil) {
        token=@"";
    }
    NSDictionary *parameters=@{
                               @"rticleaID":articleStr,
                               @"token":token
                               };

    NSLog(@"%@",requestURL);
    [manager GET:requestURL parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@",responseObject);
        NSDictionary *dic = responseObject;
        dic =[dic objectForKey:@"data"];
        NSString *str=[dic objectForKey:@"couponID"];
        self.discoutID = [str intValue];
        name.text= [dic objectForKey:@"shopName"];
        NSURL *coverImgURL = [NSURL URLWithString:[dic objectForKey:@"imgCover"]];
        NSURL *iconURL =[NSURL URLWithString:[dic objectForKey:@"logo"]];
        [coverImg setImageWithURL:coverImgURL placeholderImage:[UIImage imageNamed:@"default_img.png"]];
        title.text= [dic objectForKey:@"title"];
        [icon setImageWithURL:iconURL placeholderImage:nil];
        [position setTitle:[dic objectForKey:@"area"] forState:UIControlStateNormal];
        [phone setTitle:[dic objectForKey:@"phone"] forState:UIControlStateNormal];
        money.text =[dic objectForKey:@"per"];
        NSNumber *noDis = @-1;
        NSNumber *coupon = @1;
        NSNumber *discount = @2;
        if ([[dic objectForKey:@"disType"] isEqualToNumber: noDis] ) {
          
            discountView.hidden = YES;
            [detailView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(lineTop.mas_bottom).with.offset(0);
                make.left.equalTo(containerView).with.offset(15);
                make.width.mas_equalTo(self.view.frame.size.width-30);
                make.height.mas_equalTo(1000);
            }];
        }
        else if([[dic objectForKey:@"disType"] isEqualToNumber: coupon ]|| [[dic objectForKey:@"disType"] isEqualToNumber: discount] )
        {
            //discountView.youhuiquan 从网络判断当没有优惠券的时候
            discountView.validity.text = [NSString stringWithFormat:@"有效期：%@-%@",[dic objectForKey:@"dataFrom"],[dic objectForKey:@"dataTo"]];
            NSNumber *num = @1;
            NSLog(@"%@",[dic objectForKey:@"useTime"]);
            if ([[dic objectForKey:@"disType"]isEqualToNumber:coupon]) {
                
                discountView.discountType.text = @"元";
                discountView.title.text = [NSString stringWithFormat:@"老板给了%@%@优惠券",[dic objectForKey:@"discount"],@"元"];
            }
            else
            {
                discountView.discountType.text = @"折";
                discountView.title.text = [NSString stringWithFormat:@"老板给了%@%@优惠券",[dic objectForKey:@"discount"],@"折"];
                
               
            }
                      discountView.usingTime.text=[NSString stringWithFormat:@"使用时间：%@",[dic objectForKey:@"useTime"]];
            discountView.money.text = [dic objectForKey:@"discount"];
            if([[dic objectForKey:@"useType"] isEqualToNumber:num])
            {
                discountView.useType.text = @"适用人群：按桌次";
            }
            else
                discountView.useType.text = @"适用人群：按人次";
            
            NSNumber *hasGet = @1;
            
            if (isLogin&&[[dic objectForKey:@"status"] isEqualToNumber:hasGet]) {
                
                    [discountView.getBtn setTitle:@"已领取" forState:UIControlStateNormal];
                    discountView.userInteractionEnabled = NO;
             
            }
            else
                 [discountView.getBtn setTitle:@"领取" forState:UIControlStateNormal];
                
          
            
        }
        [detailView loadHTMLString:[dic objectForKey:@"context"] baseURL:nil];
  
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];


}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
