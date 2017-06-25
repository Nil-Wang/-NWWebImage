//
//  NSString+DirectoryPath.m
//  仿SDWebImage
//
//  Created by caesar on 2017/6/25.
//  Copyright © 2017年 caesar. All rights reserved.
//

#import "NSString+DirectoryPath.h"

@implementation NSString (DirectoryPath)
-(NSString *)getDirectoryPath{
    NSString *path = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).lastObject;
    NSString *name = [self md5String];
    NSString *dPath = [path stringByAppendingPathComponent:name];
    return dPath;
}
@end
