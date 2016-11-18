//
//  MainViewController.m
//  TimePeriod
//
//  Created by linan on 16/4/17.
//  Copyright (c) 2016年 dhc1256436519. All rights reserved.
//

#import "MainViewController.h"
#import "AFNetworking.h"
#import "GlobalConstant.h"
#import "ArticleListModel.h"
#import "TPDatabase.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self getNetworkData];
    //获取数据
    
    // Do any additional setup after loading the view.
}
-(void)getNetworkData
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
    NSNumber *page = @1;
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
        for (ArticleInfoModel * article in articleModel.list) {
            [[TPDatabase shareDB] insertIntoTable:@"Article" Data:[article toDictionary]];
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];

}
-(void)getDBData
{
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
