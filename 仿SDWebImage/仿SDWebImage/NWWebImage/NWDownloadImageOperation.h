//
//  NWDownloadImageOperation.h
//  仿SDWebImage
//
//  Created by caesar on 2017/6/23.
//  Copyright © 2017年 caesar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface NWDownloadImageOperation : NSOperation
+(instancetype)downLoadOperationWithURLString:(NSString *)URLString finishedBlock:(void(^)(UIImage *))finishBlock;
@end
