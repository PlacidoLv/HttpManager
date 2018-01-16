//
//  HttpInterface.m
//  examples
//
//  Created by lv on 2017/8/16.
//  Copyright © 2017年 bdl. All rights reserved.
//

#import "HttpInterface.h"
#import "HttpConfig.h"

#define GET_URL(API)[NSString stringWithFormat:@"%@/%@", [HttpConfig share].baseHost, API]


@implementation HttpInterface

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
        case GetPayType:
        {
            strURL = GET_URL(@"payType");
            
        } break;
            
        case GetBanner:
        {
            strURL = GET_URL(@"banner");
            
        } break;
        case Login:
        {
            strURL = GET_URL(@"login");
            
        } break;
        case CategoryList:
        {
            strURL = GET_URL(@"category");
            
        } break;
        case ProductList:
        {
            strURL = GET_URL(@"productList");
            
        } break;
            
        case ProductDetail:
        {
            strURL = GET_URL(@"product");
            
        } break;
            
            
        case CartAdd:
        {
            strURL = GET_URL(@"cartAdd");
            
        } break;
            
        case CartUpdate:
        {
            strURL = GET_URL(@"cartUpdate");
            
        } break;
            
        case CartList:
        {
            strURL = GET_URL(@"cartList");
            
        } break;
            
        case CartDelete:
        {
            strURL = GET_URL(@"cartDelete");
            
        } break;
            
        case CartSelect:
        {
            strURL = GET_URL(@"cartSelect");
            
        } break;

            
        case AddressAreaList:
        {
            strURL = GET_URL(@"getRegion");
            
        } break;
        case AddressAdd:
        {
            strURL = GET_URL(@"userAddressAdd");
            
        } break;
        case AddressUpdate:
        {
            strURL = GET_URL(@"userAddressUpdate");
            
        } break;
        case AddressList:
        {
            strURL = GET_URL(@"userAddressList");
            
        } break;
        case AddressDelete:
        {
            strURL = GET_URL(@"userAddressDelete");
        }break;
        case UserInfo:
        {
            strURL = GET_URL(@"userInfo");
            
        } break;
        case UserUpdate:
        {
            strURL = GET_URL(@"userUpdate");
            
        } break;
            
        case OrderSure:
        {
            strURL = GET_URL(@"sureOrder");
            
        } break;
        case OrderSureCar:
        {
            strURL = GET_URL(@"sureOrderCart");
            
        } break;
            
        case OrderDown:
        {
            strURL = GET_URL(@"downOrder");
            
        } break;

        case UserGetAccount:
        {
            strURL = GET_URL(@"getAccount");
            
        } break;
        case UserGetBalance:
        {
            strURL = GET_URL(@"getBalance");
            
        } break;
        case UserBalanceAdd:
        {
            strURL = GET_URL(@"userBalanceAdd");
            
        } break;
        case Order:
        {
            strURL = GET_URL(@"order");
            
        } break;
        case OrderCart:
        {
            strURL = GET_URL(@"orderCart");
            
        } break;

        case OrderList:
        {
            strURL = GET_URL(@"orderList");
            
        } break;
        case OrderInfo:
        {
            strURL = GET_URL(@"orderInfo");
            
        } break;
            
        case OrderRefundItemAdd:
        {
            strURL = GET_URL(@"refundItemAdd");
            
        } break;
            
        case OrderRefundItemList:
        {
            strURL = GET_URL(@"refundItemList");
            
        } break;
        case OrderCancel:
        {
            strURL = GET_URL(@"cancelOrder");
            
        } break;
        case OrderReceiptR:
        {
            strURL = GET_URL(@"receiptOrder");
            
        } break;
        case UserLogout:
        {
            strURL = GET_URL(@"logout");
            
        } break;
        case UserUpdatePsw:
        {
            strURL = GET_URL(@"pwUpdate");
            
        } break;

        case ShareBrandList:
        {
            strURL = GET_URL(@"brandList");
            
        } break;
        case ShareGoodsList:
        {
            strURL = GET_URL(@"goodsList");
            
        } break;
        case UserGetQnToken:
        {
            strURL = GET_URL(@"qnToken");
            
        } break;
        case MessageList:
        {
            strURL = GET_URL(@"messageList");
            
        } break;
        case MessageRead:
        {
            strURL = GET_URL(@"messageRead");
            
        } break;
        case MessageNumber:
        {
            strURL = GET_URL(@"getMessageNumber");
            
        } break;
        case OrderPay:
        {
            strURL = GET_URL(@"pay");
            
        } break;
        case UserAddComment:
        {
            strURL = GET_URL(@"addComment");
            
        } break;
        
        default:
            break;
    }
    
    
    return strURL;
}

+ (NSString *)getInterface:(InterfaceNum)interface
{
    return [HttpInterface getInterface:interface id:nil];
}


@end
