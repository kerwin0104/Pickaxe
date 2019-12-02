//
//  PUIStageViewController.m
//  Pickaxe
//
//  Created by 办公 on 2019/12/2.
//  Copyright © 2019 办公. All rights reserved.
//

#import "PUIStageViewController.h"

@interface PUIStageViewController ()

@end

@implementation PUIStageViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        _pvcDictionary = [NSMutableDictionary dictionary];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}

- (NSString *)createPUIViewController {
    PUIViewController *pvc = [[PUIViewController alloc] init];
    [_pvcDictionary setObject:pvc forKey:pvc.puiId];
    [self.view addSubview:pvc.view];
    return pvc.puiId;
}

- (PUIViewController *)getPUIViewControllerWithId:(NSString *)puiId {
    return [_pvcDictionary objectForKey:puiId];
}

- (void)rendePVCWithId:(NSString *)pvcId andStyleJSON :(NSString *)jsonString {
    PUIViewController *pvc = [self getPUIViewControllerWithId:pvcId];
    [pvc renderViewWithJSONString:jsonString];
}

- (void)destoryPVCWithId:(NSString *)pvcId {
    PUIViewController *pvc = [self getPUIViewControllerWithId:pvcId];
    [pvc.view removeFromSuperview];
    [_pvcDictionary removeObjectForKey:pvcId];
}

- (void)addChildWithId:(NSString *)childPvcId forParent:(NSString *)parentPvcId {
    PUIViewController *parentPvc = [self getPUIViewControllerWithId:parentPvcId];
    PUIViewController *childPvc = [self getPUIViewControllerWithId:childPvcId];
    [parentPvc addChildPVC:childPvc];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
