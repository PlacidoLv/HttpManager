# HttpManager
基于AFNetworking封装的网络请求

利用YYModel，将返回参数自动解析问对应的model，或者model数组。

示例，获取付款方式列表：
```
HttpManager *http = [[HttpManager alloc] init];
http.dataType = ResponseDataTypeArr;
http.modelClass = [TestModel class];
[http getRequest:nil interface:GetPayType success:^(id responseData, NSString *msg) {
        
        NSArray<TestModel *> *arrModel = responseData;
        NSLog(@"responseData = %@", arrModel);
        
  } error:^(id responseData, ResponseCode code, NSString *msg) {
        
 }];
```    

#### 1. HttpManager：用于请求接口；
使用示例，获取bannder列表：
```
HttpManager *http = [[HttpManager alloc] init];
http.dataType = ResponseDataTypeArr;
http.modelClass = [TestModel class];
[http getRequest:nil header:nil interface:InterfaceBanner success:^(id responseData, NSString *msg) {

NSArray<TestModel *> *arrModel = responseData;
NSLog(@"responseData = %@", arrModel);


} error:^(id responseData, ResponseCode code, NSString *msg) {
//接口错误，可能是接口报错，或者是网络有问题，可以根据ResponseCode判断。
}];
```
dataType属性表明期待的返回数据类型，
modelClass属性表明需要解析的model。两者配合来获取解析好的model对象或者model对象数组。
```
/**
model类，
ResponseDataType为ResponseDataTypeDic时，若有此字段则解析为modelClass对象，否则返回字典。
ResponseDataType为ResponseDataTypeArr时，若有此字段则解析数组里面的dic为modelClass对象，否则返回数组。
*/
@property(nonatomic, strong)Class modelClass;;


/**
期待的返回数据类型，为空则返回data字典
*/
@property(nonatomic, assign)ResponseDataType dataType;
```
主要方法：
```
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
@param header header参数
@param ID 遵循restful规范时使用
@param interface 接口名字
@param success 成功回调
@param error 错误回调
*/
-(void)postRequestWithDic:(NSMutableDictionary *)dic header:(NSMutableDictionary *)header id:(NSString *)ID interface:(NSInteger)interface success:(RequestSuccessBlock)success error:(RequestErrorBlock)error;

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
```

#### 2. HttpInterface：用于获取接口具体地址，方法```+ (NSString *)getInterface:(InterfaceNum)interface id:(NSString *)Id```；

```
/**
所有接口的枚举
*/
typedef NS_ENUM(NSInteger, InterfaceNum) {

//获取广告包
InterfaceBanner = 0 ,

//产品列表
InterfaceProductList = 1 ,

//产品详情
InterfaceProductDetail = 2 ,
};

```
```
/**
获取接口地址

@param interface 接口枚举值
@param Id id，restful规范下用得到
@return 接口地址
*/
+ (NSString *)getInterface:(InterfaceNum)interface id:(NSString *)Id
{
NSString *strURL=nil;

switch (interface)
{

case 0: //广告包
{
strURL = GET_URL(@"banners");

} break;
case 1: //列表
{
strURL = GET_URL(@"productList");

} break;
case 2: //详情
{
strURL = GET_URL(@"productDetail");

} break;
default:
break;
}


return strURL;
}

```
#### 3. HttpConfig：单利类，用于配置基本属性，超时时间，服务器地址等；

```
/**
服务器地址
*/
@property(nonatomic, strong)NSString *baseHost;


/**
请求超时时间
*/
@property(nonatomic, assign)NSInteger timeOut;

/**
基础请求参数
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
```
