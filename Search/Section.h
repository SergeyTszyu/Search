//
//  Section.h
//  Search
//
//  Created by Sergey Tszyu on 31.07.16.
//  Copyright © 2016 Sergey Tszyu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Section : NSObject

@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSMutableArray *itemsArray;

@end
