//
//  ViewController.m
//  仿SDWebImage
//
//  Created by caesar on 2017/6/23.
//  Copyright © 2017年 caesar. All rights reserved.
//
#import "NWDownloadImageOperation.h"
#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    NSOperationQueue *qq = [NSOperationQueue new];
    
    NSString *URLString = @"http://paper.taizhou.com.cn/tzwb/res/1/2/2015-01/20/12/res03_attpic_brief.jpg";
    
    NWDownloadImageOperation *op = [NWDownloadImageOperation downLoadOperationWithURLString:URLString finishedBlock:^(UIImage *image) {
        NSLog(@"%@ %@",image,[NSThread currentThread]);
    }];
    
    [qq addOperation:op];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
