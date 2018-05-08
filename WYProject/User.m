//
//  User.m
//  WYProject
//
//  Created by lwy on 2018/4/9.
//  Copyright © 2018年 lwy1218. All rights reserved.
//

#import "User.h"

@implementation UserBuilder

@end

@interface User ()

@property (nonatomic , copy) NSString *name;
@property (nonatomic , assign) NSInteger age;
@end

@implementation User
- (instancetype)initWithUserBuilder:(void(^)(UserBuilder *builder))block
{
    
    self = [super init];
    if (!self) {
        return nil;
    }
    UserBuilder *builder = [[UserBuilder alloc] init];
    if (block) {
        block(builder);
    }
    self.name = builder.name;
    self.age = builder.age;
    return self;
}
@end
