//
//  ViewController.m
//  ApplePay
//
//  Created by Wolf on 16/5/12.
//  Copyright © 2016年 Vincent-Xu. All rights reserved.
//

#import "ViewController.h"
#import <PassKit/PassKit.h>
#import <AddressBook/AddressBook.h>

@interface ViewController ()<PKPaymentAuthorizationViewControllerDelegate>
{
    PKPaymentButton *payBtn;
    PKPaymentToken  *token;
}



@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    payBtn = [[PKPaymentButton alloc] initWithPaymentButtonType:PKPaymentButtonTypePlain paymentButtonStyle:PKPaymentButtonStyleBlack];
    [self.view addSubview:payBtn];

    payBtn.frame  = CGRectMake(0, 0, 120, 60);
    payBtn.center = self.view.center;
    [payBtn addTarget:self action:@selector(pay:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)pay:(PKPaymentButton *)btn
{
//    http://www.cocoachina.com/ios/20150126/11019.html 详细

    // 支持卡的种类
    NSArray *paymentNetworks = @[PKPaymentNetworkAmex,PKPaymentNetworkMasterCard,PKPaymentNetworkVisa,PKPaymentNetworkDiscover,PKPaymentNetworkChinaUnionPay];

    /*
     BOOL isSupport = [PKPaymentAuthorizationViewController canMakePayments]; // 硬件是否支持
     isSupport : NO, 硬件不支持, 或家长控制而不能支付???
                 YES, 但是canMakePaymentsUsingNetworks: NO, 用户没有卡, 可以提供添加新卡方法 [[[PKPassLibrary alloc] init] openPaymentSetup]; 真机会跳转到Wallet添加新卡 ( >= iOS 8.3)
     */

    if ([PKPaymentAuthorizationViewController canMakePaymentsUsingNetworks:paymentNetworks]) {

        PKPaymentRequest *request    = [[PKPaymentRequest alloc] init];
        request.merchantIdentifier   = @"merchant.com.example.merchantA";// 商户ID
        request.countryCode          = @"US";   // 城市
        request.currencyCode         = @"USD";  // 货币
        request.supportedNetworks    = paymentNetworks; // NSArray<NSString *>
        request.merchantCapabilities = PKMerchantCapability3DS;// 支付处理方式, 3DS支付方式是必须支持的，EMV方式是可选的
        /*
         你可以在自己的服务器上完成整个支付流程，也可以在自己的服务器上使用第三方支付平台来解码支付信息，并完成支付处理。
         */

        // 配送地址
        request.requiredBillingAddressFields = PKAddressFieldAll;  // 使用内置的, 可以用户增添, 注意是和卡显示在同一行的

        // 支付金额
        NSDecimalNumber *toyAmount = [NSDecimalNumber decimalNumberWithString:@"520.11"];
        PKPaymentSummaryItem *toyItem = [PKPaymentSummaryItem summaryItemWithLabel:@"toy" amount:toyAmount];
        NSDecimalNumber *taxAmount = [NSDecimalNumber decimalNumberWithMantissa:1275 exponent:-2 isNegative:YES];
        PKPaymentSummaryItem *taxItem = [PKPaymentSummaryItem summaryItemWithLabel:@"tax" amount:taxAmount type:PKPaymentSummaryItemTypeFinal]; // Pending: 等待, 显示省略号
        NSDecimalNumber *totalAmount = [NSDecimalNumber zero];
        totalAmount = [totalAmount decimalNumberByAdding:toyAmount];
        totalAmount = [totalAmount decimalNumberByAdding:taxAmount];
        PKPaymentSummaryItem *totalItem = [PKPaymentSummaryItem summaryItemWithLabel:@"total" amount:totalAmount type:PKPaymentSummaryItemTypeFinal];
        request.paymentSummaryItems = @[toyItem, taxItem, totalItem]; // 最后一个默认放大

        // 弹窗支付信息
        PKPaymentAuthorizationViewController *vc = [[PKPaymentAuthorizationViewController alloc] initWithPaymentRequest:request];
        vc.delegate = self;
        [self presentViewController:vc animated:YES completion:nil];
    }else {
        NSLog(@"么有对应的卡.");
        [[[PKPassLibrary alloc] init] openPaymentSetup];
    }

}

/*
 1. 框架发送支付请求给安全模块，只有安全模块可以访问存储在设备上的标记化的卡信息。
 2. 安全模块把特定的卡和商家等支付数据加密，以保证只有苹果可以读取，然后发送给框架。框架会将这些数据发送给苹果。
 3. 苹果服务器再次加密这些支付数据，以保证只有商家可以读取。然后服务器对它进行签名，生成支付token，然后发送给设备。
 4. 框架调用相应的代理方法并传入这个token，然后你的代理方法传送token给你的服务器。
 5. 服务器对应处理
 6. completion 状态
 */
- (void)paymentAuthorizationViewController:(PKPaymentAuthorizationViewController *)controller didAuthorizePayment:(PKPayment *)payment completion:(void (^)(PKPaymentAuthorizationStatus))completion
{
    token = payment.token;
    completion(PKPaymentAuthorizationStatusSuccess); // 测试成功
}

- (void)paymentAuthorizationViewControllerDidFinish:(PKPaymentAuthorizationViewController *)controller
{
    // Apple支付弹窗
    [self dismissViewControllerAnimated:YES completion:nil];
}





@end
