//
//  NWWebImageManager.m
//  仿SDWebImage
//
//  Created by caesar on 2017/6/23.
//  Copyright © 2017年 caesar. All rights reserved.
//

#import "NWWebImageManager.h"
#import "NWDownloadImageOperation.h"
#import "NSString+DirectoryPath.h"
@interface NWWebImageManager()
@property (nonatomic,strong) NSMutableDictionary *opCache;
@property (nonatomic,strong) NSOperationQueue *qq;
@property (nonatomic,strong) NSCache *imageCache;
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
        self.imageCache = [NSCache new];
        
        //注册内存警告
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(clearCache) name:UIApplicationDidReceiveMemoryWarningNotification object:nil];
    }
    return self;
}
#pragma mark
#pragma mark -接收内存警告清理内存
-(void)clearCache{
    //正中操作可能会使NSCache失效
    [self.imageCache removeAllObjects];
}
#pragma mark
#pragma mark -创建方法检测内存中是否存有图片
-(BOOL)checkImageCacheWith:(NSString *)urlString{
    if ([self.imageCache objectForKey:urlString]) {
        NSLog(@"从内存中加载... ");
        return YES;
    }
    UIImage *sandboxImage = [UIImage imageWithContentsOfFile:[urlString getDirectoryPath]];
    if (sandboxImage != nil) {
        NSLog(@"从沙盒中加载... ");
        [self.imageCache setObject:sandboxImage forKey:urlString];
        return YES;
    }
    return NO;
}

#pragma mark
#pragma mark -下载图片,调用Operation
-(void)downloadImageWithURLString:(NSString *)URLString completion:(void (^)(UIImage *image))completionBlock{
    
    //判断图片是否在缓存之中,是的话赋值,不是下载
    if ([self checkImageCacheWith:URLString]) {
        if (completionBlock != nil) {
            completionBlock([self.imageCache objectForKey:URLString]);
            return;
        }
    }
    
    if ([self.opCache objectForKey:URLString] != nil) {
        return;
    }
    
    NWDownloadImageOperation *op = [NWDownloadImageOperation downLoadOperationWithURLString:URLString finishedBlock:^(UIImage *image) {
        //回调VC控制器
        if (completionBlock != nil) {
            completionBlock(image);
        }
        
        
        if (image != nil) {
            [self.imageCache setObject:image forKey:URLString];
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
