//
//  NearShopList.h
//  TimePeriod
//
//  Created by linan on 16/4/20.
//  Copyright (c) 2016年 dhc1256436519. All rights reserved.
//

#import "JSONModel.h"

@interface NearShopListModel : JSONModel
@property (nonatomic,assign) NSInteger rticleaID;
@property (nonatomic,assign) double distance;
@property (nonatomic,strong) NSString *area;
@property (nonatomic,assign) NSInteger shopID;
@property (nonatomic,strong) NSString *shopName;
@property (nonatomic,strong) NSString *imgThumbnail;

@end
