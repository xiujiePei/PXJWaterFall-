//
//  PXJCollectionViewCell.h
//  PXJWaterFall瀑布流
//
//  Created by 裴秀杰 on 2018/3/3.
//  Copyright © 2018年 JackP. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PXJCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *labelConstraintsHeight;
@end
