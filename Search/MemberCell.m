//
//  MemberCell.m
//  Search
//
//  Created by Sergey Tszyu on 31.07.16.
//  Copyright © 2016 Sergey Tszyu. All rights reserved.
//

#import "MemberCell.h"

@implementation MemberCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setup];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

#pragma mark - Private

- (void) setup {
    _pictureView.layer.cornerRadius = _pictureView.frame.size.height /2;
    _pictureView.layer.masksToBounds = YES;
    _pictureView.layer.borderWidth = 0;
}

@end
