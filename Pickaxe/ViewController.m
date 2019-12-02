//
//  ViewController.m
//  Pickaxe
//
//  Created by 办公 on 2019/12/2.
//  Copyright © 2019 办公. All rights reserved.
//

#import "ViewController.h"
#import "PUI/PUIStageViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    PUIStageViewController *pvcStage = [[PUIStageViewController alloc] init];
    [pvcStage.view setFrame:self.view.bounds];
    [self.view addSubview:pvcStage.view];
    
    NSString *pvcId1 = [pvcStage createPUIViewController];
    NSString *pvcId2 = [pvcStage createPUIViewController];
    
    NSString *styleJSON1 = @"{\"backgroundColor\": {\"r\": 255,\"g\": 255,\"b\": 0,\"a\": 0.6},\"borderWidth\": 3, \"aaaaaaaaaaaaaaaaaaaaaaaaaaa\": 20 }";
    NSString *styleJSON2 = @"{\"backgroundColor\": {\"r\": 255,\"g\": 0,\"b\": 0,\"a\": 0.6},\"borderWidth\": 1, \"aaaaaaaaaaaaaaaaaaaaaaaaaaa\": 20,\"x\": 10,\"y\": 100,\"width\": 160,\"height\": 100 }";
    
    [pvcStage rendePVCWithId:pvcId1 andStyleJSON:styleJSON1];
    [pvcStage rendePVCWithId:pvcId2 andStyleJSON:styleJSON2];
    
    [pvcStage addChildWithId:pvcId1 forParent:pvcId2];
//    [pvcStage destoryPVCWithId:pvcId1];
}


@end
