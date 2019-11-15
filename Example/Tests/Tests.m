// https://github.com/Specta/Specta

#import <IpfsLiteApi/IpfsLiteApi-umbrella.h>

SpecBegin(InitialSpecs)

describe(@"test the api", ^{
    
    __block Node *refTextNode;
    __block Node *refImageNode;
    NSString *apolloArchiverCid = @"QmSnuWmxptJZdLJpKRarxBMS2Ju2oANVrgbr2xWbie9b2D";
    
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
            NSInputStream *input = [[NSInputStream alloc] initWithData:[@"Hello there\n" dataUsingEncoding:NSUTF8StringEncoding]];
            [IpfsLiteApi.instance addFileWithParams:[[AddParams alloc] init] input:input completion:^(Node * _Nullable node, NSError * _Nullable error) {
                expect(error).beNil();
                expect(node).notTo.beNil();
                refTextNode = node;
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
                refImageNode = node;
                done();
            }];
        });
    });
    
    it(@"should get a file", ^{
        waitUntil(^(DoneCallback done) {
            [IpfsLiteApi.instance getFileWithCid:refTextNode.block.cid completion:^(NSData * _Nullable data, NSError * _Nullable error) {
                expect(error).beNil();
                expect(data).notTo.beNil();
                expect([[NSString alloc] initWithBytes:data.bytes length:data.length encoding:NSUTF8StringEncoding]).equal(@"Hello there\n");
                done();
            }];
        });
    });
    
    it(@"should get a file to output stream", ^{
        waitUntil(^(DoneCallback done) {
            NSString *documents = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
            NSString *outputPath = [documents stringByAppendingPathComponent:@"out.jpeg"];
            NSOutputStream *output = [NSOutputStream outputStreamToFileAtPath:outputPath append:NO];
            [IpfsLiteApi.instance getFileWithCid:refImageNode.block.cid toOutput:output completion:^(NSError * _Nullable error) {
                expect(error).beNil();
                BOOL exists = [[NSFileManager defaultManager] fileExistsAtPath:outputPath isDirectory:false];
                expect(exists).beTruthy();
                done();
            }];
        });
    });
    
    it(@"should check block", ^{
        waitUntil(^(DoneCallback done) {
            [IpfsLiteApi.instance hasBlock:refTextNode.block.cid completion:^(BOOL hasBlock, NSError * _Nullable error) {
                expect(hasBlock).beTruthy();
                expect(error).beNil();
                done();
            }];
        });
    });
    
    it(@"should get a node", ^{
        waitUntil(^(DoneCallback done) {
            [IpfsLiteApi.instance getNodeForCid:apolloArchiverCid completion:^(Node * _Nullable node, NSError * _Nullable error) {
                expect(error).beNil();
                expect(node).notTo.beNil();
                done();
            }];
        });
    });
    
    it(@"should get many nodes", ^{
        NSMutableArray<Node *> *nodes = [[NSMutableArray alloc] init];
        waitUntil(^(DoneCallback done) {
            NSMutableArray *cids = @[refTextNode.block.cid, refImageNode.block.cid].mutableCopy;
            [IpfsLiteApi.instance getNodesForCids:cids handler:^(BOOL nodesDone, Node * _Nullable node, NSError * _Nullable error) {
                expect(error).beNil();
                if (node) {
                    [nodes addObject:node];
                }
                if (nodesDone) {
                    done();
                }
            }];
        });
        expect(nodes.count).equal(2);
    });
    
    it(@"should remove node", ^{
        waitUntil(^(DoneCallback done) {
            [IpfsLiteApi.instance removeNodeForCid:refTextNode.block.cid completion:^(NSError * _Nullable error) {
                expect(error).beNil();
                [IpfsLiteApi.instance hasBlock:refTextNode.block.cid completion:^(BOOL hasBlock, NSError * _Nullable error) {
                    expect(hasBlock).beFalsy();
                    expect(error).beNil();
                    done();
                }];
            }];
        });
    });
    
    it(@"should remove nodes", ^{
        waitUntil(^(DoneCallback done) {
            NSMutableArray *cids = @[refImageNode.block.cid].mutableCopy;
            [IpfsLiteApi.instance removeNodesForCids:cids completion:^(NSError * _Nullable error) {
                expect(error).beNil();
                [IpfsLiteApi.instance hasBlock:refImageNode.block.cid completion:^(BOOL hasBlock, NSError * _Nullable error) {
                    expect(hasBlock).beFalsy();
                    expect(error).beNil();
                    done();
                }];
            }];
        });
    });
    
    it(@"should resolve a path", ^{
        waitUntil(^(DoneCallback done) {
            NSMutableArray *path = @[@"frontend", @"foo", @"bar"].mutableCopy;
            [IpfsLiteApi.instance resolveLinkInNodeWithCid:apolloArchiverCid path:path completion:^(Link * _Nullable link, NSArray<NSString *> * _Nullable remainingPath, NSError * _Nullable error) {
                expect(error).beNil();
                expect(link).notTo.beNil();
                expect(link.name).equal(@"frontend");
                expect(remainingPath).equal(@[@"foo", @"bar"]);
                done();
            }];
        });
    });
    
    it(@"should tree", ^{
        waitUntil(^(DoneCallback done) {
            [IpfsLiteApi.instance treeInNodeWithCid:apolloArchiverCid fromPath:nil depth:-1 completion:^(NSArray<NSString *> * _Nullable paths, NSError * _Nullable error) {
                expect(error).beNil();
                expect(paths).notTo.beNil();
                expect(paths.count).equal(6);
                done();
            }];
        });
    });
});

SpecEnd

