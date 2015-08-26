//
//  UIWebView+JavaScriptAlert.m
//  HaiShang360
//
//  Created by 何军 on 18/8/15.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "UIWebView+JavaScriptAlert.h"

@implementation UIWebView (JavaScriptAlert)
-(void)webView:(UIWebView *)sender runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(id)frame{
    UIAlertView* customAlert = [[UIAlertView alloc] initWithTitle:@"海尚360" message:message delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [customAlert show];
}
static BOOL diagStat = NO;
static NSInteger bIdx = -1;
-(BOOL)webView:(UIWebView *)sender runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(id)frame{
    UIAlertView* dialogue = [[UIAlertView alloc] initWithTitle:@"海尚360" message:message delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [dialogue show];
//    while (dialogue.hidden==NO && dialogue.superview!=nil) {
//        [[NSRunLoop mainRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:0.01f]];
//    }
    bIdx = -1;
    
    while (bIdx==-1) {
        //[NSThread sleepForTimeInterval:0.2];
        [[NSRunLoop mainRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:0.1f]];
    }
    if (bIdx == 0){//取消;
        diagStat = NO;
    }
    else if (bIdx == 1) {//确定;
        diagStat = YES;
    }
    return diagStat;
    
   // return diagStat;
}

//-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
//    if (buttonIndex==0) {
//        diagStat=NO;
//    }else if(buttonIndex==1){
//        diagStat=YES;
//    }
//}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    bIdx = buttonIndex;
}
@end
