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
    - [IPFS-lite Libraries](#ipfs-lite-libraries)
  - [Roadmap](#roadmap)
  - [Install](#install)
  - [Usage](#usage)
    - [Initialize and start a Peer](#initialize-and-start-a-peer)
    - [Add data](#add-data)
    - [Add a file](#add-a-file)
    - [Fetch a file by CID to a NSOutputStream](#fetch-a-file-by-cid-to-a-nsoutputstream)
    - [Fetch a node by CID](#fetch-a-node-by-cid)
  - [Maintainers](#maintainers)
  - [Contributing](#contributing)
  - [License](#license)

## Background

IPFS Lite runs the minimal setup required to provide a DAG service. It is a port of the [Go IPFS Lite](https://github.com/hsanjuan/ipfs-lite) library, and as such, has the same requirements. The goal of IPFS Lite is to run the bare minimal functionality for any IPLD-based application to interact with the IPFS network (by getting and putting blocks). This saves having to deal with the complexities of using a full IPFS daemon, while maintaining the ability to share the underlying libp2p host and DHT with other components.

### IPFS-lite Libraries

> The following includes information about support for ipfs-lite.

| Name | Build | Language | Description |
|:---------|:---------|:---------|:---------|
| [`ipfs-lite`](https://github.com/hsanjuan/ipfs-lite) | [![Build Status](https://img.shields.io/travis/hsanjuan/ipfs-lite.svg?branch=master&style=flat-square)](https://travis-ci.org/hsanjuan/ipfs-lite) | [![golang](https://img.shields.io/badge/golang-blueviolet.svg?style=popout-square)](https://github.com/hsanjuan/ipfs-lite) | The reference implementaiton of ipfs-lite, written in Go. |
| [`js-ipfs-lite`](//github.com/textileio/js-ipfs-lite) | [![Build status](https://img.shields.io/github/workflow/status/textileio/js-ipfs-lite/Test/master.svg?style=popout-square)](https://github.com/textileio/js-ipfs-lite/actions?query=branch%3Amaster) | [![javascript](https://img.shields.io/badge/javascript-blueviolet.svg?style=popout-square)](https://github.com/textileio/js-ipfs-lite)| The Javascript version of ipfs-lite available for web, nodejs, and React Native applications. |
| [`ios-ipfs-lite`](//github.com/textileio/ios-ipfs-lite) | [![Build status](https://img.shields.io/circleci/project/github/textileio/ios-ipfs-lite/master.svg?style=flat-square)](https://github.com/textileio/ios-ipfs-lite/actions?query=branch%3Amaster) | [![objc](https://img.shields.io/badge/objc-blueviolet.svg?style=popout-square)](https://github.com/textileio/ios-ipfs-lite)| The iOS ipfs-lite library for use in Objc and Swift apps |
| [`android-ipfs-lite`](//github.com/textileio/android-ipfs-lite) | [![Build status](https://img.shields.io/circleci/project/github/textileio/android-ipfs-lite/master.svg?style=flat-square)](https://github.com/textileio/android-ipfs-lite/actions?query=branch%3Amaster) | [![java](https://img.shields.io/badge/java-blueviolet.svg?style=popout-square)](https://github.com/textileio/android-ipfs-lite)| The Java ipfs-lite library for us in Android apps |
| [`grpc-ipfs-lite`](//github.com/textileio/grpc-ipfs-lite) | [![Build status](https://img.shields.io/circleci/project/github/textileio/grpc-ipfs-lite/master.svg?style=flat-square)](https://github.com/textileio/grpc-ipfs-lite/actions?query=branch%3Amaster) | [![java](https://img.shields.io/badge/grpc--api-blueviolet.svg?style=popout-square)](https://github.com/textileio/grpc-ipfs-lite)| A common gRPC API interface that runs on the Go ipfs-lite node. |

## Roadmap

- [x] Launch IPFS Lite
- [x] Stop IPFS Lite
- [x] `addFileFromInput:params:completion:` Add data via `NSInputStream`.
- [x] `getFileWithCid:completion:` Asynchronously get file by content address.
- [x] `getFileToOutput:cid:completion:` Asynchronously get file by content address and write it to a `NSOutputStream`
- [x] `getNodeForCid:completion:` Asynchronously get an IPLD node from IPFS.
- [x] `getNodesForCids:completion:` Get multiple IPLD nodes.
- [x] `hasBlock:completion:` Query if the local peer has the specified block
- [x] `removeNodeForCid:completion:` Remove an IPLD node.
- [x] `removeNodesForCids:completion:` Remove multiple IPLD nodes.
- [x] `resolveLinkInNodeWithCid:path:completion:` Resolve a link though a path in an IPLD node.
- [x] `treeInNodeWithCid:fromPath:depth:completion:` List all data paths in an IPLD node.
- [ ] `addNode` And an IPLD node.
- [ ] `addNodes` And multiple IPLD nodes.


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
BOOL success = [IpfsLiteApi launch:repoPath debug:false lowMem: true error:&error];
```

### Add data

```objc
NSInputStream *input = [[NSInputStream alloc] initWithData:[@"Hello there\n" dataUsingEncoding:NSUTF8StringEncoding]];
[IpfsLiteApi.instance addFileFromInput:input parms:[[TTEAddParams alloc] init] completion:^(Node * _Nullable node, NSError * _Nullable error) {
    // handle the node or error
}];
```

### Add a file

```objc
NSString *path = [[NSBundle mainBundle] pathForResource:@"test" ofType:@"jpeg"];
NSInputStream *input = [[NSInputStream alloc] initWithFileAtPath:path];
[IpfsLiteApi.instance addFileFromInput:input params:[[TTEAddParams alloc] init] completion:^(Node * _Nullable node, NSError * _Nullable error) {
    // handle the node or error
}];
```

### Fetch a file by CID to a NSOutputStream

```objc
NSString *documents = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
NSString *outputPath = [documents stringByAppendingPathComponent:@"out.jpeg"];
NSOutputStream *output = [NSOutputStream outputStreamToFileAtPath:outputPath append:NO];
[IpfsLiteApi.instance getFileToOutput:output cid:@"<a-file-cid>" completion:^(NSError * _Nullable error) {
    // Handle error if it exists or interact with data written to disk
}];
```

### Fetch a node by CID

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
