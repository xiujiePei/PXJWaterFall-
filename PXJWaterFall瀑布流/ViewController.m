//
//  ViewController.m
//  PXJWaterFall瀑布流
//
//  Created by 裴秀杰 on 2018/3/1.
//  Copyright © 2018年 JackP. All rights reserved.
//

#import "ViewController.h"
#import "PXJCollectionViewCell.h"
#import "PXJImage.h"
#import "PXJCollectionViewFlowLayout.h"
@interface ViewController ()
@property(nonatomic,strong)UICollectionView *collectionView;
@property(nonatomic,strong)NSMutableArray *images;
@property(nonatomic,strong)PXJCollectionViewFlowLayout *layout;
@end

@implementation ViewController

- (NSMutableArray *)images{
    if (_images==nil) {
        _images = [NSMutableArray new];
        
        NSString *path = [[NSBundle mainBundle] pathForResource:@"images.plist" ofType:nil];
        NSArray *arrayImages = [NSArray arrayWithContentsOfFile:path];
        for (int i = 0; i < arrayImages.count; i++) {
            NSDictionary *dic = [arrayImages objectAtIndex:i];
            NSString *location = [dic objectForKey:@"location"];
            NSString *description = [dic objectForKey:@"description"];
            
            UIImage *image = [UIImage imageNamed:location];
            PXJImage *pxjImage = [PXJImage imageWithLocation:location width:image.size.width height:image.size.height describ:description];
            
            [_images addObject:pxjImage];
        }
    }
    return _images;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.layout = [[PXJCollectionViewFlowLayout alloc] initWithColumnCount:3];
    [self.layout setColumnSpacing:10.0 rowSpacing:10.0 sectionInset:UIEdgeInsetsMake(10.0, 10.0, 10.0, 10.0)];
    __weak typeof(self) weakSelf = self;
    [self.layout setWaterFallLayoutImageHeight:^CGFloat(PXJCollectionViewFlowLayout *waterFallLayout, CGFloat itemWidth, NSIndexPath *indexPath) {
        __strong typeof(self) strongSelf = weakSelf;
        PXJImage *image = strongSelf.images[indexPath.item];
        //图片高度
        return image.imageHeight/image.imageWidth*itemWidth;
    }];
    
    [self.layout setWaterFallLayoutLabelHeight:^CGFloat(PXJCollectionViewFlowLayout *waterFallLayout, CGFloat itemWidth, NSIndexPath *indexPath) {
        __strong typeof(self) strongSelf = weakSelf;
        PXJImage *image = strongSelf.images[indexPath.item];
        NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:13.0]};
        CGRect rect = [image.describ boundingRectWithSize:CGSizeMake(itemWidth,MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil];
        return rect.size.height;
    }];
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:[UIScreen mainScreen].bounds collectionViewLayout:self.layout];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self.collectionView registerNib:[UINib nibWithNibName:@"PXJCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"PXJCollectionViewCell"];
    self.collectionView.dataSource = self;
    [self.view addSubview:self.collectionView];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.images.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    PXJCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"PXJCollectionViewCell" forIndexPath:indexPath];
    PXJImage *image = self.images[indexPath.item];
    
    CGFloat H1 = image.imageHeight/image.imageWidth*cell.frame.size.width;
    cell.imageView.frame = CGRectMake(0, 0, cell.frame.size.width, H1);
    cell.imageView.image = [UIImage imageNamed:image.location];
    
    cell.label.text = image.describ;
    cell.labelConstraintsHeight.constant = cell.frame.size.height-H1;
    return cell;
}
@end
