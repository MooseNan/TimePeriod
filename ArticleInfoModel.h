//
//  ArticleInfoModel.h
//  TimePeriod
//
//  Created by linan on 16/4/17.
//  Copyright (c) 2016年 dhc1256436519. All rights reserved.
//

#import "JSONModel.h"
@protocol ArticleInfoModel <NSObject>

@end
@interface ArticleInfoModel : JSONModel
@property (nonatomic,strong) NSString *area;
@property (nonatomic,strong) NSString *createTime;
@property (nonatomic,strong) NSString *imgCover;
@property (nonatomic,strong) NSString *imgThumbnail;
@property (nonatomic,assign) NSInteger rticleaID;
@property (nonatomic,strong) NSString *title;
@property (nonatomic,strong) NSString<Optional> *updateTime;

@end
