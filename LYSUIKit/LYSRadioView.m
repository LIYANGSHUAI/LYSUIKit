//
//  LYSRadioView.m
//  LYSUIKitDemo
//
//  Created by HENAN on 2019/7/19.
//  Copyright © 2019 HENAN. All rights reserved.
//

#import "LYSRadioView.h"

static LYSRadioViewManager *_manager = nil;

@interface LYSRadioViewManager ()

@property (nonatomic, strong)NSMutableDictionary *identifierDict;

@end

@implementation LYSRadioViewManager

+ (instancetype)manager
{
    if (!_manager) {
        _manager = [[LYSRadioViewManager alloc] init];
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

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"selected"]) {
        LYSRadioView *currentView = (LYSRadioView *)object;
        if (![change[NSKeyValueChangeOldKey] boolValue] && [change[NSKeyValueChangeNewKey] boolValue]) {
            NSString *identifier = currentView.identifier;
            NSArray *viewArr = [self.identifierDict objectForKey:identifier];
            for (int i = 0; i < [viewArr count]; i++) {
                LYSRadioView *view = [viewArr objectAtIndex:i];
                if (![view isEqual:currentView]) {
                    view.selected = NO;
                }
            }
        }
    }
}

@end

@implementation LYSRadioView

- (void)setIdentifier:(NSString *)identifier
{
    _identifier = identifier;
    if ([[[LYSRadioViewManager manager].identifierDict allKeys] containsObject:identifier])
    {
        NSArray *arr = [[LYSRadioViewManager manager].identifierDict objectForKey:identifier];
        NSMutableArray *tempArr = [NSMutableArray arrayWithArray:arr];
        [tempArr addObject:self];
        [[LYSRadioViewManager manager].identifierDict setObject:tempArr forKey:identifier];
        [self addObserver:[LYSRadioViewManager manager] forKeyPath:@"selected" options:(NSKeyValueObservingOptionOld | NSKeyValueObservingOptionNew) context:nil];
    } else {
        NSMutableArray *tempArr = [NSMutableArray array];
        [tempArr addObject:self];
        [[LYSRadioViewManager manager].identifierDict setObject:tempArr forKey:identifier];
        [self addObserver:[LYSRadioViewManager manager] forKeyPath:@"selected" options:(NSKeyValueObservingOptionOld | NSKeyValueObservingOptionNew) context:nil];
    }
}

+ (LYSRadioView *)currentSelectRadioWithIdentifier:(NSString *)identifier
{
    LYSRadioView *currentSelectRadio = nil;
    if ([[[LYSRadioViewManager manager].identifierDict allKeys] containsObject:identifier])
    {
        NSArray *arr = [[LYSRadioViewManager manager].identifierDict objectForKey:identifier];
        NSMutableArray *tempArr = [NSMutableArray arrayWithArray:arr];
        for (int i = 0; i < [tempArr count]; i++) {
            LYSRadioView *view = [tempArr objectAtIndex:i];
            if (view.selected) {
                currentSelectRadio = view;
                break;
            }
        }
    }
    return currentSelectRadio;
}

+ (void)releaseCurrentRadioWithIdentifier:(NSString *)identifier
{
    if ([[[LYSRadioViewManager manager].identifierDict allKeys] containsObject:identifier])
    {
        [[LYSRadioViewManager manager].identifierDict removeObjectForKey:identifier];
    }
    if ([[LYSRadioViewManager manager].identifierDict count] == 0) {
        [LYSRadioViewManager releaseObj];
    }
}

@end
