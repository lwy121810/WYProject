//
//  WYFlowLayout.h
//  yibolai
//
//  Created by lwy1218 on 16/9/28.
//  Copyright © 2016年 liangang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef CGFloat(^WYWidthBlock)(NSIndexPath *indexPath , CGFloat height);
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
 *  对象方法
 *
 *  @param block 在block中最后要返回一个item的高度
 */
- (void)computeIndexCellHeightWithWidthBlock:(WYWidthBlock)widthBlock;
@end
