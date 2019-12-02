//
//  PUIViewController.h
//  Pickaxe
//
//  Created by 办公 on 2019/12/2.
//  Copyright © 2019 办公. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, PUIViewType) {
    PUIViewTypeCOMMOM
};

@interface PUIViewController : UIViewController

// 存一个id，可以不用
@property (nonatomic) NSString *puiId;
// 自身view的类型
@property (nonatomic) PUIViewType viewType;
// 样式表
@property (strong, nonatomic) NSMutableDictionary *style;

- (void) renderViewWithJSONString:(NSString *)jsonString;
- (void) addChildPVC:(PUIViewController *)childPVC;
- (void) setViewType:(PUIViewType)viewType;
- (void) render;
- (void) renderBox;
- (void) renderBorder;
- (void) renderShadow;

// 工具函数
+ (UIColor *) NSDictionary2UIColor:(NSDictionary *)dictionary;
+ (NSString *) NSDictionary2NSString:(NSDictionary *)dictionary;
+ (NSDictionary *) NSString2NSDictionary:(NSString *)string;
+ (void) MergeNSMutableDictionary:(NSMutableDictionary *)targetDictionary withNSDictionary:(NSDictionary *)dictionary;

@end

NS_ASSUME_NONNULL_END
