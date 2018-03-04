//
//  PXJImage.m
//  PXJWaterFall瀑布流
//
//  Created by 裴秀杰 on 2018/3/3.
//  Copyright © 2018年 JackP. All rights reserved.
//

#import "PXJImage.h"

@implementation PXJImage
+(instancetype)imageWithLocation:(NSString *)location width:(CGFloat)w height:(CGFloat)h describ:(NSString *)d{
    PXJImage *image = [[PXJImage alloc] init];
    image.location = location;
    image.imageWidth = w;
    image.imageHeight = h;
    image.describ = d;
    return image;
}
@end
