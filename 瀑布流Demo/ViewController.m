//
//  ViewController.m
//  瀑布流Demo
//
//  Created by 王玉松 on 2024/8/20.
//

#import "ViewController.h"
#import "XRWaterfallLayout.h"
#import "SLCollectionCell.h"

@interface ViewController ()<UICollectionViewDataSource,UICollectionViewDelegate, XRWaterfallLayoutDelegate>
@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //创建瀑布流布局
    XRWaterfallLayout *waterfall = [XRWaterfallLayout waterFallLayoutWithColumnCount:3];
    
    //设置各属性的值
//    waterfall.rowSpacing = 10;
//    waterfall.columnSpacing = 10;
//    waterfall.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    waterfall.columnCount = 2;
    //或者一次性设置
    [waterfall setColumnSpacing:10 rowSpacing:10 sectionInset:UIEdgeInsetsMake(10, 10, 10, 10)];
    
    
    //设置代理，实现代理方法
    waterfall.delegate = self;
    
    //创建collectionView
    self.collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:waterfall];
    self.collectionView.backgroundColor = [UIColor whiteColor];
//    [self.collectionView registerNib:[UINib nibWithNibName:@"SLCollectionCell" bundle:nil] forCellWithReuseIdentifier:@"cellID"];
    [self.collectionView registerClass:[SLCollectionCell class] forCellWithReuseIdentifier:@"cellID"];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    [self.view addSubview:self.collectionView];
}

//根据item的宽度与indexPath计算每一个item的高度
- (CGFloat)waterfallLayout:(XRWaterfallLayout *)waterfallLayout itemHeightForWidth:(CGFloat)itemWidth atIndexPath:(NSIndexPath *)indexPath {
    //根据图片的原始尺寸，及显示宽度，等比例缩放来计算显示高度
    int randomNumber = arc4random_uniform(8);
//    return randomNumber * 50;
    return 300;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 100;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    SLCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellID" forIndexPath:indexPath];
    cell.parentVC = self;
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"%ld",(long)indexPath.row);
}
@end
