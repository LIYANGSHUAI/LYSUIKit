//
//  ViewController.m
//  LYSUIKitDemo
//
//  Created by HENAN on 2019/7/19.
//  Copyright © 2019 HENAN. All rights reserved.
//

#import "ViewController.h"
#import "CommonBtn.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    CommonBtn *view1 = [[CommonBtn alloc] initWithFrame:CGRectMake(10, 100, 80, 40)];
    [self.view addSubview:view1];
    
    CommonBtn *view2 = [[CommonBtn alloc] initWithFrame:CGRectMake(100, 100, 80, 40)];
    [self.view addSubview:view2];
    
    CommonBtn *view3 = [[CommonBtn alloc] initWithFrame:CGRectMake(10, 160, 80, 40)];
    [self.view addSubview:view3];
    
    CommonBtn *view4 = [[CommonBtn alloc] initWithFrame:CGRectMake(100, 160, 80, 40)];
    [self.view addSubview:view4];
    
    view1.identifier = @"btn";
    view2.identifier = @"btn";
    view3.identifier = @"btn";
    view4.identifier = @"btn";
    
    view4.selected = YES;
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSLog(@"%@",[CommonBtn currentSelectCheckWithIdentifier:@"btn"]);
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [CommonBtn releaseCurrentCheckWithIdentifier:@"btn"];
    });
}


@end
