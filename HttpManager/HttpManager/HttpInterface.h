//
//  HttpInterface.h
//  examples
//
//  Created by lv on 2017/8/16.
//  Copyright © 2017年 bdl. All rights reserved.
//

#import <Foundation/Foundation.h>




/**
 所有接口的枚举
 */
typedef NS_ENUM(NSInteger, InterfaceNum) {
   
    GetPayType ,
    //轮播图
    GetBanner,
    
    //登录
    Login,
    
    //分类列表
    CategoryList,
    
    //商品列表
    ProductList,
    
    //商品详情
    ProductDetail,


    
    //添加到购物车
    CartAdd ,
    
    //购物车列表
    CartList ,
    
    //修改购物车
    CartUpdate ,
    
    //删除购物车
    CartDelete ,
    
    //购物车全选
    CartSelect ,
    
    

    //地区列表
    AddressAreaList ,
    
    //添加收货地址
    AddressAdd ,
    
    //更新收货地址
    AddressUpdate ,
    
    //收货地址列表
    AddressList ,
    
    //删除收货地址
    AddressDelete ,
    
    

    //获取个人资料
    UserInfo ,
    
    //更新用户资料
    UserUpdate ,
    
    //退出登出
    UserLogout ,
    
    //更新用户密码
    UserUpdatePsw ,
    
    //获取七牛云token
    UserGetQnToken ,
    
    //添加评论
    UserAddComment ,

    
    //订单直接购买
    OrderSure ,
    //订单购物车购买
    OrderSureCar ,
    //下订单-直接购买
    Order ,
    //下订单-购物车购买
    OrderCart ,
    //订单列表
    OrderList ,
    //订单详情
    OrderInfo ,
    //申请售后
    OrderRefundItemAdd ,
    //售后列表
    OrderRefundItemList ,
    //取消订单
    OrderCancel ,
    //确认订单（确认收货）
    OrderReceiptR ,
    //下载订单
    OrderDown ,
    //支付
    OrderPay ,
    
    //获取账户余额信息
    UserGetAccount ,
    //获取积分变动列表
    UserGetBalance ,
    //转发商品添加积分
    UserBalanceAdd ,
    
    
    //分享品牌列表
    ShareBrandList ,

    //分享商品列表
    ShareGoodsList ,

    
    
    //消息列表
    MessageList ,
    //消息阅读
    MessageRead ,
    //未读消息数量
    MessageNumber ,

};

@interface HttpInterface : NSObject


/**
 获取接口地址

 @param interface 接口枚举值
 @param Id id，restful规范下用得到
 @return 接口地址
 */
+ (NSString *)getInterface:(InterfaceNum)interface id:(NSString *)Id;

+ (NSString *)getInterface:(InterfaceNum)interface;

@end
