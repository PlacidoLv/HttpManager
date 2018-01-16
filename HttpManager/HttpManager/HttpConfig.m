//
//  HttpConfig.m
//  examples
//
//  Created by lv on 2017/8/16.
//  Copyright © 2017年 bdl. All rights reserved.
//

#import "HttpConfig.h"

@implementation HttpConfig


+ (HttpConfig *)share
{
    static HttpConfig *config = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        config = [[self alloc] init];
    });
    return config;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.isShowLog = YES;
        self.timeOut = 20;
        self.dicBase = [NSMutableDictionary dictionaryWithCapacity:0];
        self.baseHost = @"http://i-lv.cn:8081/api";
    }
    return self;
}


@end
