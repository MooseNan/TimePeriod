//
//  TPDatabase.h
//  TimePeriod
//
//  Created by linan on 16/4/17.
//  Copyright (c) 2016年 dhc1256436519. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDatabase.h"
#import "GlobalConstant.h"
@interface TPDatabase : NSObject

+ (TPDatabase *)shareDB;
- (void)createDB;
- (void)createDBWithSqlName:(NSString*)name;
- (BOOL)insertIntoTable:(NSString *)table Data:(NSDictionary *)dataDic;
- (BOOL)deleteFromTable:(NSString *)tableName WithID:(NSString *)guid;
- (BOOL)cleanTable:(NSString *)tableName;
@end
