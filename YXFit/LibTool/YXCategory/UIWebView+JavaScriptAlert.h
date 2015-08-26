//
//  UIWebView+JavaScriptAlert.h
//  HaiShang360
//
//  Created by 何军 on 18/8/15.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import <WebKit/WebKit.h>
@interface UIWebView (JavaScriptAlert)<UIAlertViewDelegate>
-(void)webView:(UIWebView *)sender runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(id)frame;

-(BOOL)webView:(UIWebView *)sender runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(id)frame;
@end
