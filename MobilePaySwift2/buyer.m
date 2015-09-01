//
//  buyer.m
//  MobilePaySwift2
//
//  Created by Joachim Dittman on 31/08/15.
//  Copyright (c) 2015 Joachim Dittman. All rights reserved.
//
#import "MobilePayManager.h"
#import "buyer.h"

@interface buyer ()
@property (nonatomic, strong) NSMutableArray *products;
@property (nonatomic, strong) UIAlertView *errorInOrderAlertView;

@end

@implementation buyer

- (BOOL)OpenUrl:(NSURL*)url {
     NSLog(@"OpenUrl");
    [[MobilePayManager sharedInstance] handleMobilePayCallbacksWithUrl:url success:^(NSString *orderId, NSString *transactionId, NSString *signature) {
        NSLog(@"MobilePay payment succeeded: Your have now payed for order with id '%@' and MobilePay transaction id '%@'", orderId, transactionId);
        //todo here is where you deliver the product
    } error:^(NSString *orderId, int errorCode, NSString *errorMessage) {
        NSLog(@"MobilePay payment failed:  Error code '%i' and message '%@'",errorCode,errorMessage);
        //todo show an appropriate error message to the user. Check MobilePayManager.h for a complete description of the error codes
        /*
         * An example of using the ErrorCode enum
         if (errorCode == ErrorCodeUpdateApp) {
         *     NSLog(@"You must update your MobilePay app");
         * }
         */
    } cancel:^(NSString *orderId) {
        NSLog(@"MobilePay payment with order id '%@' canceled by user", orderId);
        //todo maybe your app should enter a certain state when the user cancels the payment flow in MobilePay?
    }];
    
    return YES;
      return YES;
     }


- (void)buy{
 NSLog(@"Buy");
    NSString *receiptMessage = @"Tak for dit køb, nyd din frugt!";
    NSString *orderId = @"123456";
    if ((receiptMessage.length > 0) && (orderId.length > 0)) {
        [[MobilePayManager sharedInstance] beginMobilePaymentWithOrderId:orderId productPrice:20.0 receiptMessage:receiptMessage error:^(NSError *error) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:error.localizedDescription
                                                            message:[NSString stringWithFormat:@"reason: %@, suggestion: %@",error.localizedFailureReason, error.localizedRecoverySuggestion]
                                                           delegate:self
                                                  cancelButtonTitle:@"Cancel"
                                                  otherButtonTitles:@"Install MobilePay",nil];
            [alert show];
        }];
    }else{
        self.errorInOrderAlertView = [[UIAlertView alloc] initWithTitle:@"Error in your order"
                                                                message:@"One or more parameters in your order is invalid"
                                                               delegate:self
                                                      cancelButtonTitle:@"Cancel"
                                                      otherButtonTitles:@"Ok",nil];
         
    }
    

}

-(void)alertView:(UIAlertView *)alertView
{
     NSLog(@"BuyVindue");
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[MobilePayManager sharedInstance].mobilePayAppStoreLinkDK]];
    
}
@end



