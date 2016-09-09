//
//  WYAreaChooseView.h
//  yibolai
//
//  Created by lwy1218 on 16/9/8.
//  Copyright © 2016年 liangang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^WYItemIndexStringBlock)(NSInteger index , NSString *text);
/**选择城市的view*/
@interface WYAreaChooseView : UIView
/**设置显示的列数 1~3之间 默认是2列*/
@property (nonatomic , assign) NSInteger numberOfComponents;
@property (nonatomic , copy) WYItemIndexStringBlock selectRowBlock;
@end
