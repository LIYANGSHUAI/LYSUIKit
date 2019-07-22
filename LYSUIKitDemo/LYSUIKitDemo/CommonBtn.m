//
//  CommonBtn.m
//  LYSUIKitDemo
//
//  Created by HENAN on 2019/7/19.
//  Copyright © 2019 HENAN. All rights reserved.
//

#import "CommonBtn.h"

@implementation CommonBtn

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.selected = NO;
    }
    return self;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    self.selected = !self.selected;
}

- (void)setSelected:(BOOL)selected
{
    [super setSelected:selected];
    if (self.selected) {
        self.backgroundColor = [UIColor redColor];
    } else {
        self.backgroundColor = [UIColor greenColor];
    }
    
}

@end
