//
//  WYFatherViewController.m
//  WYProject
//
//  Created by lwy1218 on 16/10/9.
//  Copyright © 2016年 lwy1218. All rights reserved.
//

#import "WYFatherViewController.h"

@interface WYFatherViewController ()

@property (nonatomic , copy) WYBarButtonBlock barButtonBlock;
@property (nonatomic , copy) WYBarButtonIndexBlock indexBlock;
@end

@implementation WYFatherViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

/**设置rightItems blcok参数 index:越靠近右边的item的index越小 index从0开始计数*/
- (void)setupRightBarButtonItemsWithTitles:(NSArray <NSString *>*)titles buttonActions:(WYBarButtonIndexBlock)indexBlock
{
    NSMutableArray <UIBarButtonItem *> *items = [NSMutableArray array];
    [titles enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithTitle:obj style:UIBarButtonItemStylePlain target:self action:@selector(rightItemsAction:)];
        right.tag = 600 + idx;
        right.tintColor = [UIColor greenColor];
        [items addObject:right];
    }];
    self.indexBlock = indexBlock;
    self.navigationItem.rightBarButtonItems = items;
}
- (void)rightItemsAction:(UIBarButtonItem *)item
{
    NSInteger index = item.tag - 600;
    if (self.indexBlock) {
        self.indexBlock(item , index);
    }
}

- (void)setupRightBarButtonItemWithTitle:(NSString *)title buttonAction:(WYBarButtonBlock)barItemBlock
{
    UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithTitle:title style:UIBarButtonItemStylePlain target:self action:@selector(rightAction:)];
    self.navigationItem.rightBarButtonItem = right;
    right.tintColor = [UIColor redColor];
    self.barButtonBlock = barItemBlock;
}

- (void)rightAction:(UIBarButtonItem *)right
{
    if (self.barButtonBlock) {
        self.barButtonBlock(right);
    }
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
