//
//  NSString+Users.h
//  Search
//
//  Created by Sergey Tszyu on 31.07.16.
//  Copyright © 2016 Sergey Tszyu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Users)

+ (NSString*) randomAlphanumericString;
+ (NSString*) randomAlphanumericStringWithLength:(NSInteger)length;

@end
