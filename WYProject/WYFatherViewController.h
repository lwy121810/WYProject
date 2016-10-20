//
//  WYFatherViewController.h
//  WYProject
//
//  Created by lwy1218 on 16/10/9.
//  Copyright © 2016年 lwy1218. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^WYImageBlock)(UIImage *image);
typedef void(^WYTitleBlock)(NSString *title);
typedef void(^WYBarButtonBlock)(UIBarButtonItem *barButtonItem);
typedef void(^WYBarButtonIndexBlock)(UIBarButtonItem *barButtonItem, NSInteger index);
@interface WYFatherViewController : UIViewController

/**设置rightBarButtonItem*/
- (void)setupRightBarButtonItemWithTitle:(NSString *)title buttonAction:(WYBarButtonBlock)barItemBlock;
/**设置rightItems blcok参数 index:越靠近右边的item的index越小 index从0开始计数*/
- (void)setupRightBarButtonItemsWithTitles:(NSArray <NSString *>*)titles buttonActions:(WYBarButtonIndexBlock)indexBlock;
@end
