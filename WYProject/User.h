//
//  User.h
//  WYProject
//
//  Created by lwy on 2018/4/9.
//  Copyright © 2018年 lwy1218. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol ReminderBuilder <NSObject>

@property (nonatomic, strong, readwrite) NSString *name;
@property (nonatomic, strong, readwrite) NSDate *date;
@property (nonatomic, assign, readwrite) BOOL showsAlert;

@end

@interface UserBuilder : NSObject
@property (nonatomic , copy) NSString *name;
@property (nonatomic , assign) NSInteger age;
@end

@interface User : NSObject

@property (nonatomic , copy, readonly) NSString *name;
@property (nonatomic , assign, readonly) NSInteger age;

- (instancetype)initWithUserBuilder:(void(^)(UserBuilder *builder))block;

@end
