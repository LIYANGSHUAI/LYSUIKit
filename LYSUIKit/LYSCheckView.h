//
//  LYSCheckView.h
//  LYSUIKitDemo
//
//  Created by HENAN on 2019/7/19.
//  Copyright © 2019 HENAN. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LYSCheckViewManager : NSObject

@end

@interface LYSCheckView : UIView

@property (nonatomic, assign) BOOL selected;
@property (nonatomic, copy) NSString *identifier;

+ (NSArray<LYSCheckView *> *)currentSelectCheckWithIdentifier:(NSString *)identifier;
+ (void)releaseCurrentCheckWithIdentifier:(NSString *)identifier;

@end

NS_ASSUME_NONNULL_END
