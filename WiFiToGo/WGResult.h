//
//  WGResult.h
//  WiFiToGo
//
//  Created by 松本 宗太郎 on 2013/04/21.
//  Copyright (c) 2013年 Ubiregi Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WGResult : NSObject

+ (WGResult *)newResultWithDictionary:(NSDictionary *)dic;

@property (nonatomic) BOOL success;
@property (nonatomic) NSTimeInterval responseTime;
@property (nonatomic, strong) NSString *message;

- (id)initWithDictionary:(NSDictionary *)dic;
- (NSDictionary *)serializeToJSON;

@end
