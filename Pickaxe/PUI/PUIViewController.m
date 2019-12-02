//
//  PUIViewController.m
//  Pickaxe
//
//  Created by 办公 on 2019/12/2.
//  Copyright © 2019 办公. All rights reserved.
//

#import "PUIViewController.h"

uint PUIViewControllerId = 0;

@interface PUIViewController ()

@end

@implementation PUIViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.puiId = [NSString stringWithFormat:@"puiid-%u", PUIViewControllerId++];
        NSString *defaultStyleText = @"{\"x\": 20,\"y\": 50,\"width\": 200,\"height\": 40,\"backgroundColor\": {\"r\": 255,\"g\": 255,\"b\": 255,\"a\": 1},\"borderWidth\": 1,\"borderColor\":{\"r\": 0,\"g\": 0,\"b\": 0,\"a\": 0.5},\"cornerRadius\": 8,\"shadowRadius\": 8,\"shadowOffset\": {\"x\": 0,\"y\": 0},\"shadowOpacity\": 0.5,\"shadowColor\":{\"r\": 0,\"g\": 0,\"b\": 255,\"a\": 1}}";
        NSDictionary *defaultStyle = [PUIViewController NSString2NSDictionary:defaultStyleText];
        self.style = [NSMutableDictionary dictionaryWithDictionary:defaultStyle];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)renderViewWithJSONString:(NSString *)jsonString {
    NSDictionary *dict = [PUIViewController NSString2NSDictionary:jsonString];
    [PUIViewController MergeNSMutableDictionary:_style withNSDictionary:dict];
    [self render];
}

- (void)renderBox {
//    NSDictionary *style = self.style;
    double x = [[_style objectForKey:@"x"] doubleValue];
    double y = [[_style objectForKey:@"y"] doubleValue];
    double width = [[_style objectForKey:@"width"] doubleValue];
    double height = [[_style objectForKey:@"height"] doubleValue];
    [self.view.layer setFrame:CGRectMake(x, y, width, height)];
    
    NSDictionary *backgroundColor = (NSDictionary *)[_style objectForKey:@"backgroundColor"];
    self.view.layer.backgroundColor = [PUIViewController NSDictionary2UIColor:backgroundColor].CGColor;
}

- (void)renderBorder {
    self.view.layer.cornerRadius = [[_style objectForKey:@"cornerRadius"] doubleValue];
    
    self.view.layer.borderWidth = [[_style objectForKey:@"borderWidth"] doubleValue];
    
    NSDictionary *borderColor = (NSDictionary *)[_style objectForKey:@"borderColor"];
    self.view.layer.borderColor = [PUIViewController NSDictionary2UIColor:borderColor].CGColor;
}

- (void)renderShadow {
    NSDictionary *shadowOffset = (NSDictionary *)[_style objectForKey:@"shadowOffset"];
    double x = [[shadowOffset objectForKey:@"x"] doubleValue];
    double y = [[shadowOffset objectForKey:@"y"] doubleValue];
    self.view.layer.shadowOffset = CGSizeMake(x, y);
    self.view.layer.shadowRadius = [[_style objectForKey:@"shadowRadius"] doubleValue];
    self.view.layer.shadowOpacity = [[_style objectForKey:@"shadowOpacity"] doubleValue];
    
    NSDictionary *shadowColor = (NSDictionary *)[_style objectForKey:@"shadowColor"];
    self.view.layer.shadowColor = [PUIViewController NSDictionary2UIColor:shadowColor].CGColor;
}

- (void)render {
    [self renderBox];
    [self renderBorder];
    [self renderShadow];
    NSLog(@"frame: %@", NSStringFromCGRect(self.view.frame));
    NSLog(@"bounds: %@", NSStringFromCGRect(self.view.bounds));
}

- (void)addChildPVC:(PUIViewController *)childPVC {
    [childPVC.view removeFromSuperview];
    UIScrollView *sv = [[UIScrollView alloc] init];
    
    [sv setFrame:self.view.bounds];
    CGRect rect = childPVC.view.frame;
    // overflow: visible;
    // sv.contentSize = CGSizeMake(rect.origin.x + rect.size.width, rect.origin.y + rect.size.height);
    // [sv setFrame:CGRectMake(0, 0, rect.origin.x + rect.size.width, rect.origin.y + rect.size.height)];
    // [sv setScrollEnabled:NO];
    
    // overflow: auto;
    sv.contentSize = CGSizeMake(rect.origin.x + rect.size.width, rect.origin.y + rect.size.height);
    [sv setFrame:self.view.bounds];
    [self.view addSubview:sv];
    [sv addSubview:childPVC.view];
}

// 工具方法
+ (NSDictionary *)NSString2NSDictionary:(NSString *)string {
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    return dict;
}

+ (NSString *)NSDictionary2NSString:(NSDictionary *)dictionary {
    NSString *string;
    NSError *error;
    NSData *data = [NSJSONSerialization dataWithJSONObject:dictionary options:0 error:&error];
    if (!data) {
        NSLog(@"NSDictionary2NSString Error: %@", error);
    } else {
        string = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    }
    return string;
}

+ (UIColor *)NSDictionary2UIColor:(NSDictionary *)dictionary {
    double r = [[dictionary objectForKey:@"r"] doubleValue];
    double g = [[dictionary objectForKey:@"g"] doubleValue];
    double b = [[dictionary objectForKey:@"b"] doubleValue];
    double a = [[dictionary objectForKey:@"a"] doubleValue];
    return [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a];
}

+ (void)MergeNSMutableDictionary:(NSMutableDictionary *)targetDictionary withNSDictionary:(NSDictionary *)dictionary {
    NSArray *keys = [dictionary allKeys];
    NSEnumerator *enumerator = [keys objectEnumerator];
    id key = nil;
    while(key = [enumerator nextObject]){
        id item = [targetDictionary objectForKey:key];
        // 只有targetDictionary有这个key，才参与赋值，目标字典没有的key忽略
        if (item != nil) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                // 如果是个不可变字典，替换成可变字典，然后继续循环
                NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:item];
                 [targetDictionary setObject:dict forKey:key];
                [PUIViewController MergeNSMutableDictionary:dict withNSDictionary:[dictionary objectForKey:key]];
            } else if ([item isKindOfClass:[NSMutableDictionary class]]) {
                // 如果是个不可变字典，替换成可变字典，然后继续循环
                [PUIViewController MergeNSMutableDictionary:item withNSDictionary:[dictionary objectForKey:key]];
            } else {
                [targetDictionary setObject:[dictionary objectForKey:key] forKey:key];
            }

        }
    }
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

/*
 {
 x,y,width,height,
 backgourndColor,
 borderWidth, borderColor,
 borderRadius,
 shadowOffset, shadowOffset, shadowOpacity, shadowColor,
 }
 */
