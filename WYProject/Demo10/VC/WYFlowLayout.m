//
//  WYFlowLayout.m
//  yibolai
//
//  Created by lwy1218 on 16/9/28.
//  Copyright © 2016年 liangang. All rights reserved.
//

#import "WYFlowLayout.h"


@interface WYFlowLayout ()
//保存最长列的最大Y值的数组
@property (nonatomic , strong) NSMutableArray *maxColoumnYs;

/**保存所有子控件布局属性对象的数组*/
@property (nonatomic , strong) NSMutableArray *attrsArray;
/** 计算每个item高度的block，必须实现 */
@property (nonatomic, copy) WYValueBlock valueBlock;
@end
@implementation WYFlowLayout

- (instancetype)init
{
    if (self = [super init]) {
        self.rowMargin = 10.0f;
        self.columnMargin = 10.0f;
        self.column = 3;
        self.edgeInset = UIEdgeInsetsMake(10, 10, 10, 10);
    }
    return self;
}
/**属性数组*/
- (NSMutableArray *)attrsArray
{
    if (!_attrsArray) {
        self.attrsArray = [NSMutableArray array];
    }
    return _attrsArray;
}
/**
 1.prepareLayout
 2.collectionViewContentSize
 3.layoutAttributesForElementsInRect
 
 当我们移动collectionView的时候会重复的调用layoutAttributesForElementsInRectf方法 
 因为第一次调用完毕layoutAttributesForElementsInRect方法时self.maxColoumnYs数组中存放的数据就变成了所有列最大的Y值 而下次调用的时候还是从这个数组中取出Y值来计算子控件的frame 计算出来的Y值就会非常大
 */

- (NSMutableArray *)maxColoumnYs
{
    if (!_maxColoumnYs) {
        self.maxColoumnYs = [NSMutableArray array];
        for (int i = 0; i < self.column; i ++) {
            _maxColoumnYs[i] = @(self.edgeInset.top);
        }
    }
    return _maxColoumnYs;
}
//准备布局时调用 在第一次显示的时候调用 collectionView的reloadData是会调用
//一般情况下会在该方法中初始化一些必要的数据 只做一次 或者刷新之后需要重新设置的属性都放在该方法初始化
- (void)prepareLayout
{
    [super prepareLayout];
    
    //每次计算之前重置保存每一列最大Y值的数据
    [self.maxColoumnYs removeAllObjects];
    for (int i = 0; i < self.column; i ++) {
        _maxColoumnYs[i] = @(self.edgeInset.top);
    }
    //取出当前collectionView的所有子控件的个数
    NSInteger count = [self.collectionView numberOfItemsInSection:0];
    
    NSMutableArray *arrayM = [NSMutableArray array];
    
    //循环创建所有子控件的属性对象
    for (int i = 0; i < count; i++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        UICollectionViewLayoutAttributes *attr = [self layoutAttributesForItemAtIndexPath:indexPath];
        [arrayM addObject:attr];
    }
    self.attrsArray = arrayM;
}
//该方法用于返回collectionView上所有子控件的排布（cell 补充视图 装饰视图）
- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{
    /*
   //每次计算之前重置保存每一列最大Y值的数据
    [self.maxColoumnYs removeAllObjects];
    for (int i = 0; i < self.column; i ++) {
        _maxColoumnYs[i] = @(self.edgeInset.top);
    }
    
    
    //取出当前collectionView的所有子控件的个数
    NSInteger count = [self.collectionView numberOfItemsInSection:0];
    
    NSMutableArray *arrayM = [NSMutableArray array];
    
    //循环创建所有子控件的属性对象
    for (int i = 0; i < count; i++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        UICollectionViewLayoutAttributes *attr = [self layoutAttributesForItemAtIndexPath:indexPath];
        [arrayM addObject:attr];
    }
    
    return arrayM;
     */
    //返回属性数组
    return self.attrsArray;
}
//用于返回指定位置的子控件的布局属性对象 一个UICollectionViewLayoutAttributes对象就对应一个子控件的排布
- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    //创建属性对象
    UICollectionViewLayoutAttributes *attr = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    
    //计算frame
    //1.计算总的间隙
    CGFloat totalMarginH = self.edgeInset.left + self.edgeInset.right + (self.column - 1) * self.columnMargin;
    //2.子控件的总宽
    CGFloat totalWidth = self.collectionView.frame.size.width - totalMarginH;
    //3.每个子控件的宽
    CGFloat width = totalWidth / self.column;
    //高度
//    CGFloat height = arc4random_uniform(100) + 80;
    CGFloat height;
    if (self.valueBlock) {
        height = self.valueBlock(indexPath, width);
    }else{//没有实现返回高度方法 设置默认高度
//        NSAssert(height != 0,@"Please implement computeIndexCellHeightWithWidthBlock Method");
        height = arc4random_uniform(100) + 80;
    }
    
    //找出最短列的列号 以及最短列最大的Y值
    //取出第0列的Y值 假设第0列最小
    //最短列的Y
    CGFloat destY = [self.maxColoumnYs[0] doubleValue];
    //最短列的列号
    NSUInteger destIndex = 0;
    
    for (int i = 1; i < self.column; i++) {
        //取出其他列比较
        CGFloat tempY = [self.maxColoumnYs[i] doubleValue];
        if (destY > tempY) {
            destY = tempY;
            destIndex = i;
        }
    }
    //x
    CGFloat x = self.edgeInset.left + (width + self.columnMargin) * destIndex;
    //y
    CGFloat y = destY + self.rowMargin;
    
    attr.frame= CGRectMake(x, y, width, height);
    
    //更新当前列最大的Y值
    self.maxColoumnYs[destIndex] = @(CGRectGetMaxY(attr.frame));
    //返回布局属性对象
    return attr;
}
//用于返回collectionView的滚动范围
- (CGSize)collectionViewContentSize
{
    //拿到所有列中最大的Y值加上底部的间隙作为高度
    //找出最短列的列号 以及最短列最大的Y值
    //取出第0列的Y值 假设第0列最小
    //最短列的Y
    CGFloat maxY = [self.maxColoumnYs[0] doubleValue];
    
    for (int i = 1; i < self.column; i++) {
        //取出其他列比较
        CGFloat tempY = [self.maxColoumnYs[i] doubleValue];
        if (maxY < tempY) {
            maxY = tempY;
        }
    }
    
    return CGSizeMake(0, maxY + self.edgeInset.bottom);
}
/**
 *  设置计算宽度block方法
 *
 *  @param block 计算item高度的block
 */
- (void)computeIndexCellHeight:(WYValueBlock)valueBlock
{
    if (self.valueBlock != valueBlock) {
        self.valueBlock = valueBlock;
    }
}
@end
