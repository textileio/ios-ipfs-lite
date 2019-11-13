# ios-ipfs-lite

[![Made by Textile](https://img.shields.io/badge/made%20by-Textile-informational.svg?style=flat-square)](https://textile.io)
[![Chat on Slack](https://img.shields.io/badge/slack-slack.textile.io-informational.svg?style=flat-square)](https://slack.textile.io)
[![GitHub license](https://img.shields.io/github/license/textileio/ios-ipfs-lite.svg?style=flat-square)](./LICENSE)
[![Release](https://img.shields.io/github/release/textileio/ios-ipfs-lite.svg?style=flat-square)](https://github.com/textileio/ios-ipfs-lite/releases/latest)
[![Version](https://img.shields.io/cocoapods/v/IpfsLiteApi.svg?style=flat)](https://cocoapods.org/pods/IpfsLiteApi)
[![License](https://img.shields.io/cocoapods/l/IpfsLiteApi.svg?style=flat)](https://cocoapods.org/pods/IpfsLiteApi)
[![Platform](https://img.shields.io/cocoapods/p/IpfsLiteApi.svg?style=flat)](https://cocoapods.org/pods/IpfsLiteApi)
[![CircleCI branch](https://img.shields.io/circleci/project/github/textileio/ios-ipfs-lite/master.svg?style=flat-square)](https://circleci.com/gh/textileio/ios-ipfs-lite)
[![docs](https://img.shields.io/badge/docs-master-success.svg?style=popout-square)](https://textileio.github.io/ios-ipfs-lite/)
[![standard-readme compliant](https://img.shields.io/badge/standard--readme-OK-green.svg?style=flat-square)](https://github.com/RichardLitt/standard-readme)

> A lightweight, extensible IPFS peer for iOS.

IPFS Lite runs the minimal setup required to get and put IPLD DAGs on the IPFS network. It is a port of the [Go IPFS Lite](https://github.com/hsanjuan/ipfs-lite) library.

## Table of Contents

- [ios-ipfs-lite](#ios-ipfs-lite)
  - [Table of Contents](#table-of-contents)
  - [Background](#background)
  - [Roadmap](#roadmap)
  - [Install](#install)
  - [Usage](#usage)
    - [Initialize and start a Peer](#initialize-and-start-a-peer)
    - [Add data](#add-data)
    - [Add a file](#add-a-file)
    - [Fetch a file by CID](#fetch-a-file-by-cid)
  - [Maintainers](#maintainers)
  - [Contributing](#contributing)
  - [License](#license)

## Background

IPFS Lite runs the minimal setup required to provide a DAG service. It is a port of the [Go IPFS Lite](https://github.com/hsanjuan/ipfs-lite) library, and as such, has the same requirements. The goal of IPFS Lite is to run the bare minimal functionality for any IPLD-based application to interact with the IPFS network (by getting and putting blocks). This saves having to deal with the complexities of using a full IPFS daemon, while maintaining the ability to share the underlying libp2p host and DHT with other components.

## Roadmap

- [x] Launch IPFS Lite
- [x] Stop IPFS Lite
- [x] `addFileWithParams:input:completion:` Add data via `NSInputStream`.
- [x] `getFileWithCid:completion:` Asynchronously get file by content address.
- [x] `getNodeForCid:(NSString *)cid completion:` Asynchronously get an IPLD node from IPFS.
- [ ] `hasBlock` Query if the local peer has the specified block
- [ ] `addNode` And an IPLD node.
- [ ] `addNodes` And multiple IPLD nodes.
- [ ] `getNodes` Get multiple IPLD nodes.
- [ ] `removeNode` Remove an IPLD node.
- [ ] `removeNodes` Remove multiple IPLD nodes.
- [ ] `resolveLink` Resolve a link though a path in an IPLD node.
- [ ] `tree` List all data paths in an IPLD node.


## Install

The IPFS Lite library is published as a Cocoapod.

First, you'll need to [configure your project to use Cocoapods](https://guides.cocoapods.org/using/getting-started.html#getting-started).

Then, simple add `IpfsLiteApi` to your `Podfile`

```cmd
...
pod 'IpfsLiteApi'
...
```

and run `pod install`

## Usage

### Initialize and start a Peer

```objc
NSString *documents = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
NSString *repoPath = [documents stringByAppendingPathComponent:@"ipfs-lite"];
NSError *error;
BOOL success = [IpfsLiteApi launch:repoPath debug: false error:&error];
```

### Add data

```objc
NSInputStream *input = [[NSInputStream alloc] initWithData:[@"Hello there\n" dataUsingEncoding:NSUTF8StringEncoding]];
[IpfsLiteApi.instance addFileWithParams:[[AddParams alloc] init] input:input completion:^(Node * _Nullable node, NSError * _Nullable error) {
    // handle the node or error
}];
```

### Add a file

```objc
NSString *path = [[NSBundle mainBundle] pathForResource:@"test" ofType:@"jpeg"];
NSInputStream *input = [[NSInputStream alloc] initWithFileAtPath:path];
[IpfsLiteApi.instance addFileWithParams:[[AddParams alloc] init] input:input completion:^(Node * _Nullable node, NSError * _Nullable error) {
    // handle the node or error
}];
```

### Fetch a file by CID

```objc
[IpfsLiteApi.instance getNodeForCid:@"QmSnuWmxptJZdLJpKRarxBMS2Ju2oANVrgbr2xWbie9b2D" completion:^(Node * _Nullable node, NSError * _Nullable error) {
    // handle the node or error
}];
```

## Maintainers

[Aaron Sutula](https://github.com/asutula)

## Contributing

See [the contributing file](CONTRIBUTING.md)!

PRs accepted.

Small note: If editing the README, please conform to the [standard-readme](https://github.com/RichardLitt/standard-readme) specification.

## License

[MIT](LICENSE) (c) 2019 Textile
