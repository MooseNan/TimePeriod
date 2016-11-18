//
//  DiscountViewController.m
//  TimePeriod
//
//  Created by linan on 16/4/21.
//  Copyright (c) 2016年 dhc1256436519. All rights reserved.
//

#import "DiscountViewController.h"
#import "UIColor+CreateMethod.h"
#import "DiscountCell.h"
#import "DiscoutModel.h"
#import "AFNetworking.h"
#import "GlobalConstant.h"
#import "Masonry.h"
#define kWindow   [[UIApplication sharedApplication].delegate window]
@interface DiscountViewController ()
{
     UIButton *backBtn;
     UITableView *tableView;
    NSMutableArray *newArray;
}
@property(nonatomic,strong) NSArray *dataArray;

@end

@implementation DiscountViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController setNavigationBarHidden:NO];
    self.navigationItem.hidesBackButton = YES;
    self.dataArray = [NSArray array];
    tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,0, self.view.frame.size.width, self.view.frame.size.height)];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.separatorColor =[UIColor colorWithHex:@"#864602" alpha:1.0];
    [self.view addSubview:tableView];
    [self setExtraCellLineHidden:tableView];

    backBtn = [UIButton new];

    [self.view addSubview:backBtn];
    [backBtn bringSubviewToFront:self.view];
    [backBtn setBackgroundImage:[UIImage imageNamed:@"detail_back.png"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
    [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view).with.offset(-11);
        make.right.equalTo(self.view).with.offset(-58);
        make.width.mas_equalTo(38);
        make.height.mas_equalTo(44);
    }];
    
    [self getNetworkData];
    // Do any additional setup after loading the view.
}
-(void)backClick
{
    [self.navigationController popViewControllerAnimated:NO];
}
-(void)deleteOverTime
{
    newArray = [[NSMutableArray alloc]init];
   // NSMutableArray *array = [NSMutableArray arrayWithArray:_dataArray];

    for (int i=0; i<[_dataArray count]; i++) {
        NSDictionary *dic = [_dataArray objectAtIndex:i];
        NSError *error;
        DiscoutModel *model = [[DiscoutModel alloc]initWithDictionary:dic error:&error];
        NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        
        NSDate *dataNow = [NSDate date];
        NSDate *dataTo = [dateFormatter dateFromString:model.dataTo];
        NSTimeInterval time=[dataTo timeIntervalSinceDate:dataNow];
        int days=((int)time)/(3600*24);
        if (days<0) {
           // [array removeObjectAtIndex:i];
        }
        else
        {
            [newArray addObject:[_dataArray objectAtIndex:i]];
        }
    }
    [tableView reloadData];
}
-(void)getNetworkData
{
    NSMutableString *requestURL=[NSMutableString string];
    [requestURL appendString:TServerBaseURL];
    [requestURL appendString:TclinetGetCoupList];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    //申明返回的结果是json类型
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    //申明请求的数据是json类型
    manager.requestSerializer=[AFJSONRequestSerializer serializer];
    //如果报接受类型不一致请替换一致text/html或别的
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSString *token = [userDefault objectForKey:@"token"];
    
    NSDictionary *parameters=@{
                               @"token":token
                               };
    
    NSLog(@"%@",requestURL);
    [manager GET:requestURL parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@",responseObject);
        NSDictionary *dic = responseObject;
        dic =[dic objectForKey:@"data"];
        _dataArray = [dic objectForKey:@"list"];
      //  [tableView reloadData];
        [self deleteOverTime];
      //  NSError *error;
       // DiscoutModel *discountModel = [[DiscoutModel alloc]initWithDictionary:dic error:&error];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"error%@",error);
    }];
    

}
-(void)setExtraCellLineHidden: (UITableView *)tableView
{
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor clearColor];
    [tableView setTableFooterView:view];
}
-(void)viewDidLayoutSubviews{
    if ([tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [tableView setSeparatorInset:UIEdgeInsetsZero];
        
    }
    if ([tableView respondsToSelector:@selector(setLayoutMargins:)])  {
        [tableView setLayoutMargins:UIEdgeInsetsZero];
    }
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - Table view data source
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 48;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [newArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 1.创建cell
    static NSString *ID = @"DiscoutCell";
    DiscountCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[DiscountCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    NSDictionary *dic = [newArray objectAtIndex:indexPath.row];
    NSError *error;
    DiscoutModel *model = [[DiscoutModel alloc]initWithDictionary:dic error:&error];
    // 2.设置cell的数据
    cell.discountBG.image = [UIImage imageNamed:@"detail_gift.png"];
    NSInteger discout =model.discount;
    NSString *discountStr= [NSString stringWithFormat:@"%ld",(long)discout];
    cell.discountMoney.text = discountStr;
    if (model.disType == 1 ) {
        cell.discountType.text = @"折";
    }
    else if (model.disType==2)
    {
        cell.discountType.text =@"元";
    }
    cell.discountTitle.text = model.shopName;
    
    cell.discountTime.text = [NSString stringWithFormat:@"%@至%@有效",model.dataFrom,model.dataTo];
       return cell;
}
-(void)tableView:(UITableView *)tableView willDisplayCell:(DiscountCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPat{
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]){
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
}



@end
