//
//  HttpConfig.h
//  examples
//
//  Created by lv on 2017/8/16.
//  Copyright © 2017年 bdl. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 退出登录block
 
 */
typedef void (^SignOutBlock)(void);


@interface HttpConfig : NSObject


/**
 服务器地址
 */
@property(nonatomic, strong)NSString *baseHost;


/**
 请求超时时间
 */
@property(nonatomic, assign)NSInteger timeOut;

/**
 基础请求参数，定位，平台类型，设备id之类的
 */
@property(nonatomic, strong)NSMutableDictionary *dicBase;

/**
 打印请求信息，默认YES
 */
@property(nonatomic, assign)BOOL isShowLog;


/**
 收到退出登录错误时回调，通用
 */
@property(nonatomic, copy)SignOutBlock signOut;


+ (HttpConfig *)share;


@end
