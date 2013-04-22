//
//  NSDate+ISO8601.h
//  WiFiToGo
//
//  Created by 松本 宗太郎 on 2013/04/21.
//  Copyright (c) 2013年 Ubiregi Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (ISO8601)

+ (NSDateFormatter *)dateFormatterForISO8601;

+ (NSDate *)dateFromISO8601String:(NSString *)string;
- (NSString *)stringInISO8601;

@end
