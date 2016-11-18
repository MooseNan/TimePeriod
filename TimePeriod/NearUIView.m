//
//  NearUIView.m
//  TimePeriod
//
//  Created by dhc1256436519 on 16/4/19.
//  Copyright © 2016年 dhc1256436519. All rights reserved.
//

#import "NearUIView.h"
#import "Masonry.h"
@implementation NearUIView
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initialize];
    }
    return self;
}
- (void)initialize {
    self.layer.doubleSided = NO;
    
    self.image = [[UIImageView alloc] init];
    self.image.backgroundColor = [UIColor clearColor];
   // self.image.contentMode = UIViewContentModeCenter;
   // self.image.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    self.name = [[UILabel alloc] init];
    self.name.font = [UIFont fontWithName:@"Helvetica Neue" size:10];
    self.name.textAlignment = NSTextAlignmentCenter;
    
    [self addSubview:self.image];
    [self addSubview:self.name];
    
    [_image mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(12);
        // make.right.equalTo(self).offset(-20);
        make.width.mas_equalTo(105);
        make.top.equalTo(self).offset(5);
        make.height.mas_equalTo(60);
        //make.width.equalTo(self).mas_lessThanOrEqualTo
        //make.bottom.equalTo(_name.mas_top).offset(-5);
    }];
    
    [_name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(12);
        make.right.equalTo(self).offset(-20);
        //make.left.right.equalTo(self);
        make.top.equalTo(_image.mas_bottom).offset(5);
        //make.bottom.equalTo(self).offset(-5);
    }];
}

@end
