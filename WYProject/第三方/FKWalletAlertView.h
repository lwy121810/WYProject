//
//  FKWalletAlertView.h
//  FiveKilometer
//
//  Created by 李卫友 on 2017/4/1.
//  Copyright © 2017年 utouu-imac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FKWalletAlertView : UIView
@property (weak, nonatomic) IBOutlet UILabel *tagLabel;
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (nonatomic , copy) void(^itemCallBack)(NSInteger tag);
- (void)alertShow;
- (void)dismiss;
@end
