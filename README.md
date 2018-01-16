# HttpManager
基于AFNetworking封装的网络请求

示例：
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
