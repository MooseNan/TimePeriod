//
//  ArticleListModel.h
//  TimePeriod
//
//  Created by linan on 16/4/17.
//  Copyright (c) 2016年 dhc1256436519. All rights reserved.
//

#import "JSONModel.h"
#import "ArticleInfoModel.h"

@interface ArticleListModel : JSONModel
@property (nonatomic,strong) NSArray<ArticleInfoModel> *list;
@property (nonatomic,assign) NSInteger page;
@property (nonatomic,assign) NSInteger totalPage;

@end
