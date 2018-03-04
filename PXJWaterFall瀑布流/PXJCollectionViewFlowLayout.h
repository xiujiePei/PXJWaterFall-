//
//  PXJCollectionViewFlowLayout.h
//  PXJWaterFall瀑布流
//
//  Created by 裴秀杰 on 2018/3/3.
//  Copyright © 2018年 JackP. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PXJCollectionViewFlowLayout : UICollectionViewFlowLayout
@property(nonatomic,assign)NSInteger columnCount;
@property(nonatomic,assign)CGFloat columnSpacing;
@property(nonatomic,assign)CGFloat rowSpacing;
@property(nonatomic,assign)UIEdgeInsets sectionInset;//section与collectionview的间距
//@property(nonatomic,strong)CGFloat (^itemHeightBlock)(CGFloat itemHeight,NSIndexPath *indexPath);
@property(nonatomic,strong)CGFloat (^waterFallLayoutImageHeight)(PXJCollectionViewFlowLayout *waterFallLayout,CGFloat itemWidth,NSIndexPath *indexPath);
@property(nonatomic,strong)CGFloat (^waterFallLayoutLabelHeight)(PXJCollectionViewFlowLayout *waterFallLayout,CGFloat itemWidth,NSIndexPath *indexPath);

- (instancetype)initWithColumnCount:(int)columnCount;
- (void)setColumnSpacing:(CGFloat)columnSpacing rowSpacing:(CGFloat)rowSpacing sectionInset:(UIEdgeInsets)sectionInset;
@end
