//
//  UIImageView+WebImage.h
//  仿SDWebImage
//
//  Created by caesar on 2017/6/25.
//  Copyright © 2017年 caesar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NWWebImageManager.h"
@interface UIImageView (WebImage)
@property (nonatomic,copy) NSString *lastUrl;

-(void)nw_setImageWithURL:(NSString *)URLString;
@end
