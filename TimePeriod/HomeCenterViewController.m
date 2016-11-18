//
//  HomeCenterViewController.m
//  侧滑菜单
//
//  Created by apple on 14-5-27.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "HomeCenterViewController.h"
#import "NearScrollView.h"

#import "GlobalConstant.h"
#import "HomeUITableViewCell.h"
#import "NearEmpty.h"

#import "AFNetworking.h"
#import "ArticleListModel.h"
#import "TPDatabase.h"
#import "UIImageView+AFNetworking.h"
#import "NearShopListModel.h"
#import <CoreLocation/CoreLocation.h>
#import "UIColor+CreateMethod.h"
#import "MJRefresh.h"
#import "DetailViewController.h"
#import "HomeHeaderView.h"
#import "AppDelegate.h"
@interface HomeCenterViewController ()<UITableViewDataSource,UITableViewDelegate,CLLocationManagerDelegate>
{
    HomeHeaderView *headerView;
    NearScrollView *nearScrollview;
    NearEmpty *empty;
    NSMutableArray *dataArray;
    NSArray *nearShopArray;
    float lastContentOffset;
    int totalcell;
    int totalPage;
    int currentPage;
    CLLocationManager *locationManager;
    
    double latitude;
    double longitude;
}
@property(nonatomic,strong) UITableView *listView;
@end

@implementation HomeCenterViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(UITableView*)listView
{
    if(!_listView)
    {
        _listView = [[UITableView alloc] init];
        _listView.frame=CGRectMake(0.0, 0, SCREEN_WIDTH, self.view.bounds.size.height);
        [self.view addSubview:_listView];
        //listView.contentInset = UIEdgeInsetsMake(0.0f, 0.0f, 250.0f, 0.0f);
    
        _listView.delegate=self;
        _listView.dataSource=self;
        _listView.backgroundColor=[UIColor colorWithRed:235.0/255 green:235.0/255 blue:235.0/255 alpha:1.0];
        NSString * cellReuseIdentifier = NSStringFromClass([HomeUITableViewCell class]);
    
        [_listView registerClass: NSClassFromString(cellReuseIdentifier) forCellReuseIdentifier:cellReuseIdentifier];

        headerView =[[HomeHeaderView alloc] initWithFrame:CGRectMake(0, 0, _listView.frame.size.width, 150)];
    
        empty=[[NearEmpty alloc] initWithFrame:CGRectMake(0, 0, _listView.frame.size.width, 150)];
        NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
        NSString *token = [userDefault objectForKey:@"token"];
        if (token==nil) {
            
            _listView.tableHeaderView=empty;
        }
        else
        {
            _listView.tableHeaderView=headerView;
        }

        _listView.mj_footer = [MJRefreshAutoFooter footerWithRefreshingBlock:^{
            [self getShopListNetworkData];
        }];
        _listView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            currentPage = 0;
            [self getShopListNetworkData];
        }];
        _listView.separatorColor = [UIColor clearColor];
    }

      return _listView;

}

