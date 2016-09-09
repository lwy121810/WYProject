//
//  WYButton.h
//  WYProject
//
//  Created by lwy1218 on 16/8/27.
//  Copyright © 2016年 lwy1218. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WYButton;
typedef WYButton *(^WYMargin)(CGFloat value);
typedef WYButton *(^WYButtonTitle)(NSString *title);
typedef WYButton *(^WYButtonColor)(UIColor *color);
typedef WYButton *(^WYButtonFrame)(CGFloat x , CGFloat y , CGFloat w ,CGFloat h);
typedef WYButton *(^WYButtonSuperView)(UIView *superView);
typedef WYButton *(^WYButtonTargetAction)(id target , SEL sel);
typedef WYButton *(^WYButtonTag)(NSInteger tag);
typedef void(^WYButtonAction)(WYButton *button);
@interface WYButton : UIButton
@property (nonatomic , copy , readonly) WYMargin xIs;
@property (nonatomic , copy , readonly) WYMargin yIs;
@property (nonatomic , copy , readonly) WYMargin widthIs;
@property (nonatomic , copy , readonly) WYMargin heightIs;
@property (nonatomic , copy , readonly) WYButtonTitle wy_title_normal;
@property (nonatomic , copy , readonly) WYButtonTitle wy_title_select;
@property (nonatomic , copy , readonly) WYButtonColor wy_titleColor_normal;
@property (nonatomic , copy , readonly) WYButtonColor wy_titleColor_select;
@property (nonatomic , copy , readonly) WYButtonColor wy_backgroundColor;
@property (nonatomic , copy , readonly) WYButtonFrame wy_frame;
@property (nonatomic , copy , readonly) WYButtonSuperView wy_superView;
@property (nonatomic , copy , readonly) WYButtonTargetAction wy_targetAction;
@property (nonatomic , copy , readonly) WYButtonTag wy_tag;
+ (WYButton *)shareButton;
+ (WYButton *)wyButton;
@end
