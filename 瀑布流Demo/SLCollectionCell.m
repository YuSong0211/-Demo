//
//  SLCollectionCell.m
//  瀑布流Demo
//
//  Created by 王玉松 on 2024/8/20.
//

#import "SLCollectionCell.h"
#import "Masonry/Masonry.h"

#import "HXUIImageView+SDWebImage.h"
#import "HXUIButton+SDWebImage.h"
#import "HXPhotoBrowserViewController.h"

@interface SLCollectionCell()<UIGestureRecognizerDelegate>

@property (nonatomic, strong) UIButton *imgBtn;
@property (nonatomic, strong) NSArray *urlImgArray;
@property (nonatomic, strong) NSArray *thumbUrlImgArray;
@property (nonatomic, strong) NSMutableArray <UIView *>*selectedViewArray;
@end

@implementation SLCollectionCell
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self configUI];
    }
    return self;
}

- (void)configUI{
    [self.contentView addSubview:self.imageView];
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.contentView);
    }];
    [self setIndex:0];
}


/**
 加载图片
 */
- (void)setIndex:(NSInteger)index{
    
    CGFloat wh = 80;
    CGFloat x =  15;
    CGFloat margin = 10;
    _selectedViewArray = [NSMutableArray array];
    for (int i = 0 ; i < self.thumbUrlImgArray.count; i ++) {
        int indexX = i % 2;
        int indexY = i / 2;
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(x + indexX  * (wh + margin), indexY * (wh + 15), wh, wh)];
        [self.contentView addSubview:btn];
        btn.backgroundColor = [UIColor colorWithRed:238.0/255.0 green:238.0/255.0 blue:238.0/255.0 alpha:1];
        btn.tag = i;
        
        btn.imageView.contentMode = UIViewContentModeScaleAspectFill;
        [btn sd_setFadeImageWithURL:[NSURL URLWithString:self.thumbUrlImgArray[i]] forState:UIControlStateNormal];
        
        [btn addTarget:self action:@selector(showMultiplePhotoBrows:) forControlEvents:UIControlEventTouchUpInside];
        [_selectedViewArray addObject:btn];
    }
    
}

/**
 展示photobrowser
 */

///多图
- (void)showMultiplePhotoBrows:(UIButton *)sender{
    HXPhotoBrowserViewController *pb = [HXPhotoBrowserViewController new];
    pb.parentVC = self.parentVC;
    pb.photoViewArray = _selectedViewArray.copy;
    pb.currentIndex = sender.tag;
    pb.urlStrArray = self.urlImgArray;
    pb.config.photoLoadType = HXPhotoLoadTypeNormal;
    pb.config.photoProgressType = HXPhotoProgressTypeRing;
    [pb show];
}


- (NSArray *)urlImgArray{
    if (!_urlImgArray) {
        _urlImgArray = @[@"https://img2.baidu.com/it/u=3081486823,3222496219&fm=253&fmt=auto&app=138&f=JPEG?w=800&h=1067",
                         @"https://img2.baidu.com/it/u=3081486823,3222496219&fm=253&fmt=auto&app=138&f=JPEG?w=800&h=1067",
                         @"https://img0.baidu.com/it/u=1027172276,3213211156&fm=253&fmt=auto&app=138&f=JPEG?w=800&h=1455",
                         @"https://inews.gtimg.com/om_bt/OGlQWfsaAoKkuCcMZ2o9IVEPqd-72DQy5EAN02XBHUwfYAA/641",
                         @"https://inews.gtimg.com/om_bt/OGlQWfsaAoKkuCcMZ2o9IVEPqd-72DQy5EAN02XBHUwfYAA/641",
                     ];
    }
    return _urlImgArray;
}


- (NSArray *)thumbUrlImgArray{
    if (!_thumbUrlImgArray) {
        _thumbUrlImgArray = @[@"https://img2.baidu.com/it/u=3081486823,3222496219&fm=253&fmt=auto&app=138&f=JPEG?w=800&h=1067",
                              @"https://img0.baidu.com/it/u=1027172276,3213211156&fm=253&fmt=auto&app=138&f=JPEG?w=800&h=1455",
                              @"https://img0.baidu.com/it/u=1027172276,3213211156&fm=253&fmt=auto&app=138&f=JPEG?w=800&h=1455",
                              @"https://inews.gtimg.com/om_bt/OGlQWfsaAoKkuCcMZ2o9IVEPqd-72DQy5EAN02XBHUwfYAA/641",
                              @"https://inews.gtimg.com/om_bt/OGlQWfsaAoKkuCcMZ2o9IVEPqd-72DQy5EAN02XBHUwfYAA/641",
                        ];
    }
    return _thumbUrlImgArray;
}

-(UIImageView *)imageView{
    if (!_imageView) {
        _imageView = [[UIImageView alloc]init];
        _imageView.image = [UIImage imageNamed:@"pic_start"];

    }
    return _imageView;
}
@end
