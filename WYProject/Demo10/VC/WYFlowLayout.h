//
//  WYFlowLayout.h
//  yibolai
//
//  Created by lwy1218 on 16/9/28.
//  Copyright © 2016年 liangang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef CGFloat(^WYValueBlock)(NSIndexPath *indexPath , CGFloat itemWidth);
@interface WYFlowLayout : UICollectionViewFlowLayout

/**显示多少列 默认是3列*/
@property (nonatomic , assign) NSInteger column;
/** 内边距 默认都是10*/
@property (nonatomic, assign) UIEdgeInsets edgeInset;
/**行间距 默认10*/
@property (nonatomic, assign) CGFloat rowMargin;
/**列间距 默认10*/
@property (nonatomic, assign) CGFloat columnMargin;
/**
 *  对象方法 该方法返回的是每个item的高度 不实现的话高度为默认值 随机数（arc4random_uniform(100) + 80）
 *
 *  @param block 在block中最后要返回一个item的高度 block的参数是cell的indexPath 和宽度
 */
- (void)computeIndexCellHeight:(WYValueBlock)valueBlock;
@end
