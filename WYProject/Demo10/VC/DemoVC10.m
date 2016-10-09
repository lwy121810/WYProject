//
//  DemoVC10.m
//  WYProject
//
//  Created by lwy1218 on 16/9/28.
//  Copyright © 2016年 lwy1218. All rights reserved.
//

#import "DemoVC10.h"
#import "WYFlowLayout.h"
@interface DemoVC10 ()<UICollectionViewDataSource, UICollectionViewDelegate>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) WYFlowLayout *layout;

@end

static NSString *ID = @"UICollectionViewCell";
@implementation DemoVC10
- (WYFlowLayout *)layout {
    if (_layout == nil) {
        _layout = [[WYFlowLayout alloc] init];
    }
    return _layout;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.collectionView.collectionViewLayout = self.layout;
    // 透明时用这个属性(保证collectionView 不会被遮挡, 也不会向下移)
    //    self.edgesForExtendedLayout = UIRectEdgeNone;
    // 不透明时用这个属性
    self.extendedLayoutIncludesOpaqueBars = YES;
    
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:ID];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    self.collectionView.backgroundColor = [UIColor lightGrayColor];
    
    /**可以不实现该方法 会默认是一个80 - 180的随机数*/
    [self.layout computeIndexCellHeight:nil];

    //实现该方法的话 要返回item的高度
//    [self.layout computeIndexCellHeight:^CGFloat(NSIndexPath *indexPath, CGFloat value) {
//        return arc4random_uniform(200) + 80;
//    }];
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 100;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    cell.contentView.backgroundColor = [self randomColor];
    
    return cell;
}


- (UIColor *)randomColor {
    
    return [UIColor colorWithRed:arc4random_uniform(256) / 255.0 green:arc4random_uniform(256) / 255.0 blue:arc4random_uniform(256) / 255.0 alpha:1.0];
    
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
