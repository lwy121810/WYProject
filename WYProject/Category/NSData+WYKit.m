//
//  NSData+WYKit.m
//  WYProject
//
//  Created by yons on 17/2/3.
//  Copyright © 2017年 lwy1218. All rights reserved.
//

#import "NSData+WYKit.h"

@implementation NSData (WYKit)


+ (NSString * _Nonnull)convertToUTF8String:(NSData * _Nonnull)data {
    return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
}

- (NSString * _Nonnull)convertToUTF8String {
    return [NSData convertToUTF8String:self];
}

+ (NSString * _Nonnull)convertToASCIIString:(NSData * _Nonnull)data {
    return [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
}

- (NSString * _Nonnull)convertToASCIIString {
    return [NSData convertToASCIIString:self];
}


- (NSString * _Nullable)convertUUIDToString {
    return [[[self description] stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"<>"]] stringByReplacingOccurrencesOfString:@" " withString:@""];
}
@end
