//
//  WGResult.m
//  WiFiToGo
//
//  Created by 松本 宗太郎 on 2013/04/21.
//  Copyright (c) 2013年 Ubiregi Inc. All rights reserved.
//

#import "WGResult.h"

@implementation WGResult

+ (WGResult *)newResultWithDictionary:(NSDictionary *)dic {
    return [[WGResult alloc] initWithDictionary:dic];
}

- (id)initWithDictionary:(NSDictionary *)dic {
    self = [self init];
    
    self.success = [dic[@"success"] boolValue];
    self.responseTime = [dic[@"response_time"] doubleValue];

    NSString *message = dic[@"message"];
    if ([message isKindOfClass:[NSNull class]]) {
        message = nil;
    }
    self.message = message;
    
    return self;
}

- (NSDictionary *)serializeToJSON {
    return @{
             @"success": @(self.success),
             @"response_time": @(self.responseTime),
             @"message": (self.message ? self.message : [NSNull null]),
            };
}

@end
