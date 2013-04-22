//
//  UIImage+UB.m
//  Ubiregi2
//
//  Created by 宗太郎 松本 on 11/09/05.
//  Copyright 2011年 Ubiregi Inc. All rights reserved.
//

#import "UIImage+UB.h"

@implementation UIImage (UB)

-(UIImage *)imageResizedToFillSquare:(CGFloat)sizeInPoint {
	return [self imageResizedToFillRectangle:CGSizeMake(sizeInPoint, sizeInPoint)];
}

-(UIImage *)imageResizedToFillRectangle:(CGSize)sizeInPoint {
	CGFloat wr = sizeInPoint.width / self.size.width;
	CGFloat hr = sizeInPoint.height / self.size.height;
	
	CGFloat scale = MAX(wr, hr);
	
	UIImage* resized = [self imageScaled:scale];
	
	CGFloat x = (resized.size.width - sizeInPoint.width)/2;
	CGFloat y = (resized.size.height - sizeInPoint.height)/2;
	
	CGRect rect = CGRectMake(x, y, sizeInPoint.width, sizeInPoint.height);
	return [resized imageCroped:rect];
}

- (UIImage *)imageResizedToFitRectangle:(CGSize)sizeInPoint {
	CGFloat wr = sizeInPoint.width / self.size.width;
	CGFloat hr = sizeInPoint.height / self.size.height;
	
	CGFloat scale = MIN(wr, hr);
	
	return [self imageScaled:scale];
}


-(UIImage *)imageScaled:(CGFloat)scale {
	CGSize size = CGSizeMake(self.size.width * scale, self.size.height * scale);
	return [self imageScaledToRectangle:size];
}

-(UIImage *)imageScaledToRectangle:(CGSize)sizeInPoint {
	UIGraphicsBeginImageContextWithOptions(sizeInPoint, NO, self.scale);
    
	[self drawInRect:CGRectMake(0, 0, sizeInPoint.width, sizeInPoint.height)];
	UIImage* result = UIGraphicsGetImageFromCurrentImageContext();
	
	UIGraphicsEndImageContext();
	
	return result;
}

-(UIImage *)imageCroped:(CGRect)rectInPoint {
    // rectangle for CGImageCreateWithImageInRect should be in pixel
    CGRect rectInPixel = CGRectApplyAffineTransform(rectInPoint, CGAffineTransformScale(CGAffineTransformIdentity, self.scale, self.scale));
    
	CGImageRef imageRef = CGImageCreateWithImageInRect([self CGImage], rectInPixel);
	UIImage *cropped =[UIImage imageWithCGImage:imageRef scale:self.scale orientation:self.imageOrientation];
	CGImageRelease(imageRef);
    
	return cropped;
}

-(NSData *)jpegData {
	return UIImageJPEGRepresentation(self, 0.8);
}

-(NSData *)pngData {
	return UIImagePNGRepresentation(self);
}

@end
