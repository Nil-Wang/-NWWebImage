//
//  UIImageView+WebImage.m
//  仿SDWebImage
//
//  Created by caesar on 2017/6/25.
//  Copyright © 2017年 caesar. All rights reserved.
//

#import "UIImageView+WebImage.h"
#import <objc/runtime.h>
@implementation UIImageView (WebImage)

-(NSString *)lastUrl{
    return objc_getAssociatedObject(self, "key");
}
-(void)setLastUrl:(NSString *)lastUrl{
    objc_setAssociatedObject(self, "key", lastUrl, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

-(void)nw_setImageWithURL:(NSString *)URLString{
    //判断如果连续点击取消上一次点击下载的操作
    if (![URLString isEqualToString:self.lastUrl] && self.lastUrl != nil) {
        // 单例接管取消操作
        [[NWWebImageManager sharedManager] cancelLastOperation:self.lastUrl];
    }
    //为lastURL赋值
    self.lastUrl = URLString;
    
    [[NWWebImageManager sharedManager]downloadImageWithURLString:URLString completion:^(UIImage *image) {
        self.image = image;
    }];
}
@end
