//
//  NearShopModel.h
//  TimePeriod
//
//  Created by linan on 16/4/24.
//  Copyright (c) 2016年 dhc1256436519. All rights reserved.
//

#import "JSONModel.h"

@interface NearShopModel : JSONModel
@property (nonatomic,assign) NSInteger rticleaID;
@property (nonatomic,assign) float distance;
@property (nonatomic,strong) NSString *area;
@property (nonatomic,assign) NSInteger shopID;
@property (nonatomic,strong) NSString *shopName;
@property (nonatomic,strong) NSString *imgThumbnail;
@end
