//
//  HomeMenuViewController.m
//  侧滑菜单
//
//  Created by apple on 14-5-27.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "HomeMenuViewController.h"
#import "UIColor+CreateMethod.h"
#import "MenuTableViewCell.h"
#import "DiscountViewController.h"
#import "LoginViewController.h"
#import "Masonry.h"
#import "UIView+Toast.h"

@interface HomeMenuViewController ()
{
    NSArray *arr;
    _Bool isLogin;
    UIButton *login;
}
@end

@implementation HomeMenuViewController
- (void)viewDidLoad
{
    
    [super viewDidLoad];
    login=[[UIButton alloc]init];
    [login setBackgroundImage:[UIImage imageNamed:@"login_logBtn.png"] forState:UIControlStateNormal];
    [login addTarget:self action:@selector(doButton) forControlEvents:UIControlEventTouchDown];
    login.hidden=YES;
    [self.tableView setScrollEnabled:NO];
    self.tableView.separatorColor =[UIColor colorWithHex:@"#864602" alpha:1.0];
    [self setExtraCellLineHidden:self.tableView];
    NSUserDefaults *userDefault= [NSUserDefaults standardUserDefaults];
    NSString *nameStr = [userDefault objectForKey:@"name"];
    if (nameStr==nil) {
        isLogin=false;
        login.hidden=false;
    }
    else
    {
        isLogin=true;
        arr=@[nameStr,@"我的优惠券",@"清理缓存",@"退出登录"];
    }
    
    
    self.view.backgroundColor = [UIColor whiteColor];
}
- (void)doButton
{
    LoginViewController *loginController=[[LoginViewController alloc]init];
    [self.navigationController pushViewController:loginController animated:YES];
}
-(void)viewDidLayoutSubviews{
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tableView setSeparatorInset:UIEdgeInsetsZero];
        
    }
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)])  {
        [self.tableView setLayoutMargins:UIEdgeInsetsZero];
    }

}
-(void)setExtraCellLineHidden: (UITableView *)tableView
{
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor clearColor];
    [tableView setTableFooterView:view];
}
#pragma mark - Table view data source
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (isLogin==false) {
        return self.view.frame.size.height;
    }
    return 60;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (isLogin==false) {
        return 1;
    }
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (isLogin==false) {
        UITableViewCell *cell=[[UITableViewCell alloc]init];
        [cell.contentView addSubview:login];
        [login mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(cell.contentView);
            make.width.mas_equalTo(90);
            make.height.mas_equalTo(27);
        }];
        return cell;
        
    }
    // 1.创建cell
    static NSString *ID = @"cell";
    MenuTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[MenuTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
       // cell.backgroundColor = [UIColor blueColor];
    }
    
    // 2.设置cell的数据

    cell.textLabel.text = [NSString stringWithFormat:@"%@ ", arr[indexPath.row]];
    if(indexPath.row == 1)
    {
        cell.imageView.image = [UIImage imageNamed:@"home_discount.png"];
    }
    else if(indexPath.row==2)
    {
        cell.imageView.image = [UIImage imageNamed:@"home_setting.png"];
    }
    else if(indexPath.row==3)
    {
        cell.imageView.image = [UIImage imageNamed:@"home_logout.png"];
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView willDisplayCell:(MenuTableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPat{
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]){
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==1) {
        DiscountViewController *discountView= [[DiscountViewController alloc]init];
        [self.navigationController pushViewController:discountView animated:YES];
    }
    if(indexPath.row==2)
    {

        [self.view makeToast:@"清除缓存成功"];

    }
    if (indexPath.row==3) {
        [self backToLogin];

    }
}
- (void)backToLogin
{

    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults removeObjectForKey:@"name"];
    [userDefaults synchronize];
   
    isLogin=false;
    login.hidden=false;
    
    [self.tableView reloadData];

  
}

@end
