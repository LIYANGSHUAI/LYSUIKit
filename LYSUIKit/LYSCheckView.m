//
//  LYSCheckView.m
//  LYSUIKitDemo
//
//  Created by HENAN on 2019/7/19.
//  Copyright © 2019 HENAN. All rights reserved.
//

#import "LYSCheckView.h"

static LYSCheckViewManager *_manager = nil;

@interface LYSCheckViewManager ()

@property (nonatomic, strong)NSMutableDictionary *identifierDict;

@end

@implementation LYSCheckViewManager

+ (instancetype)manager
{
    if (!_manager) {
        _manager = [[LYSCheckViewManager alloc] init];
    }
    return _manager;
}

+ (void)releaseObj
{
    _manager = nil;
}

- (NSMutableDictionary *)identifierDict
{
    if (!_identifierDict) {
        _identifierDict = [NSMutableDictionary dictionary];
    }
    return _identifierDict;
}

- (void)dealloc
{
    NSLog(@"释放!");
}

@end

@implementation LYSCheckView

- (void)setIdentifier:(NSString *)identifier
{
    _identifier = identifier;
    if ([[[LYSCheckViewManager manager].identifierDict allKeys] containsObject:identifier])
    {
        NSArray *arr = [[LYSCheckViewManager manager].identifierDict objectForKey:identifier];
        NSMutableArray *tempArr = [NSMutableArray arrayWithArray:arr];
        [tempArr addObject:self];
        [[LYSCheckViewManager manager].identifierDict setObject:tempArr forKey:identifier];
    } else {
        NSMutableArray *tempArr = [NSMutableArray array];
        [tempArr addObject:self];
        [[LYSCheckViewManager manager].identifierDict setObject:tempArr forKey:identifier];
    }
}

+ (NSArray<LYSCheckView *> *)currentSelectCheckWithIdentifier:(NSString *)identifier
{
    NSMutableArray *currentSelectArr = [NSMutableArray array];
    if ([[[LYSCheckViewManager manager].identifierDict allKeys] containsObject:identifier])
    {
        NSArray *arr = [[LYSCheckViewManager manager].identifierDict objectForKey:identifier];
        NSMutableArray *tempArr = [NSMutableArray arrayWithArray:arr];
        for (int i = 0; i < [tempArr count]; i++) {
            LYSCheckView *view = [tempArr objectAtIndex:i];
            if (view.selected) {
                [currentSelectArr addObject:view];
            }
        }
    }
    return currentSelectArr;
}

+ (void)releaseCurrentCheckWithIdentifier:(NSString *)identifier
{
    if ([[[LYSCheckViewManager manager].identifierDict allKeys] containsObject:identifier])
    {
        [[LYSCheckViewManager manager].identifierDict removeObjectForKey:identifier];
    }
    if ([[LYSCheckViewManager manager].identifierDict count] == 0) {
        [LYSCheckViewManager releaseObj];
    }
}

@end
