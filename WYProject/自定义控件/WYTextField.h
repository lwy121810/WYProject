//
//  WYTextField.h
//  yibolai
//
//  Created by lwy1218 on 16/9/6.
//  Copyright © 2016年 liangang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WYTextField : UITextField

@property (nonatomic , strong) UILabel *leftLabel;
@property (nonatomic , copy) NSString *leftTitle;
@property (nonatomic , strong) UIColor *leftTitleColor;

@property (nonatomic , strong) UIFont *leftTitleFont;

/**placeholder的颜色 只有在设置了placeholder之后才会有效**/
@property (nonatomic , strong) UIColor *placeholderColor;
/**placeholder的字体 只有在设置了placeholder之后才会有效**/
@property (nonatomic , strong) UIFont *placeholderFont;

/**下划线的颜色 默认白色**/
@property (nonatomic , strong) UIColor *underLineColor;
@property (nonatomic , assign) CGFloat leftViewWidth;
@end