-(void)viewWillAppear:(BOOL)animated
{
     [self.listView.mj_header beginRefreshing];
}
-(void)endRefresh{
    [self.listView.mj_header endRefreshing];
    [self.listView.mj_footer endRefreshing];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
     self.navigationController.navigationBarHidden=  NO;
    AppDelegate *delegate =[[UIApplication sharedApplication]delegate];
    delegate.centerView = self;


    totalcell = 3;
    dataArray = [NSMutableArray array];
    nearShopArray = [NSArray array];
    [self getMapInfo];
    [self getNearShopListNetworkData];
    currentPage=0;
    [self getShopListNetworkData];

    self.view.backgroundColor = [UIColor colorWithRed:235.0/255 green:235.0/255 blue:235.0/255 alpha:1.0];

}
-(void)getDetailInfo:(NSNumber *)articleID;
{
    DetailViewController *detailView= [[DetailViewController alloc]init];
    
    detailView.articleID =[articleID integerValue];
    
    [self.navigationController pushViewController:detailView animated:YES];
}
-(void)getMapInfo
{
    if([CLLocationManager locationServicesEnabled]) {
        locationManager = [[CLLocationManager alloc]init ];
        locationManager.delegate = self;
    
        locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        if (IOS_VERSION_8) {
            [locationManager requestWhenInUseAuthorization];//使用程序其间允许访问位置数据（iOS8定位需要）
        }
    }
    else{
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"定位不成功 ,请确认开启定位" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alertView show];
    }
    [locationManager startUpdatingLocation];
    
}
-(void)getNearShopListNetworkData
{
    NSMutableString *requestURL=[NSMutableString string];
    [requestURL appendString:TServerBaseURL];
    [requestURL appendString:TclinetGetNearShop];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    //申明返回的结果是json类型
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    //申明请求的数据是json类型
    manager.requestSerializer=[AFJSONRequestSerializer serializer];
    //如果报接受类型不一致请替换一致text/html或别的
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSString *token = [userDefault objectForKey:@"token"];
    if (token==nil) {
        token = @"";
    }
    NSNumber *lat = [NSNumber numberWithDouble:latitude];
    NSNumber *lng = [NSNumber numberWithDouble:longitude];
    
    NSDictionary *parameters=@{
                               @"token":token,
                               @"lat":lng,
                               @"lng":lat
                               };
    
    NSLog(@"111%@",requestURL);
    [manager GET:requestURL parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@",responseObject);
        NSDictionary *dic = responseObject;
        dic =[dic objectForKey:@"data"];
       
        nearShopArray = [dic objectForKey:@"list"];
        if ([nearShopArray count]==0) {
              _listView.tableHeaderView=empty;
        }
        else
        {
            headerView.arrNear=nearShopArray;
            [headerView loadData];
            _listView.tableHeaderView=headerView;

        }
       
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"error%@",error);
    }];

}
-(void)getShopListNetworkData
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
    currentPage++;
    NSNumber *page = [NSNumber numberWithInt:currentPage];
    NSNumber *pageSize = @10;
    NSDictionary *parameters=@{
                               @"page":page,
                               @"pageSize":pageSize
                               };
    
    NSLog(@"%@",requestURL);
    [manager GET:requestURL parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@",responseObject);
        NSDictionary *dic = responseObject;
        [self endRefresh];
        if (1 == currentPage) { // 说明是在重新请求数据.
            dataArray = nil;
            dataArray = [NSMutableArray array];
        }
        dic =[dic objectForKey:@"data"];
        NSError *error;
        ArticleListModel *articleModel = [[ArticleListModel alloc]initWithDictionary:dic error:&error];
        
        NSArray *newArray = [NSArray array];
        newArray = articleModel.list;
        [dataArray addObjectsFromArray:newArray];
        for (ArticleInfoModel * article in dataArray) {
            [[TPDatabase shareDB] insertIntoTable:@"Article" Data:[article toDictionary]];
        }
        [_listView reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"error%@",error);
    }];
    

}
#pragma mark 表格高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 265;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [dataArray count];
}
#pragma mark 表格数据设置
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HomeUITableViewCell *cell=[HomeUITableViewCell cellWithTableView:tableView];
    if([dataArray count]!=0)
    {
        ArticleInfoModel *dic = [dataArray objectAtIndex:indexPath.row];
        NSURL *imgURL = [NSURL URLWithString:dic.imgCover];
        [cell.image setImageWithURL:imgURL placeholderImage:[UIImage imageNamed:@"default_img.png"]];
        cell.title.text = dic.title;
        cell.address.text = dic.area;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}
//隐藏多余分割线
-(void)setExtraCellLineHidden: (UITableView *)tableView{
    UIView *hideview =[ [UIView alloc]init];
    hideview.backgroundColor = [UIColor clearColor];
    [tableView setTableFooterView:hideview];
    [tableView setTableHeaderView:hideview];
}
#pragma mark 点击行,查看详情
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    DetailViewController *detailView= [[DetailViewController alloc]init];
    ArticleInfoModel *infoModel = [dataArray objectAtIndex:indexPath.row];
    detailView.articleID = infoModel.rticleaID;
    
    [self.navigationController pushViewController:detailView animated:YES];
}


#pragma scroll
#pragma mark - CoreLocation Delegate

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    //此处locations存储了持续更新的位置坐标值，取最后一个值为最新位置，如果不想让其持续更新位置，则在此方法中获取到一个值之后让locationManager stopUpdatingLocation
    CLLocation *currentLocation = [locations lastObject];
    longitude = currentLocation.coordinate.longitude;
    latitude = currentLocation.coordinate.latitude;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
