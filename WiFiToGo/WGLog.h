//
//  Log.h
//  WiFiToGo
//
//  Created by 松本 宗太郎 on 2013/04/21.
//  Copyright (c) 2013年 Ubiregi Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

#import "WGResult.h"

@interface WGLog : NSObject

+ (WGLog *)newLogWithDictionary:(NSDictionary *)dic;
+ (WGLog *)newLogFromContentsFile:(NSString *)path;

@property (nonatomic, strong) NSDate *timestamp;
@property (nonatomic, strong) NSString *SSID;
@property (nonatomic, strong) NSString *hostname;
@property (nonatomic, strong) CLLocation *location;
@property (nonatomic, strong) UIImage *image;
@property (nonatomic, strong) NSArray *results;

- (id)initWithDictionary:(NSDictionary *)dic;
- (NSDictionary *)serializeToJSON;
- (BOOL)save:(NSString *)path;

@end
