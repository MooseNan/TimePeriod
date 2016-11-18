//
//  DiscoutModel.h
//  TimePeriod
//
//  Created by linan on 16/4/21.
//  Copyright (c) 2016年 dhc1256436519. All rights reserved.
//

#import "JSONModel.h"

@interface DiscoutModel : JSONModel
@property (nonatomic,assign) NSInteger couponID;
@property (nonatomic,strong) NSString *dataFrom;
@property(nonatomic,strong) NSString *dataTo;
@property (nonatomic,assign) NSInteger disType;
@property (nonatomic,assign) NSInteger discount;
@property (nonatomic,strong) NSString *shopName;
@property (nonatomic,assign) NSInteger type;




@end
