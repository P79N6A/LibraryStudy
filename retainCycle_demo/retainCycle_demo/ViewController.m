//
//  ViewController.m
//  retainCycle_demo
//
//  Created by star gazer on 2018/6/15.
//  Copyright © 2018年 star gazer. All rights reserved.
//

#import "ViewController.h"
#import "TestViewController.h"
#import <FBRetainCycleDetector/FBRetainCycleDetector.h>
#import "SomeObj.h"


@interface TestObj : NSObject

@property (nonatomic, strong) NSMutableArray *dataArray2;
@property (nonatomic, strong) id obj1;
@property (nonatomic, strong) id obj2;
@property (nonatomic, weak) id wobj3;
@property (nonatomic, strong) id sobj4;

@end

@implementation TestObj

@end

@interface ViewController ()

@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) TestObj *myObj;
@property (nonatomic, copy) BOOL (^block)(void);

@end

@implementation ViewController
- (void)viewDidLoad {
    [super viewDidLoad];

//    SomeObj *someObj = [SomeObj new];
    
//    TestObj *obj = [TestObj new];
//    self.myObj = obj;
//    obj.obj2 = self;
    self.block = ^BOOL{
        self;
        return NO;
    };
    
//    self.dataArray = [NSMutableArray new];
//    self.myObj.dataArray2 = self.dataArray;
//    self.myObj.obj1 = self.myObj;
    
    NSMutableArray *filters = @[
                                FBFilterBlockWithObjectIvarRelation([TestObj class], @"_obj2"),
                                ];
    ////
    FBObjectGraphConfiguration *configuration =
    [[FBObjectGraphConfiguration alloc] initWithFilterBlocks:filters
                                         shouldInspectTimers:YES];
//    FBRetainCycleDetector *detector = [[FBRetainCycleDetector alloc] initWithConfiguration:configuration];
    ////
    FBRetainCycleDetector *detector = [[FBRetainCycleDetector alloc] init];
//    [detector addCandidate:self.myObj];
    [detector addCandidate:self];
    NSSet *retainCycles = [detector findRetainCycles];
    NSLog(@"%@", retainCycles);
}

- (IBAction)onclickButton:(id)sender {
    TestViewController *testVC = [TestViewController new];
    [self.navigationController pushViewController:testVC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end