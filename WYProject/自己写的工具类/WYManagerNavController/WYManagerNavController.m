
//
//  WYManagerNavController.m
//  WYManagerNavViewController
//
//  Created by mac on 16/10/22.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "WYManagerNavController.h"
#import "WYNavBarView.h"


#define WYScreenWidth   [UIScreen mainScreen].bounds.size.width
#define WYScreenHeight    [UIScreen mainScreen].bounds.size.height

@interface WYManagerNavController ()<UICollectionViewDelegate , UICollectionViewDataSource, UIScrollViewDelegate>
@property (nonatomic , weak) UICollectionView *collectionView;
@property (nonatomic , weak) UICollectionViewFlowLayout *flowLayout;
@property (nonatomic , strong) NSMutableArray *viewControllers;
@property (nonatomic , weak) WYNavBarView *headerView;
@end

static NSString *identifier = @"WYNavManagerCell";
@implementation WYManagerNavController

- (NSMutableArray *)viewControllers
{
    if (!_viewControllers) {
        NSMutableArray *arr = [NSMutableArray array];
        self.viewControllers = arr;
    }
    return _viewControllers;
}
- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.minimumLineSpacing = 0;
        flowLayout.minimumInteritemSpacing = 5;
        [flowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
        UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        collectionView.delegate = self;
        collectionView.dataSource = self;
        [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:identifier];
        collectionView.pagingEnabled = YES;
        [self.view addSubview:collectionView];
        self.flowLayout = flowLayout;
        self.collectionView = collectionView;
    }
    return _collectionView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setupNavBar];
    
    [self setupChildrenVcView];
}

- (void)setupNavBar
{
    if (self.viewControllers.count == 0 || self.viewControllers == nil) {
        return;
    }
    CGRect frame = CGRectMake(0, 0, WYScreenWidth, 44);
    WYNavBarView *head = [[WYNavBarView alloc] initWithFrame:frame];
    
    self.headerView = head;
    [self.view addSubview:self.headerView];
    NSMutableArray *titles = [NSMutableArray array];
    
    [self.viewControllers enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[UIViewController class]]) {
            
            UIViewController *vc =  (UIViewController *)obj;
            if (vc.title) {
                [titles addObject:vc.title];
            }else{
                *stop = YES;
            }
            
        }
    }];
    
    [self.headerView setupTitles:titles];
    
    self.headerView.backgroundColor = [UIColor blackColor];
    
    __weak typeof(self)weakSelf = self;
    self.headerView.indexBlock = ^(NSInteger index){
        
        [weakSelf.collectionView setContentOffset:CGPointMake(index * weakSelf.view.width, 0) animated:YES];
    };
    
}

- (void)setTitleFont:(UIFont *)font
{
    [self.headerView setTitleFontWithFont:font];
}

- (void)setTitleColor:(UIColor *)color
{
    [self.headerView setTitleColorWithColor:color];
}

- (void)setDownLineColor:(UIColor *)lineColor
{
    [self.headerView setDownLineColor:lineColor];
}

- (void)setupTitles:(NSArray<NSString *> *)titles
{
    if (titles.count == 0 || titles == nil) {
        return;
    }
#ifdef WYDebugWithAssert
    if (titles.count != self.viewControllers.count) {
        NSAssert(NO, @"设置的文字长度应该跟初始化是设置的子控制器的长度一致, 所以你崩了！");
        return;
    }
#endif
    [self.headerView setupTitles:titles];
    
    [self setupChildrenVcView];
}


- (void)setupChildrenVcView
{
    
    CGFloat y = CGRectGetMaxY(self.headerView.frame);
    
    CGRect frame = CGRectMake(0, y, WYScreenWidth, WYScreenHeight -y-64);
    self.collectionView.frame = frame;
    self.flowLayout.itemSize = self.collectionView.frame.size;
    [self.collectionView reloadData];
    
    self.collectionView.backgroundColor = [UIColor whiteColor];
}

- (instancetype)initWithViewControllers:(NSArray <UIViewController *> *)viewControllers
{
    if (self = [super init]) {
        [self setupChildrenViewController:viewControllers];
    }
    return self;
}

- (void)setupChildrenViewController:(NSArray <UIViewController *>*)viewControllers
{
    if (viewControllers == nil || viewControllers.count == 0) return;
    [viewControllers enumerateObjectsUsingBlock:^(UIViewController * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [self addChildViewController:obj];
    }];
    self.viewControllers = [viewControllers mutableCopy];
}
- (NSInteger)getCurrentIndex:(UIScrollView *)scrollView
{
    if (scrollView.width == 0 || scrollView.height == 0) {
        return 0;
    }
    
    NSInteger index = 0;
    
    index = (scrollView.contentOffset.x + scrollView.width * 0.5) / scrollView.width;
    
    return MAX(0, index);
    
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    NSInteger index = [self getCurrentIndex:scrollView];
    
    CGFloat scale = self.collectionView.contentOffset.x / self.collectionView.contentSize.width;
    
    [self.headerView moveLineToIndex:index scale:scale];
}

#pragma mark - UICollectionViewDelegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.viewControllers.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    UIViewController *subVc = [self getSubViewControllerWithIndex:indexPath.row];
    subVc.view.frame = cell.contentView.bounds;
    [cell.contentView addSubview:subVc.view];
    return cell;
}

- (UIViewController *)getSubViewControllerWithIndex:(NSInteger)index
{
    if (self.viewControllers == nil || self.viewControllers.count == 0) {
        return nil;
    }
    
    UIViewController *subVc = self.viewControllers[index];
    return subVc;
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
