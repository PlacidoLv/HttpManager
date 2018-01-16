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
