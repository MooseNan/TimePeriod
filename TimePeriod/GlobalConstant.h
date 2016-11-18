//
//  GlobalConstant.h
//  TimePeriod
//
//  Created by dhc1256436519 on 16/4/16.
//  Copyright © 2016年 dhc1256436519. All rights reserved.
//

#ifndef GlobalConstant_h
#define GlobalConstant_h
#define IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define IS_RETINA ([[UIScreen mainScreen] scale] >= 2.0)

#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)
#define SCREEN_MAX_LENGTH (MAX(SCREEN_WIDTH, SCREEN_HEIGHT))
#define SCREEN_MIN_LENGTH (MIN(SCREEN_WIDTH, SCREEN_HEIGHT))

#define IS_IPHONE_4_OR_LESS (IS_IPHONE && SCREEN_MAX_LENGTH < 568.0)
#define IS_IPHONE_5 (IS_IPHONE && SCREEN_MAX_LENGTH == 568.0)
#define IS_IPHONE_6 (IS_IPHONE && SCREEN_MAX_LENGTH == 667.0)
#define IS_IPHONE_6P (IS_IPHONE && SCREEN_MAX_LENGTH == 736.0)

#define IOS_VERSION_8 (([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)? (YES):(NO))
#define PATH_OF_DOCUMENT    [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]
static NSString *const TServerBaseURL =@"http://www.timestold.com/TimeAPI/";
static NSString *const TclientLogin = @"user/login";
static NSString *const TclientRegister=@"user/register";
static NSString *const TclientMainList=@"shop/getArticleList";
static NSString *const TclinetGetDetail=@"shop/getArticleDetail";
static NSString *const TclinetGetNearShop=@"shop/getArtNear";
static NSString *const TclinetGetCoupList=@"shop/getCoupList";
static NSString *const TclientGetDiscount =@"shop/getCoup";

#endif /* GlobalConstant_h */
