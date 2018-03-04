//
//  PXJImage.h
//  PXJWaterFall瀑布流
//
//  Created by 裴秀杰 on 2018/3/3.
//  Copyright © 2018年 JackP. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PXJImage : NSObject
@property(nonatomic,strong)NSString *location;
@property(nonatomic,strong)NSString *describ;
@property(nonatomic,assign)CGFloat imageWidth;
@property(nonatomic,assign)CGFloat imageHeight;
+(instancetype)imageWithLocation:(NSString *)location width:(CGFloat)w height:(CGFloat)h describ:(NSString *)d;
@end
