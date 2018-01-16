/**
 * HttpManager.h
 * Create at 2015-9-16
 * Created by Lv
 * Copyright (c) 2015 SHANGHAI VOLKSWAGEN, All rights reserved.
 */



#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "BaseModel.h"
#import "HttpConfig.h"
#import "HttpInterface.h"

//返回的数据data部分的数据类型
typedef enum : NSUInteger {
    
    ResponseDataTypeDic = 1,
    ResponseDataTypeArr = 2,

} ResponseDataType;

//服务器响应码
typedef enum : NSUInteger {
    
    //成功
    ResponseCodeSuccess = 200,
    
    //重新登录
    ResponseCodeSignOut = 900,
    
    //服务器错误
    ResponseCodeServerError = 404,
    
    //网络错误
    ResponseCodeNetError = 0,
    
    //接口逻辑错误
    ResponseCodeAPIError,
    
} ResponseCode;


/**
 请求成功回调

 @param responseData 响应数据部分
 @param msg 服务器给的提示或者错误描述
 */
typedef void (^RequestSuccessBlock)(id responseData, NSString *msg);

/**
 请求错误回调
 
 @param responseData 响应数据部分
 @param code 响应码
 @param msg 服务器给的提示或者错误描述
 */
typedef void (^RequestErrorBlock)(id responseData, ResponseCode code, NSString *msg);


typedef void (^DownSuccessBlock)(NSURL *path);
typedef void (^DownErrorBlock)(NSError *error);

static  NSString * UserExpiredNotification = @"UserExpiredNotification";

@interface HttpManager : NSObject


/**
 model类，
 ResponseDataType为ResponseDataTypeDic时，若有此字段则解析为modelClass对象，否则返回字典。
 ResponseDataType为ResponseDataTypeArr时，若有此字段则解析数组里面的dic为modelClass对象，否则返回数组。
 */
@property(nonatomic, strong)Class modelClass;


/**
 期待的返回数据类型，为空则返回data字典
 */
@property(nonatomic, assign)ResponseDataType dataType;


/**
 收到退出登录错误时回调
 */
@property(nonatomic, copy)SignOutBlock signOut;

@property(nonatomic, strong)id responseObject;

/**
 Get请求
 
 @param dic 参数
 @param interface 接口名字
 @param success 成功回调
 @param error 错误回调
 */
-(void)getRequest:(NSMutableDictionary *)dic interface:(NSInteger)interface success:(RequestSuccessBlock)success error:(RequestErrorBlock)error;

/**
 Get请求
 
 @param dic 参数
 @param header header参数
 @param interface 接口名字
 @param success 成功回调
 @param error 错误回调
 */
-(void)getRequest:(NSMutableDictionary *)dic header:(NSMutableDictionary *)header interface:(NSInteger)interface success:(RequestSuccessBlock)success error:(RequestErrorBlock)error;

/**
 Get请求
 
 @param dic 参数
 @param header header参数
 @param ID 遵循restful规范时使用
 @param interface 接口名字
 @param success 成功回调
 @param error 错误回调
 */
-(void)getRequest:(NSMutableDictionary *)dic header:(NSMutableDictionary *)header id:(NSString *)ID interface:(NSInteger)interface success:(RequestSuccessBlock)success error:(RequestErrorBlock)error;


/**
 Post请求
 
 @param dic 参数
 @param interface 接口名字
 @param success 成功回调
 @param error 错误回调
 */
-(void)postRequestWithDic:(NSMutableDictionary *)dic interface:(NSInteger)interface success:(RequestSuccessBlock)success error:(RequestErrorBlock)error;

/**
 Post请求
 
 @param dic 参数
 @param header header参数
 @param interface 接口名字
 @param success 成功回调
 @param error 错误回调
 */
-(void)postRequestWithDic:(NSMutableDictionary *)dic header:(NSMutableDictionary *)header interface:(NSInteger)interface success:(RequestSuccessBlock)success error:(RequestErrorBlock)error;

/**
 Post请求
 
 @param dic 参数
 @param header header参数
 @param ID 遵循restful规范时使用
 @param interface 接口名字
 @param success 成功回调
 @param error 错误回调
 */
-(void)postRequestWithDic:(NSMutableDictionary *)dic header:(NSMutableDictionary *)header id:(NSString *)ID interface:(NSInteger)interface success:(RequestSuccessBlock)success error:(RequestErrorBlock)error;

/**
 Put请求
 
 @param dic 参数
 @param header header参数
 @param interface 接口名字
 @param success 成功回调
 @param error 错误回调
 */
-(void)putRequestWithDic:(NSMutableDictionary *)dic header:(NSMutableDictionary *)header interface:(NSInteger)interface success:(RequestSuccessBlock)success error:(RequestErrorBlock)error ;

/**
 Put请求
 
 @param dic 参数
 @param header header参数
 @param ID 遵循restful规范时使用
 @param interface 接口名字
 @param success 成功回调
 @param error 错误回调
 */
-(void)putRequestWithDic:(NSMutableDictionary *)dic header:(NSMutableDictionary *)header id:(NSString *)ID interface:(NSInteger)interface success:(RequestSuccessBlock)success error:(RequestErrorBlock)error;

/**
 Delete请求
 
 @param dic 参数
 @param header header参数
 @param ID 遵循restful规范时使用
 @param interface 接口名字
 @param success 成功回调
 @param error 错误回调
 */
-(void)deleteRequest:(NSMutableDictionary *)dic header:(NSMutableDictionary *)header id:(NSString *)ID interface:(NSInteger)interface success:(RequestSuccessBlock)success error:(RequestErrorBlock)error;


/**
 下载文件

 @param url 地址
 @param successBlock 成功
 @param failBlock 失败
 */
+(void)down:(NSString *)url success:(DownSuccessBlock)successBlock fail:(DownErrorBlock)failBlock;

@end
