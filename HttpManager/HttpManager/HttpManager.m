/**
 * HttpManager.m
 * Create at 2015-9-16
 * Created by Lv
 * Copyright (c) 2015 SHANGHAI VOLKSWAGEN, All rights reserved.
 */
//$(PRODUCT_MODULE_NAME)

#import "HttpManager.h"
#import "AFNetworking.h"
#import "Reachability.h"
#import "BaseModel.h"
#import <YYKit/YYKit.h>


@interface HttpManager ()

@end

@implementation HttpManager



/**
 Get请求
 
 @param dic 参数
 @param interface 接口名字
 @param success 成功回调
 @param error 错误回调
 */
-(void)getRequest:(NSMutableDictionary *)dic interface:(NSInteger)interface success:(RequestSuccessBlock)success error:(RequestErrorBlock)error
{
    [self getRequest:dic header:nil id:nil interface:interface success:success error:error];
}


/**
 Get请求
 
 @param dic 参数
 @param header header参数
 @param interface 接口名字
 @param success 成功回调
 @param error 错误回调
 */
-(void)getRequest:(NSMutableDictionary *)dic header:(NSMutableDictionary *)header interface:(NSInteger)interface success:(RequestSuccessBlock)success error:(RequestErrorBlock)error
{
    [self getRequest:dic header:header id:nil interface:interface success:success error:error];
}

/**
 Get请求

 @param dic 参数
 @param header header参数
 @param ID 遵循restful规范时使用
 @param interface 接口名字
 @param success 成功回调
 @param error 错误回调
 */
-(void)getRequest:(NSMutableDictionary *)dic header:(NSMutableDictionary *)header id:(NSString *)ID interface:(NSInteger)interface success:(RequestSuccessBlock)success error:(RequestErrorBlock)error
{
    
    if (dic==nil)
    {
       dic=[NSMutableDictionary dictionaryWithCapacity:0];
    }
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer.timeoutInterval = [HttpConfig share].timeOut;
    manager.requestSerializer.cachePolicy = NSURLRequestReloadIgnoringCacheData;
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/html", nil];

    NSDictionary *dicBase = [HttpConfig share].dicBase;
    
    [dicBase enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        [manager.requestSerializer setValue:[NSString stringWithFormat:@"%@",obj] forHTTPHeaderField:key];
    }];
    
    [header enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
         [manager.requestSerializer setValue:[NSString stringWithFormat:@"%@",obj] forHTTPHeaderField:key];
    }];
    
    

    
    __block NSString *strURL = [HttpInterface getInterface:interface id:ID];
    if (dic.allKeys.count>0)
    {
        strURL=[NSString stringWithFormat:@"%@?",strURL];
        [dic.allKeys enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            if (idx==0)
            {
                strURL=[NSString stringWithFormat:@"%@%@=%@",strURL,obj,[dic objectForKey:obj]];
            }
            else
            {
                strURL=[NSString stringWithFormat:@"%@&%@=%@",strURL,obj,[dic objectForKey:obj]];
            }
            
        }];
    }


    strURL = [strURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    NSDate *dateStart = [NSDate date];
    
    [manager GET:strURL parameters:dic progress:^(NSProgress * _Nonnull downloadProgress) {
        
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if ([HttpConfig share].isShowLog) {
            
            NSLog(@"\nGet \n time = %g, \nurl = %@, \ndic = %@,  \nheader = %@, \nHTTPRequestHeaders = %@, \nresponseObject = %@",  [[NSDate date] timeIntervalSinceDate:dateStart], strURL, dic, header, manager.requestSerializer.HTTPRequestHeaders, responseObject);
        }
        
        [self successOption:responseObject success:success error:error];

        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull errorAF) {
        
        if ([HttpConfig share].isShowLog) {
            
            NSLog(@"\nGet \n time = %g, \nurl = %@, \ndic = %@,  \nheader = %@, \nerrorCode = %zd, \nerror = %@", [[NSDate date] timeIntervalSinceDate:dateStart],strURL, dic, header, [errorAF code], [errorAF localizedDescription]);
        }

        [self failureOption:errorAF error:error];

    }];
}



