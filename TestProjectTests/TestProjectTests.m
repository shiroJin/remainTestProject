//
//  TestProjectTests.m
//  TestProjectTests
//
//  Created by remain on 2018/3/7.
//  Copyright © 2018年 remain. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "Promise.h"

@interface TestProjectTests : XCTestCase

@end

@implementation TestProjectTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    
    [[[Promise resolveOnqueue:dispatch_get_main_queue() transaction:^(Next resolve, Next reject) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            resolve(@5);
        });
    }] then:^(Promise *promise) {
        promise.rejectBlk(promise.value);
    }] catch:^(Promise *promise) {
        NSLog(@"%@", promise.value);
    }];
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
