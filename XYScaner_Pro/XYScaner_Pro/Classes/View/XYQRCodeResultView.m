//
//  XYQRCodeResultView.m
//  XYScaner_Pro
//
//  Created by zhaoxiangyu on 2019/1/2.
//  Copyright © 2019 xiangyu.zhao. All rights reserved.
//

#import "XYQRCodeResultView.h"



@interface XYQRCodeResultView(){
    NSString *_qrcodeStr;
}

//textView
@property (nonatomic, strong) UITextView *infoView;

@end

@implementation XYQRCodeResultView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
+ (instancetype)resultViewWithQRCodeString:(NSString *)string{
    return [[self alloc] initWithQRCodeString:string];
}

- (instancetype)initWithQRCodeString:(NSString *)string
{
    self = [super init];
    if (self) {
        _qrcodeStr = string;
        [self getQRCodeType];
    }
    return self;
}

- (void)getQRCodeType{
    if ([_qrcodeStr.lowercaseString hasPrefix:@"http:"]
        || [_qrcodeStr.lowercaseString hasPrefix:@"https:"]
        || [_qrcodeStr.lowercaseString hasPrefix:@"www."]
        || [_qrcodeStr.lowercaseString hasPrefix:@"url:"]) {
        _qrType = urlType;
    }else if([_qrcodeStr.uppercaseString hasPrefix:@"MAILTO:"]){
        _qrType = [self getQREmailType];
    }else if ([_qrcodeStr.uppercaseString hasPrefix:@"SMSTO:"]) {
        _qrType = smsType;
    }else if ([_qrcodeStr.uppercaseString hasPrefix:@"TEL:"]) {
        _qrType = telType;
    }else if ([_qrcodeStr.uppercaseString hasPrefix:@"GEO:"]) {
        _qrType = mapType;
    }else if ([_qrcodeStr length] > 15) {
        //Card格式
        if (!([[_qrcodeStr substringToIndex:15] rangeOfString:@"VCARD" options:NSCaseInsensitiveSearch].location == NSNotFound) ||
            !([[_qrcodeStr substringToIndex:15] rangeOfString:@"MECARD" options:NSCaseInsensitiveSearch].location == NSNotFound))
        {
            _qrType = cardType;
        }
        //event
        else if (!([[_qrcodeStr substringToIndex:15] rangeOfString:@"VCALENDAR" options:NSCaseInsensitiveSearch].location == NSNotFound))
        {
            _qrType = eventType;
        }
    }else {
        _qrType = infoType;
    }
}

- (QRType)getQREmailType{
    if ([_qrcodeStr containsString:@"body="] || [_qrcodeStr containsString:@"subject="]) {
        return emailType;
    }
    else{
        return emailAddressType;
    }
}

- (NSDictionary *)getQREmailContent{
    //如果是mailto类型
    if([_qrcodeStr.uppercaseString hasPrefix:@"MAILTO:"]){
        NSString *dataString = [_qrcodeStr stringByReplacingOccurrencesOfString:@"mailto:" withString:@""];
        dataString = [dataString stringByReplacingOccurrencesOfString:@"MAILTO:" withString:@""];
        NSArray *addressArray = [dataString componentsSeparatedByString:@"?"];
        NSMutableDictionary *emailDic = [[NSMutableDictionary alloc] init];
        [emailDic setObject:[addressArray objectAtIndex:0] forKey:@"to"];
        if ([addressArray count] >= 2) {
            for (int i  = 1; i < [addressArray count]; i++) {
                NSArray *contentArray = [[addressArray objectAtIndex:i] componentsSeparatedByString:@"&"];
                for (NSString *string in contentArray) {
                    if ([string length] < 3) {
                        continue;
                    }
                    NSString *temp = [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
                    if ([temp hasPrefix:@"subject="]) {
                        temp = [temp stringByReplacingOccurrencesOfString:@"subject=" withString:@""];
                        [emailDic setObject:temp forKey:@"subject"];
                    }
                    else if ([temp hasPrefix:@"body="]) {
                        temp = [temp stringByReplacingOccurrencesOfString:@"body=" withString:@""];
                        [emailDic setObject:temp forKey:@"body"];
                    }
                    else if ([temp hasPrefix:@"cc="]) {
                        temp = [temp stringByReplacingOccurrencesOfString:@"cc=" withString:@""];
                        [emailDic setObject:temp forKey:@"cc"];
                    }
                    else if ([temp hasPrefix:@"bcc="]) {
                        temp = [temp stringByReplacingOccurrencesOfString:@"bcc=" withString:@""];
                        [emailDic setObject:string forKey:@"bcc"];
                    }
                }
            }
        }
        return emailDic;
    }else{
        return nil;
    }
}

- (NSArray *)locationArrayFromQRContentString{
    NSString *dataString = [_qrcodeStr stringByReplacingOccurrencesOfString:@"GEO:" withString:@""];
    dataString = [dataString stringByReplacingOccurrencesOfString:@"geo:" withString:@""];
    dataString = [[dataString componentsSeparatedByString:@";"] objectAtIndex:0];
    return [dataString componentsSeparatedByString:@","];
}

@end
