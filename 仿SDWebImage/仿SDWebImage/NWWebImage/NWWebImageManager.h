//
//  NWWebImageManager.h
//  仿SDWebImage
//
//  Created by caesar on 2017/6/23.
//  Copyright © 2017年 caesar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "NWDownloadImageOperation.h"

@interface NWWebImageManager : NSObject
+(instancetype)sharedManager;

- (void)downloadImageWithURLString:(NSString *)URLString completion:(void(^)(UIImage *image))completionBlock;

-(void)cancelLastOperation:(NSString *)lastURLString;
@end
