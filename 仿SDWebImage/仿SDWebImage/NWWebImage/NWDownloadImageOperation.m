//
//  NWDownloadImageOperation.m
//  仿SDWebImage
//
//  Created by caesar on 2017/6/23.
//  Copyright © 2017年 caesar. All rights reserved.
//

#import "NWDownloadImageOperation.h"
@interface NWDownloadImageOperation()
@property (nonatomic,copy) NSString *URLString;
@property (nonatomic,copy) void(^finishedBlock)(UIImage *);
@end
@implementation NWDownloadImageOperation
//定义对象方法实例化对像并传入参数
+(instancetype)downLoadOperationWithURLString:(NSString *)URLString finishedBlock:(void (^)(UIImage *))finishBlock{
    NWDownloadImageOperation *op = [NWDownloadImageOperation new];
    op.URLString = URLString;
    op.finishedBlock = finishBlock;
    return op;
}

-(void)main{
    NSLog(@"传入的URL=%@",self.URLString);
    
    NSURL *url = [NSURL URLWithString:self.URLString];
    NSData *data = [NSData dataWithContentsOfURL:url];
    UIImage *image = [UIImage imageWithData:data];
    
    //回调主线程刷新数据
    if (self.finishedBlock != nil) {
        [[NSOperationQueue mainQueue]addOperationWithBlock:^{
            self.finishedBlock(image);
        }];
    }

}
@end
