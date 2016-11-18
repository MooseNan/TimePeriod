//
//  TPDatabase.m
//  TimePeriod
//
//  Created by linan on 16/4/17.
//  Copyright (c) 2016年 dhc1256436519. All rights reserved.
//

#import "TPDatabase.h"
static TPDatabase *instance = nil;
@interface TPDatabase()
{
    NSString *m_DBPath;
}

@end
@implementation TPDatabase

- (id)init
{
    self = [super init];
    if (self) {
        m_DBPath = [[NSString alloc]initWithString:[PATH_OF_DOCUMENT stringByAppendingPathComponent:@"DB.sqlite"]];
        NSLog(@"database_path:%@",m_DBPath);
    }
    
    return self;
}
+ (TPDatabase *)shareDB
{
    if(!instance)
    {
        instance = [[TPDatabase alloc]init];
    }
    return instance;
}
#pragma mark - create database

- (void)createDB
{
    [self createDBWithSqlName:@"tables"];
}
- (void)createDBWithSqlName:(NSString*)name;
{
    NSString *path = [[NSBundle mainBundle]pathForResource:name ofType:@"sql"];
    NSError * error;
    NSString *string = [NSString stringWithContentsOfFile:path encoding:NSUnicodeStringEncoding error:&error];
    
  
    
    NSArray *tables = [string componentsSeparatedByString:@";"];

    
    FMDatabase *db = [FMDatabase databaseWithPath:m_DBPath];
    if([db open])
    {
        for (NSString *table in tables) {
            
            if([table rangeOfString:@"CREATE TABLE"].location == NSNotFound)
            {
                continue;
            }
            
            NSString *temTable = [NSString stringWithString:table];
            temTable = [[temTable componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]] componentsJoinedByString:@""];
            NSLog(@"tempTable:%@\n",temTable);
            temTable = [temTable stringByReplacingOccurrencesOfString:@"[dbo]." withString:@""];
            temTable = [temTable stringByReplacingOccurrencesOfString:@"CLUSTERED" withString:@""];
            temTable = [temTable stringByReplacingOccurrencesOfString:@"IDENTITY (1, 1)" withString:@""];
            NSLog(@"tempTable2:%@\n",temTable);
            
            BOOL res = [db executeUpdate:temTable];
            
            if (!res) {
                NSLog(@"fail to creating db table:\n%@",table);
            } else {
                NSLog(@"succ to creating db table");
            }
        }
    }
    
    [db close];
}
- (NSDictionary *)getTablesInfoFromFile:(NSString*)fileName;
{
    //找到表结构sql文件
    NSString *path = [[NSBundle mainBundle]pathForResource:fileName ofType:@"sql"];
    NSString *string = [NSString stringWithContentsOfFile:path encoding:NSUnicodeStringEncoding error:nil];

    //拆分各个table
    NSArray *tablesArray = [string componentsSeparatedByString:@";"];
 
    //最终拆分好的table name
    NSMutableArray * tablesNameArray = [[NSMutableArray alloc]init];
    //存储各个table里面的属性 (value for key tablesNameArray里面的值得到各个表里面的数据)
    NSMutableDictionary * tablesDic = [[NSMutableDictionary alloc]init];
    
    for (int i = 0; i < [tablesArray count]-1; i++) {
        //拆分出表中的各行属性
        NSArray * propertysArray = [[tablesArray objectAtIndex:i] componentsSeparatedByString:@"NULL"];
        NSMutableArray * propertysMutableArray = [[NSMutableArray alloc]initWithArray:propertysArray];
        [propertysMutableArray removeLastObject];
        
        //拆分出表明
        NSInteger leftPos = [[propertysMutableArray objectAtIndex:0] rangeOfString:@".["].location ;
        NSInteger rightPos = [[propertysMutableArray objectAtIndex:0] rangeOfString:@"]("].location ;
        NSString * tableName = [[propertysMutableArray objectAtIndex:0] substringToIndex:rightPos];
        tableName = [tableName substringFromIndex:leftPos+2];
        
        [tablesNameArray addObject:tableName];
        
        //拆分出各个属性
        NSMutableArray * attributesArray = [[NSMutableArray alloc]init];
        for (int i = 0; i < [propertysMutableArray count]; i++) {
            if (i == 0) {
                NSArray * array = [[propertysMutableArray objectAtIndex:i] componentsSeparatedByString:@"["];
                NSString *attribute = [array objectAtIndex:3];
                NSInteger rightPos = [attribute rangeOfString:@"]"].location ;
                attribute = [attribute substringToIndex:rightPos];
                [attributesArray addObject:attribute];
            }
            else if (i >= 1){
                
                NSInteger leftPos = [[propertysMutableArray objectAtIndex:i] rangeOfString:@"["].location ;
                NSInteger rightPos = [[propertysMutableArray objectAtIndex:i] rangeOfString:@"]"].location ;
                NSString * attribute = [[propertysMutableArray objectAtIndex:i] substringToIndex:rightPos];
                attribute = [attribute substringFromIndex:leftPos+1];
                [attributesArray addObject:attribute];
            }
        }
        [tablesDic setValue:attributesArray forKey:tableName];
    }
    
    NSDictionary * returnDic = [[NSDictionary alloc]initWithObjectsAndKeys:tablesNameArray,@"tablesNameArray",tablesDic,@"tablesDic", nil];
    return returnDic;
}

#pragma mark - insert

- (BOOL)insertIntoTable:(NSString *)table Data:(NSDictionary *)dataDic
{
    NSDictionary * tableInfoDic = [self getTablesInfoFromFile:@"tables"];
    NSDictionary * tablesDic = [[NSDictionary alloc]initWithDictionary:[tableInfoDic valueForKey:@"tablesDic"]];
    
    NSArray * currentTableAttributesArray = [tablesDic valueForKey:table];
    
    NSString *sqlKey = [NSString string];
    NSString *sqlValue = [NSString string];
    
    for (int i = 0; i < [currentTableAttributesArray count]; i++) {
        
        NSString * keyStr = [NSString stringWithFormat:@"%@",[currentTableAttributesArray objectAtIndex:i]];
        NSString * valueStr = [NSString stringWithFormat:@"%@",[dataDic valueForKey:[currentTableAttributesArray objectAtIndex:i]]];
        
        //替换content里面单引号
        if ([keyStr isEqualToString:@"messageContent"]) {
            valueStr = [valueStr stringByReplacingOccurrencesOfString:@"'" withString:@"''"];
        }
        
        if (i != [currentTableAttributesArray count] - 1) {
            sqlKey = [sqlKey stringByAppendingFormat:@"%@,",keyStr];
            sqlValue = [sqlValue stringByAppendingFormat:@"'%@',",valueStr];
            
        } else {
            sqlKey = [sqlKey stringByAppendingFormat:@"%@",keyStr];
            sqlValue = [sqlValue stringByAppendingFormat:@"'%@'",valueStr];
        }
        
    }
    sqlKey = [sqlKey stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    FMDatabase * db = [FMDatabase databaseWithPath:m_DBPath];
    
    BOOL res = false;
    if ([db open]) {
        
        NSString * sql = [NSString stringWithFormat:@"insert into %@ (%@) values(%@) ",table,sqlKey,sqlValue];
        NSLog(@"FMDB:------------insert sql:%@",sql);
        
        res = [db executeUpdate:sql];
        if (!res) {
            NSLog(@"error to insert data to %@",table);
        } else {
            NSLog(@"succ to insert data to %@",table);
        }
        [db close];
    }
    return res;
}

@end