/**
 Post请求
 
 @param dic 参数
 @param interface 接口名字
 @param success 成功回调
 @param error 错误回调
 */
-(void)postRequestWithDic:(NSMutableDictionary *)dic interface:(NSInteger)interface success:(RequestSuccessBlock)success error:(RequestErrorBlock)error {
    
    [self postRequestWithDic:dic header:nil id:nil interface:interface success:success error:error];
}


/**
 Post请求
 
 @param dic 参数
 @param header header参数
 @param interface 接口名字
 @param success 成功回调
 @param error 错误回调
 */
-(void)postRequestWithDic:(NSMutableDictionary *)dic header:(NSMutableDictionary *)header interface:(NSInteger)interface success:(RequestSuccessBlock)success error:(RequestErrorBlock)error
{
    [self postRequestWithDic:dic header:header id:nil interface:interface success:success error:error];
}

/**
 Post请求
 
 @param dic 参数
 @param header header参数
 @param ID 遵循restful规范时使用
 @param interface 接口名字
 @param success 成功回调
 @param error 错误回调
 */
-(void)postRequestWithDic:(NSMutableDictionary *)dic header:(NSMutableDictionary *)header id:(NSString *)ID interface:(NSInteger)interface success:(RequestSuccessBlock)success error:(RequestErrorBlock)error
{
    if (dic==nil)
    {
        dic = [NSMutableDictionary dictionaryWithCapacity:0];
    }
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.requestSerializer.cachePolicy = NSURLRequestReloadIgnoringCacheData;
    manager.requestSerializer.timeoutInterval = [HttpConfig share].timeOut;
    manager.requestSerializer.cachePolicy = NSURLRequestReloadIgnoringCacheData;
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];

    NSDictionary *dicBase = [HttpConfig share].dicBase;
    
    [dicBase enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        [manager.requestSerializer setValue:[NSString stringWithFormat:@"%@",obj] forHTTPHeaderField:key];
    }];
    
    [header enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        [manager.requestSerializer setValue:[NSString stringWithFormat:@"%@",obj] forHTTPHeaderField:key];
    }];

    NSString *strURL = [HttpInterface getInterface:interface id:ID];
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    NSDate *dateStart = [NSDate date];
    
    [manager POST:strURL parameters:dic progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                
        if ([HttpConfig share].isShowLog) {
            
            NSLog(@"\nPost \n time = %g, \nurl = %@, \ndic = %@,  \nheader = %@, \n HTTPRequestHeaders = %@ \nresponseObject = %@", [[NSDate date] timeIntervalSinceDate:dateStart], strURL, dic, header, manager.requestSerializer.HTTPRequestHeaders, responseObject);
        }
        
        [self successOption:responseObject success:success error:error];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull errorAF) {
        
        if ([HttpConfig share].isShowLog) {
            
            NSLog(@"\nPost \nurl = %@, \ndic = %@,  \nheader = %@, \nHTTPRequestHeaders=%@, \nerrorCode = %zd, \nerror = %@", strURL, dic, header, manager.requestSerializer.HTTPRequestHeaders, [errorAF code], [errorAF localizedDescription]);
        }
        
        [self failureOption:errorAF error:error];
    
    }];
}

/**
 Put请求
 
 @param dic 参数
 @param header header参数
 @param interface 接口名字
 @param success 成功回调
 @param error 错误回调
 */
-(void)putRequestWithDic:(NSMutableDictionary *)dic header:(NSMutableDictionary *)header interface:(NSInteger)interface success:(RequestSuccessBlock)success error:(RequestErrorBlock)error {
    
    [self putRequestWithDic:dic header:header id:nil interface:interface success:success error:error];
}

/**
 Put请求
 
 @param dic 参数
 @param header header参数
 @param ID 遵循restful规范时使用
 @param interface 接口名字
 @param success 成功回调
 @param error 错误回调
 */
