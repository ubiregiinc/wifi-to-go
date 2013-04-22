//
//  UIImage+UB.h
//  Ubiregi2
//
//  Created by 宗太郎 松本 on 11/09/05.
//  Copyright 2011年 Ubiregi Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UIImage (UB)

-(UIImage*) imageResizedToFillSquare:(CGFloat)sizeInPoint;
-(UIImage*) imageResizedToFillRectangle:(CGSize)sizeInPoint;
-(UIImage*) imageResizedToFitRectangle:(CGSize)sizeInPoint;

-(UIImage*) imageScaled:(CGFloat)scale;
-(UIImage*) imageScaledToRectangle:(CGSize)sizeInPoint;

-(UIImage*) imageCroped:(CGRect)rectInPoint;

-(NSData*) jpegData;
-(NSData*) pngData;

@end
