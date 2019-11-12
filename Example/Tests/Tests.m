//
//  IpfsLiteApiTests.m
//  IpfsLiteApiTests
//
//  Created by Aaron Sutula on 11/07/2019.
//  Copyright (c) 2019 Aaron Sutula. All rights reserved.
//

// https://github.com/Specta/Specta

#import <IpfsLiteApi/IpfsLiteApi-umbrella.h>

SpecBegin(InitialSpecs)

//describe(@"these will fail", ^{
//
//    it(@"can do maths", ^{
//        expect(1).to.equal(2);
//    });
//
//    it(@"can read", ^{
//        expect(@"number").to.equal(@"string");
//    });
//
//    it(@"will wait for 10 seconds and fail", ^{
//        waitUntil(^(DoneCallback done) {
//
//        });
//    });
//});
//
//describe(@"these will pass", ^{
//
//    it(@"can do maths", ^{
//        expect(1).beLessThan(23);
//    });
//
//    it(@"can read", ^{
//        expect(@"team").toNot.contain(@"I");
//    });
//
//    it(@"will wait and succeed", ^{
//        waitUntil(^(DoneCallback done) {
//            done();
//        });
//    });
//});

describe(@"test the api", ^{
    
    it(@"should start", ^{
        NSString *documents = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        NSString *repoPath = [documents stringByAppendingPathComponent:@"ipfs-lite"];
        NSError *error;
        BOOL success = [IpfsLiteApi launch:repoPath debug: false error:&error];
        expect(success).beTruthy();
        expect(error).beNil();
    });
    
    it(@"should add file", ^{
        waitUntil(^(DoneCallback done) {
            NSInputStream *input = [[NSInputStream alloc] initWithData:[@"Hello there" dataUsingEncoding:NSUTF8StringEncoding]];
            [IpfsLiteApi.instance addFileWithParams:[[AddParams alloc] init] input:input completion:^(Node * _Nullable node, NSError * _Nullable error) {
                expect(error).beNil();
                expect(node).notTo.beNil();
                done();
            }];
        });
    });
    
    it(@"should add a large file", ^{
        waitUntil(^(DoneCallback done) {
            NSString *path = [[NSBundle mainBundle] pathForResource:@"test" ofType:@"jpeg"];
            NSInputStream *input = [[NSInputStream alloc] initWithFileAtPath:path];
            [IpfsLiteApi.instance addFileWithParams:[[AddParams alloc] init] input:input completion:^(Node * _Nullable node, NSError * _Nullable error) {
                expect(error).beNil();
                expect(node).notTo.beNil();
                done();
            }];
        });
    });
});

SpecEnd

