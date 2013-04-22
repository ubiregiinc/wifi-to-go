//
//  Log.m
//  WiFiToGo
//
//  Created by 松本 宗太郎 on 2013/04/21.
//  Copyright (c) 2013年 Ubiregi Inc. All rights reserved.
//

#import "WGLog.h"

#import "NSDate+ISO8601.h"
#import "NSData+Base64.h"
#import "UIImage+UB.h"

@implementation WGLog

+ (WGLog *)newLogWithDictionary:(NSDictionary *)dic {
    return [[self alloc] initWithDictionary:dic];
}

+ (WGLog *)newLogFromContentsFile:(NSString *)path {
    NSData *data = [NSData dataWithContentsOfFile:path];
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:0 error:0];
    return [self newLogWithDictionary:dic];
}

- (id)initWithDictionary:(NSDictionary *)dic {
    self = [self init];
    
    self.timestamp = [NSDate dateFromISO8601String:dic[@"timestamp"]];
    self.SSID = dic[@"ssid"];
    self.hostname = dic[@"hostname"];
    
    CLLocationDegrees lat = [dic[@"position"][@"lat"] doubleValue];
    CLLocationDegrees lng = [dic[@"position"][@"lng"] doubleValue];
    self.location = [[CLLocation alloc] initWithLatitude:lat longitude:lng];
    
    NSData *imageData = [NSData dataWithBase64String:dic[@"image"]];
    self.image = [UIImage imageWithData:imageData scale:[UIScreen mainScreen].scale];
    
    NSMutableArray *results = [NSMutableArray new];
    for (NSDictionary *r in dic[@"results"]) {
        WGResult *result = [WGResult newResultWithDictionary:r];
        [results addObject:result];
    }
    self.results = results;
    
    return self;
}

- (NSDictionary *)serializeToJSON {
    NSData *imageData = [self.image jpegData];
    
    NSMutableArray *results = [NSMutableArray new];
    for (WGResult *result in self.results) {
        [results addObject:[result serializeToJSON]];
    }
    
    NSDictionary *pos;
    if (self.location) {
        pos = @{
                @"lat": @(self.location.coordinate.latitude),
                @"lng": @(self.location.coordinate.longitude),
                };
    }
    
    return @{
             @"timestamp": [self.timestamp stringInISO8601],
             @"ssid": self.SSID,
             @"hostname": self.hostname,
             @"position": (pos ? pos : [NSNull null]),
             @"image": (imageData ? [NSString base64StringWithData:imageData] : [NSNull null]),
             @"results": results,
            };
}

- (BOOL)save:(NSString *)path {
    NSData *data = [NSJSONSerialization dataWithJSONObject:[self serializeToJSON] options:0 error:nil];
    
    return [data writeToFile:path atomically:NO];
}

@end
