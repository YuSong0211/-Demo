//
//  SLCollectionCell.h
//  瀑布流Demo
//
//  Created by 王玉松 on 2024/8/20.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SLCollectionCell : UICollectionViewCell
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIViewController *parentVC;
@end

NS_ASSUME_NONNULL_END
