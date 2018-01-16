//
//  ViewController.m
//  HttpManager
//
//  Created by lv on 2018/1/16.
//  Copyright © 2018年 bdl. All rights reserved.
//

#import "ViewController.h"
#import "HttpManager.h"
#import "TestModel.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    HttpManager *http = [[HttpManager alloc] init];
    http.dataType = ResponseDataTypeArr;
    http.modelClass = [TestModel class];
    [http getRequest:nil interface:GetPayType success:^(id responseData, NSString *msg) {
        
        NSArray<TestModel *> *arrModel = responseData;
        NSLog(@"responseData = %@", arrModel);
        
    } error:^(id responseData, ResponseCode code, NSString *msg) {
        
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