-(void)putRequestWithDic:(NSMutableDictionary *)dic header:(NSMutableDictionary *)header id:(NSString *)ID interface:(NSInteger)interface success:(RequestSuccessBlock)success error:(RequestErrorBlock)error
{
    if (dic==nil)
    {
        dic = [NSMutableDictionary dictionaryWithCapacity:0];
    }
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.requestSerializer.cachePolicy = NSURLRequestReloadIgnoringCacheData;
    manager.requestSerializer.timeoutInterval = [HttpConfig share].timeOut;
    manager.requestSerializer.cachePolicy = NSURLRequestReloadIgnoringCacheData;
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];

    NSDictionary *dicBase = [HttpConfig share].dicBase;
    
    [dicBase enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        [manager.requestSerializer setValue:[NSString stringWithFormat:@"%@",obj] forHTTPHeaderField:key];
    }];
    
    [header enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        [manager.requestSerializer setValue:[NSString stringWithFormat:@"%@",obj] forHTTPHeaderField:key];
    }];
    
    NSString *strURL = [HttpInterface getInterface:interface id:ID];
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;

    [manager PUT:strURL parameters:dic success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if ([HttpConfig share].isShowLog) {
            
            NSLog(@"\nurl = %@, \ndic = %@,  \nheader = %@, \nresponseObject = %@", strURL, dic, header, responseObject);
        }

        [self successOption:responseObject success:success error:error];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull errorAF) {
        
        if ([HttpConfig share].isShowLog) {
            
            NSLog(@"\nurl = %@, \ndic = %@,  \nheader = %@, \nerrorCode = %zd, \nerror = %@", strURL, dic, header, [errorAF code], [errorAF localizedDescription]);
        }
        

        [self failureOption:errorAF error:error];
        
    }];
}


/**
 Delete请求
 
 @param dic 参数
 @param header header参数
 @param ID 遵循restful规范时使用
 @param interface 接口名字
 @param success 成功回调
 @param error 错误回调
 */
-(void)deleteRequest:(NSMutableDictionary *)dic header:(NSMutableDictionary *)header id:(NSString *)ID interface:(NSInteger)interface success:(RequestSuccessBlock)success error:(RequestErrorBlock)error
{
    if (dic==nil)
    {
        dic = [NSMutableDictionary dictionaryWithCapacity:0];
    }
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.requestSerializer.timeoutInterval = [HttpConfig share].timeOut;
    manager.requestSerializer.cachePolicy = NSURLRequestReloadIgnoringCacheData;
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    
    NSDictionary *dicPublic = [HttpConfig share].dicBase;
    
    [dicPublic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        [manager.requestSerializer setValue:[NSString stringWithFormat:@"%@",obj] forHTTPHeaderField:key];
    }];
    
    [header enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        [manager.requestSerializer setValue:[NSString stringWithFormat:@"%@",obj] forHTTPHeaderField:key];
    }];
    
    NSString *strURL = [HttpInterface getInterface:interface id:ID];
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;

    [manager DELETE:strURL parameters:dic success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {

        self.responseObject = responseObject;
        if ([HttpConfig share].isShowLog) {
            
            NSLog(@"\nurl = %@, \ndic = %@,  \nheader = %@, \nresponseObject = %@", strURL, dic, header, responseObject);
        }
        
        [self successOption:responseObject success:success error:error];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull errorAF) {
        
        if ([HttpConfig share].isShowLog) {
            
            NSLog(@"\nurl = %@, \ndic = %@,  \nheader = %@, \nerrorCode = %zd, \nerror = %@", strURL, dic, header, [errorAF code], [errorAF localizedDescription]);
        }
        
        [self failureOption:errorAF error:error];
        
    }];
}


/**
 请求成功的处理

 @param responseObject 数据
 @success 成功回调
 @error 错误回调
 */
-(void)successOption:(id)responseObject success:(RequestSuccessBlock)success error:(RequestErrorBlock)error {

    
    NSDictionary *dicResponse = responseObject;
    NSInteger code = [[dicResponse objectForKey:@"code"] integerValue];
    NSString *msg = [dicResponse objectForKey:@"message"];
    id data = [dicResponse objectForKey:@"data"];
    
    // 请求成功
    if (code == ResponseCodeSuccess) {
        
        if (!success) {

            return ;
        }
        
        id analysisData = [self analysisResponseData:data];
        success(analysisData, msg);
        
        return;
        
    } else {
        
        //登录过期
        if (code == ResponseCodeSignOut) {
            
            [[NSNotificationCenter defaultCenter]postNotificationName:UserExpiredNotification object:nil];
            
            //通用的处理回调
            if ([HttpConfig share].signOut) {
                
                [HttpConfig share].signOut();
            }
            
            //特有处理回调
            if (self.signOut) {
                
                self.signOut();
            }
        }
        
        if (error) {
            
            error(data, ResponseCodeSignOut, msg);
        }
        
        
    }
    
  
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}


