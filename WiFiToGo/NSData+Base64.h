//
//  NSData+Base64.h
//  Ubiregi
//
//  Created by 松本 宗太郎 on 10/12/11.
//  Copyright 2010 HomeSearch Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (Base64)

+ (NSData *)dataWithBase64String:(NSString*)string;

@end

@interface NSString (Base64)

+ (NSString *)base64StringWithData:(NSData*)data;

@end