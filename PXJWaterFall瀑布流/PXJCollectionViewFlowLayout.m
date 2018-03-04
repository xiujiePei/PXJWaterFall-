//
//  PXJCollectionViewFlowLayout.m
//  PXJWaterFall瀑布流
//
//  Created by 裴秀杰 on 2018/3/3.
//  Copyright © 2018年 JackP. All rights reserved.
//

#import "PXJCollectionViewFlowLayout.h"
@interface PXJCollectionViewFlowLayout()
@property(nonatomic,strong)NSMutableDictionary *maxYDic;
@property(nonatomic,strong)NSMutableArray *attributesArray;
@end
@implementation PXJCollectionViewFlowLayout

- (NSMutableDictionary *)maxYDic{
    if (!_maxYDic) {
        _maxYDic = [NSMutableDictionary new];
    }
    return _maxYDic;
}

- (NSMutableArray *)attributesArray{
    if (!_attributesArray) {
        _attributesArray = [NSMutableArray new];
    }
    return _attributesArray;
}

- (instancetype)init{
    if (self = [super init]) {
        self.columnCount = 2;
    }
    return self;
}

- (instancetype)initWithColumnCount:(int)columnCount{
    if (self = [super init]) {
        self.columnCount = columnCount;
    }
    return self;
}

- (void)setColumnSpacing:(CGFloat)columnSpacing rowSpacing:(CGFloat)rowSpacing sectionInset:(UIEdgeInsets)sectionInset{
    self.columnSpacing = columnSpacing;
    self.rowSpacing = rowSpacing;
    self.sectionInset = sectionInset;
}

- (void)prepareLayout{
    [super prepareLayout];
    
    for (int i = 0; i < self.columnCount; i++) {
        self.maxYDic[@(i)] = @(self.sectionInset.top);//0，1，2
    }
    
    NSInteger itemCount = [self.collectionView numberOfItemsInSection:0];
    [self.attributesArray removeAllObjects];
    for (int i = 0; i < itemCount; i++) {
        UICollectionViewLayoutAttributes *attributes = [self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForItem:i inSection:0]];
        [self.attributesArray addObject:attributes];
    }
}

//设置collectionView的contentaSize
- (CGSize)collectionViewContentSize{
    __block NSNumber *maxIndex = @0;
    __weak typeof(self) weakSelf = self;
    [self.maxYDic enumerateKeysAndObjectsUsingBlock:^(NSNumber *key, NSNumber *obj, BOOL * _Nonnull stop) {
        __strong typeof(self) strongSelf = weakSelf;
        if ([strongSelf.maxYDic[maxIndex] floatValue] < obj.floatValue) {//得到最大值
            maxIndex = key;
        }
    }];
    //collectionView的contentSize.height就等于最长列的最大y值+下内边距
    return CGSizeMake(0, [self.maxYDic[maxIndex] floatValue] + self.sectionInset.bottom);
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    
    CGFloat collectionViewWidth = self.collectionView.frame.size.width;
    
    CGFloat itemWidth = (collectionViewWidth - self.sectionInset.left -self.sectionInset.right - ( self.columnCount - 1 )*self.columnSpacing) / self.columnCount;
    
    CGFloat itemHeight = 10;
    if (self.waterFallLayoutImageHeight) {
        itemHeight += self.waterFallLayoutImageHeight(self,itemWidth,indexPath);
    }
    if (self.waterFallLayoutLabelHeight) {
        itemHeight += self.waterFallLayoutLabelHeight(self,itemWidth,indexPath);
    }
    
    __block NSNumber *minIndex = @0;
    __weak typeof(self) weakSelf = self;
    [self.maxYDic enumerateKeysAndObjectsUsingBlock:^(NSNumber *key,NSNumber *obj,BOOL *stop){
        __strong typeof(self) strongSelf = weakSelf;
        if ([strongSelf.maxYDic[minIndex] floatValue] > obj.floatValue) {
            minIndex = key;
        }
    }];
    
    CGFloat itemX = self.sectionInset.left + (self.columnSpacing + itemWidth)*minIndex.integerValue;
    CGFloat itemY = [self.maxYDic[minIndex] floatValue] + self.rowSpacing;
    
    attributes.frame = CGRectMake(itemX, itemY, itemWidth, itemHeight);
    self.maxYDic[minIndex] = @(CGRectGetMaxY(attributes.frame));
    return attributes;
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect{
    return self.attributesArray;
}
@end
