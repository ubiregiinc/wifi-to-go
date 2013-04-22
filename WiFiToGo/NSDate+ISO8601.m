//
//  NSDate+ISO8601.m
//  WiFiToGo
//
//  Created by 松本 宗太郎 on 2013/04/21.
//  Copyright (c) 2013年 Ubiregi Inc. All rights reserved.
//

#import "NSDate+ISO8601.h"

@implementation NSDate (ISO8601)

+ (NSDateFormatter *)dateFormatterForISO8601 {
	static NSDateFormatter* formatter;
	static dispatch_once_t onceToken;
	
	dispatch_once(&onceToken, ^{
		formatter = [NSDateFormatter new];
		[formatter setLocale:[NSLocale systemLocale]];
		[formatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss'Z'"];
		NSTimeZone *utc = [NSTimeZone timeZoneWithName:@"UTC"];
		[formatter setTimeZone:utc];
		NSCalendar* calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
		[formatter setCalendar:calendar];
	});
    
    return formatter;
}

+ (NSDate *)dateFromISO8601String:(NSString *)string {
    if (!string) return nil;
    if ([string isKindOfClass:[NSNull class]]) return nil;

	NSDate* date;
    NSDateFormatter *formatter = [self dateFormatterForISO8601];
    
	@synchronized (formatter) {
		date = [formatter dateFromString:string];
	}
	
	return date;
}

- (NSString *)stringInISO8601 {
    NSString *string;
    
    NSDateFormatter *formatter = [NSDate dateFormatterForISO8601];
    @synchronized (formatter) {
        string = [formatter stringFromDate:self];
    }
    
    return string;
}

@end
