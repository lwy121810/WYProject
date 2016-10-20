//
//  DemoVC1.m
//  WYProject
//
//  Created by lwy1218 on 16/8/30.
//  Copyright © 2016年 lwy1218. All rights reserved.
//

#import "DemoVC1.h"
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKExtension/SSEThirdPartyLoginHelper.h>

typedef NS_ENUM(NSInteger , WYShareLoginType) {
    WYShareLoginTypeQQ = 1,
    WYShareLoginTypeQQZone,
    WYShareLoginTypeWX,
    WYShareLoginTypeWB
};
@interface DemoVC1 ()

@end

@implementation DemoVC1

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor yellowColor];
    [WYButton wyButton]
    .wy_title_normal(@"QQ登录")
    .wy_titleColor_normal([UIColor redColor])
    .wy_backgroundColor([UIColor orangeColor])
    .wy_frame(60 , 100 ,100 , 50)
    .wy_tag(WYShareLoginTypeQQ)
    .wy_targetAction(self , @selector(buttonAction:))
    .wy_superView(self.view);
    
    
    [WYButton wyButton]
    .wy_title_normal(@"QQZone登录")
    .wy_titleColor_normal([UIColor redColor])
    .wy_backgroundColor([UIColor orangeColor])
    .wy_frame(200 , 100 ,100 , 50)
    .wy_tag(WYShareLoginTypeQQZone)
    .wy_targetAction(self , @selector(buttonAction:))
    .wy_superView(self.view);
    
    
    
    [WYButton wyButton]
    .wy_title_normal(@"微信登录")
    .wy_titleColor_normal([UIColor redColor])
    .wy_backgroundColor([UIColor orangeColor])
    .wy_frame(60 , 170 ,100 , 50)
    .wy_tag(WYShareLoginTypeWB)
    .wy_targetAction(self , @selector(buttonAction:))
    .wy_superView(self.view);
    
    
    [WYButton wyButton]
    .wy_title_normal(@"微博登录")
    .wy_titleColor_normal([UIColor redColor])
    .wy_backgroundColor([UIColor orangeColor])
    .wy_frame(200, 170 ,100 , 50)
    .wy_tag(WYShareLoginTypeWX)
    .wy_targetAction(self , @selector(buttonAction:))
    .wy_superView(self.view);
}
- (void)loginWithType:(WYShareLoginType)loginType
{
    NSDictionary *loginDict = @{@(WYShareLoginTypeQQ):@(SSDKPlatformTypeQQ),
                                @(WYShareLoginTypeQQZone):@(SSDKPlatformSubTypeQZone),
                                @(WYShareLoginTypeWB):@(SSDKPlatformTypeSinaWeibo),
                                @(WYShareLoginTypeWX):@(SSDKPlatformTypeWechat)
                                };
    
    SSDKPlatformType formType = [loginDict[@(loginType)] integerValue];
    //例如QQ的登录
    [ShareSDK getUserInfo:formType
           onStateChanged:^(SSDKResponseState state, SSDKUser *user, NSError *error)
     {
         if (state == SSDKResponseStateSuccess)
         {
             NSLog(@"登录成功 - %@",error);
             NSLog(@"uid=%@",user.uid);
             NSLog(@"%@",user.credential);
             NSLog(@"token=%@",user.credential.token);
             NSLog(@"nickname=%@",user.nickname);
         }
         
         else
         {
             NSLog(@"登录失败 - %@",error);
         }
         
     }];
    
    
    //    [SSEThirdPartyLoginHelper loginByPlatform:SSDKPlatformTypeQQ
    //                                   onUserSync:^(SSDKUser *user, SSEUserAssociateHandler associateHandler) {
    //
    //                                       //在此回调中可以将社交平台用户信息与自身用户系统进行绑定，最后使用一个唯一用户标识来关联此用户信息。
    //                                       //在此示例中没有跟用户系统关联，则使用一个社交用户对应一个系统用户的方式。将社交用户的uid作为关联ID传入associateHandler。
    //                                       associateHandler (user.uid, user, user);
    //                                       NSLog(@"dd%@",user.rawData);
    //                                       NSLog(@"dd%@",user.credential);
    //
    //                                   }
    //                                onLoginResult:^(SSDKResponseState state, SSEBaseUser *user, NSError *error) {
    //
    //                                    if (state == SSDKResponseStateSuccess)
    //                                    {
    //
    //                                    }
    //
    //                                }];
    
}
- (void)buttonAction:(WYButton *)sender
{
    WYShareLoginType loginType = sender.tag;
    [self loginWithType:loginType];
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
