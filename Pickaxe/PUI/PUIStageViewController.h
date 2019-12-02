//
//  PUIStageViewController.h
//  Pickaxe
//
//  Created by 办公 on 2019/12/2.
//  Copyright © 2019 办公. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PUIViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface PUIStageViewController : UIViewController

// 存储所有的ui组件
@property (strong, nonatomic) NSMutableDictionary *pvcDictionary;

- (NSString *) createPUIViewController;
- (PUIViewController *) getPUIViewControllerWithId:(NSString *)puiId;
- (void) rendePVCWithId:(NSString *)pvcId andStyleJSON:(NSString *)jsonString;
- (void) destoryPVCWithId:(NSString *)pvcId;
- (void) addChildWithId:(NSString *)childPvcId forParent:(NSString *)parentPvcId;

@end

NS_ASSUME_NONNULL_END
