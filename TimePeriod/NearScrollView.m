//
//  NearScrollView.m
//  TimePeriod
//
//  Created by dhc1256436519 on 16/4/18.
//  Copyright © 2016年 dhc1256436519. All rights reserved.
//

#import "NearScrollView.h"
#import "NearUIView.h"
#import "GlobalConstant.h"
#import "NearShopModel.h"
#import "UIImageView+AFNetworking.h"
#import "NearShopModel.h"
#define defaultWidth  (SCREEN_WIDTH/3)
#define defaultPace 0//默认间距
@interface NearScrollView (){
    UILabel *nearLabel;
}

@end
@implementation NearScrollView

-(id)initWithFrame:(CGRect)frame
{

    self =  [super initWithFrame:frame];
    self.backgroundColor = [UIColor whiteColor];
    self.scrollEnabled = YES;
    self.directionalLockEnabled = YES;
    self.showsVerticalScrollIndicator = NO;
    self.alwaysBounceHorizontal = YES;
    self.indicatorStyle = UIScrollViewIndicatorStyleDefault;
    [self setShowsHorizontalScrollIndicator:NO];
    self.contentSize = [self contentSizeForUIScrollView:(10)];
    [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectView:)]];
    return self;
}

-(void)loadData
{
    for (int i=0; i<[self.arrNear count]; i++) {
        CGFloat x = (i) * (defaultPace + defaultWidth) + defaultPace;
        NearUIView *near=[[NearUIView alloc]initWithFrame:CGRectMake(x, 0, defaultWidth, self.bounds.size.height)];
        NSError *error;
        NearShopModel *model = [[NearShopModel alloc]initWithDictionary:[self.arrNear objectAtIndex:i] error:&error];
        NSString *imgName = model.imgThumbnail;
        NSURL *imgURL = [NSURL URLWithString:imgName];
        [near.image setImageWithURL:imgURL];
        near.name.text=model.shopName;
        [self addSubview:near];
        
       
    }

}
-(void)selectView:(UITapGestureRecognizer*)ges
{
    CGPoint point = [ges locationInView:ges.view];
    int index = point.x/defaultWidth;
    
    NSError *error;
    NearShopModel *model = [[NearShopModel alloc]initWithDictionary:[self.arrNear objectAtIndex:index] error:&error];
    NSNumber *num = [NSNumber numberWithInteger:model.rticleaID];
    NSUserDefaults *userDefault=[NSUserDefaults standardUserDefaults];
    [userDefault setObject:num forKey:@"nearShopID"];
    [userDefault synchronize];
    
    
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    
}
- (CGSize)contentSizeForUIScrollView:(int)index
{
    float width = (defaultPace + defaultWidth) * index;
    if (width < self.bounds.size.width)
        width = self.bounds.size.width;
    return CGSizeMake(width, 0);
}
@end
