//
//  NWWebImageManager.m
//  仿SDWebImage
//
//  Created by caesar on 2017/6/23.
//  Copyright © 2017年 caesar. All rights reserved.
//

#import "NWWebImageManager.h"
#import "NWDownloadImageOperation.h"
@interface NWWebImageManager()
@property (nonatomic,strong) NSMutableDictionary *opCache;
@property (nonatomic,strong) NSOperationQueue *qq;
@end

@implementation NWWebImageManager

+(instancetype)sharedManager{
    static id instanc;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instanc = [self new];
    });
    return instanc;
}

-(instancetype)init{
    if (self=[super init]) {
        
        self.opCache = [NSMutableDictionary new];
        self.qq = [NSOperationQueue new];
        
    }
    return self;
}

-(void)downloadImageWithURLString:(NSString *)URLString completion:(void (^)(UIImage *image))completionBlock{
    
    if ([self.opCache objectForKey:URLString] != nil) {
        return;
    }
    
    NWDownloadImageOperation *op = [NWDownloadImageOperation downLoadOperationWithURLString:URLString finishedBlock:^(UIImage *image) {
        //回调VC控制器
        if (completionBlock != nil) {
            completionBlock(image);
        }
        
        //图片下载结束时,移除opCache中得op
        [self.opCache removeObjectForKey:URLString];
    }];
    
    [self.opCache setObject:op forKey:URLString];
    
    [self.qq addOperation:op];
}

-(void)cancelLastOperation:(NSString *)lastURLString{
    
    NWDownloadImageOperation *lastOP = [self.opCache objectForKey:lastURLString];
    [lastOP cancel];
    
    //删除操作
    [self.opCache removeObjectForKey:lastURLString];
}
@end