/**
 请求失败的处理

 @param errorAF AF返回的失败原因
 @param error 失败回调
 */
-(void)failureOption:(NSError *) errorAF error:(RequestErrorBlock)error {
    
    if ([self connectedToNetwork])
    {
        if (error) {
            
            error(nil, ResponseCodeServerError, [errorAF localizedDescription]);
        }
    }
    else
    {
        if (error) {
            
            error(nil, ResponseCodeNetError, [errorAF localizedDescription]);
        }
    }
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}



/**
 解析返回数据

 @param responseData 返回的数据的data
 @return 解析后的数据
 */
-(id)analysisResponseData:(id)responseData {
    
    switch (self.dataType) {
            
        case ResponseDataTypeArr: {
            
            if (![responseData isKindOfClass:[NSArray class]]) {
                
                return nil;
            }
            
            if (self.modelClass) {
                
                return [NSArray modelArrayWithClass:self.modelClass json:[responseData jsonStringEncoded]];
                
            } else {
                
                return responseData;
            }
        }
            break;
            
        case ResponseDataTypeDic: {
            
            if (![responseData isKindOfClass:[NSDictionary class]]) {
                
                return nil;
            }
            
            
            if (self.modelClass) {
           
                if ([self.modelClass isKindOfClass:[BaseModel class]]) {
                    
                    BaseModel *model =  [self.modelClass modelWithJSON:[responseData jsonStringEncoded]];
                   
                    return model;
                }
                
            } else {
                
                return responseData;
            }
        }
            break;
            
        default:
            return responseData;
            break;
    }
    return nil;
}


+(void)down:(NSString *)url success:(DownSuccessBlock)successBlock fail:(DownErrorBlock)failBlock {
    
    //创建传话管理者
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    //下载文件
    /*
     第一个参数:请求对象
     第二个参数:progress 进度回调
     第三个参数:destination 回调(目标位置)
     有返回值
     targetPath:临时文件路径
     response:响应头信息
     第四个参数:completionHandler 下载完成后的回调
     filePath:最终的文件路径
     */
    NSURLSessionDownloadTask *download = [manager downloadTaskWithRequest:request
                                                                 progress:^(NSProgress * _Nonnull downloadProgress) {
                                                                     //下载进度
                                                                     NSLog(@"%f",1.0 * downloadProgress.completedUnitCount / downloadProgress.totalUnitCount);
                                                                 }
                                                              destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
                                                                  //保存的文件路径
                                                                  NSString *fullPath = [NSHomeDirectory() stringByAppendingPathComponent:[NSString stringWithFormat:@"tmp/%@", response.suggestedFilename]];
                                                                  return [NSURL fileURLWithPath:fullPath];
                                                                  
                                                              }
                                                        completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
                                                            
                                                            NSLog(@"%@",filePath);
                                                            
                                                            if (error) {
                                                                
                                                                if (failBlock) {
                                                                    failBlock(error);
                                                                }
                                                            } else {
                                                                if (successBlock) {
                                                                    successBlock(filePath);
                                                                }
                                                            }
                                                    
                                                        }];
    
    //执行Task
    [download resume];

}

-(NSString *)requestFailReason:(NSString *)error
{
    if ([self connectedToNetwork])
    {
       
        return @"网络连接失败";
    }
    else
    {
        return @"服务器或者网络错误";
    }
}

// 判断网络是否可以连接
-(BOOL) connectedToNetwork
{
    return [HttpManager connectedToNetwork];
    
}

// 判断网络是否可以连接
+(BOOL) connectedToNetwork
{
    Reachability *rea=[Reachability reachabilityForInternetConnection];
    
    if (rea.currentReachabilityStatus == NotReachable)
    {
        return NO;
    }
    else
    {
        return YES;
    }
}

@end
