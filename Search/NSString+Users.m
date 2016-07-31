//
//  NSString+Users.m
//  Search
//
//  Created by Sergey Tszyu on 31.07.16.
//  Copyright © 2016 Sergey Tszyu. All rights reserved.
//

#import "NSString+Users.h"

@implementation NSString (Users)

+ (NSString*) randomAlphanumericString {
    int length = arc4random() % 11 + 5; // мин 5 макс 15
    return [self randomAlphanumericStringWithLength:length];
}

+ (NSString*) randomAlphanumericStringWithLength:(NSInteger)length {
    NSString *letters = @"abcdefghijklmnopqrstuvwxyz";//ABCDEFGHIJKLMNOPQRSTUVWXYZ"; //0123456789
    NSMutableString *randomString = [NSMutableString stringWithCapacity:length];
    
    for (int i = 0; i < length; i++) {
        [randomString appendFormat:@"%C", [letters characterAtIndex:arc4random() % [letters length]]];
    }
    
    return randomString;
}

@end
