#if !defined(GPB_GRPC_FORWARD_DECLARE_MESSAGE_PROTO) || !GPB_GRPC_FORWARD_DECLARE_MESSAGE_PROTO
#import "IpfsLite.pbobjc.h"
#endif

#if !defined(GPB_GRPC_PROTOCOL_ONLY) || !GPB_GRPC_PROTOCOL_ONLY
#import <ProtoRPC/ProtoService.h>
#import <ProtoRPC/ProtoRPCLegacy.h>
#import <RxLibrary/GRXWriteable.h>
#import <RxLibrary/GRXWriter.h>
#endif

@class AddFileRequest;
@class AddFileResponse;
@class AddNodeRequest;
@class AddNodeResponse;
@class AddNodesRequest;
@class AddNodesResponse;
@class GetFileRequest;
@class GetFileResponse;
@class GetNodeRequest;
@class GetNodeResponse;
@class GetNodesRequest;
@class GetNodesResponse;
@class HasBlockRequest;
@class HasBlockResponse;
@class RemoveNodeRequest;
@class RemoveNodeResponse;
@class RemoveNodesRequest;
@class RemoveNodesResponse;
@class ResolveLinkRequest;
@class ResolveLinkResponse;
@class TreeRequest;
@class TreeResponse;

#if !defined(GPB_GRPC_FORWARD_DECLARE_MESSAGE_PROTO) || !GPB_GRPC_FORWARD_DECLARE_MESSAGE_PROTO
#endif

@class GRPCUnaryProtoCall;
@class GRPCStreamingProtoCall;
@class GRPCCallOptions;
@protocol GRPCProtoResponseHandler;
@class GRPCProtoCall;


NS_ASSUME_NONNULL_BEGIN

@protocol IpfsLite2 <NSObject>

#pragma mark AddFile(stream AddFileRequest) returns (AddFileResponse)

- (GRPCStreamingProtoCall *)addFileWithResponseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions;

#pragma mark GetFile(GetFileRequest) returns (stream GetFileResponse)

- (GRPCUnaryProtoCall *)getFileWithMessage:(GetFileRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions;

#pragma mark HasBlock(HasBlockRequest) returns (HasBlockResponse)

- (GRPCUnaryProtoCall *)hasBlockWithMessage:(HasBlockRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions;

#pragma mark AddNode(AddNodeRequest) returns (AddNodeResponse)

/**
 * DAGService
 * 
 */
- (GRPCUnaryProtoCall *)addNodeWithMessage:(AddNodeRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions;

#pragma mark AddNodes(AddNodesRequest) returns (AddNodesResponse)

- (GRPCUnaryProtoCall *)addNodesWithMessage:(AddNodesRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions;

#pragma mark GetNode(GetNodeRequest) returns (GetNodeResponse)

- (GRPCUnaryProtoCall *)getNodeWithMessage:(GetNodeRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions;

#pragma mark GetNodes(GetNodesRequest) returns (stream GetNodesResponse)

- (GRPCUnaryProtoCall *)getNodesWithMessage:(GetNodesRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions;

#pragma mark RemoveNode(RemoveNodeRequest) returns (RemoveNodeResponse)

- (GRPCUnaryProtoCall *)removeNodeWithMessage:(RemoveNodeRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions;

#pragma mark RemoveNodes(RemoveNodesRequest) returns (RemoveNodesResponse)

- (GRPCUnaryProtoCall *)removeNodesWithMessage:(RemoveNodesRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions;

#pragma mark ResolveLink(ResolveLinkRequest) returns (ResolveLinkResponse)

/**
 * Node provides a ResloveLink method and the Resolver methods Resolve and Tree
 * 
 */
- (GRPCUnaryProtoCall *)resolveLinkWithMessage:(ResolveLinkRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions;

#pragma mark Tree(TreeRequest) returns (TreeResponse)

- (GRPCUnaryProtoCall *)treeWithMessage:(TreeRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions;

@end

/**
 * The methods in this protocol belong to a set of old APIs that have been deprecated. They do not
 * recognize call options provided in the initializer. Using the v2 protocol is recommended.
 */
@protocol IpfsLite <NSObject>

#pragma mark AddFile(stream AddFileRequest) returns (AddFileResponse)

- (void)addFileWithRequestsWriter:(GRXWriter *)requestWriter handler:(void(^)(AddFileResponse *_Nullable response, NSError *_Nullable error))handler;

- (GRPCProtoCall *)RPCToAddFileWithRequestsWriter:(GRXWriter *)requestWriter handler:(void(^)(AddFileResponse *_Nullable response, NSError *_Nullable error))handler;


#pragma mark GetFile(GetFileRequest) returns (stream GetFileResponse)

- (void)getFileWithRequest:(GetFileRequest *)request eventHandler:(void(^)(BOOL done, GetFileResponse *_Nullable response, NSError *_Nullable error))eventHandler;

- (GRPCProtoCall *)RPCToGetFileWithRequest:(GetFileRequest *)request eventHandler:(void(^)(BOOL done, GetFileResponse *_Nullable response, NSError *_Nullable error))eventHandler;


#pragma mark HasBlock(HasBlockRequest) returns (HasBlockResponse)

- (void)hasBlockWithRequest:(HasBlockRequest *)request handler:(void(^)(HasBlockResponse *_Nullable response, NSError *_Nullable error))handler;

- (GRPCProtoCall *)RPCToHasBlockWithRequest:(HasBlockRequest *)request handler:(void(^)(HasBlockResponse *_Nullable response, NSError *_Nullable error))handler;


#pragma mark AddNode(AddNodeRequest) returns (AddNodeResponse)

/**
 * DAGService
 * 
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (void)addNodeWithRequest:(AddNodeRequest *)request handler:(void(^)(AddNodeResponse *_Nullable response, NSError *_Nullable error))handler;

/**
 * DAGService
 * 
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (GRPCProtoCall *)RPCToAddNodeWithRequest:(AddNodeRequest *)request handler:(void(^)(AddNodeResponse *_Nullable response, NSError *_Nullable error))handler;


#pragma mark AddNodes(AddNodesRequest) returns (AddNodesResponse)

- (void)addNodesWithRequest:(AddNodesRequest *)request handler:(void(^)(AddNodesResponse *_Nullable response, NSError *_Nullable error))handler;

- (GRPCProtoCall *)RPCToAddNodesWithRequest:(AddNodesRequest *)request handler:(void(^)(AddNodesResponse *_Nullable response, NSError *_Nullable error))handler;


#pragma mark GetNode(GetNodeRequest) returns (GetNodeResponse)

- (void)getNodeWithRequest:(GetNodeRequest *)request handler:(void(^)(GetNodeResponse *_Nullable response, NSError *_Nullable error))handler;

- (GRPCProtoCall *)RPCToGetNodeWithRequest:(GetNodeRequest *)request handler:(void(^)(GetNodeResponse *_Nullable response, NSError *_Nullable error))handler;


#pragma mark GetNodes(GetNodesRequest) returns (stream GetNodesResponse)

- (void)getNodesWithRequest:(GetNodesRequest *)request eventHandler:(void(^)(BOOL done, GetNodesResponse *_Nullable response, NSError *_Nullable error))eventHandler;

- (GRPCProtoCall *)RPCToGetNodesWithRequest:(GetNodesRequest *)request eventHandler:(void(^)(BOOL done, GetNodesResponse *_Nullable response, NSError *_Nullable error))eventHandler;


#pragma mark RemoveNode(RemoveNodeRequest) returns (RemoveNodeResponse)

- (void)removeNodeWithRequest:(RemoveNodeRequest *)request handler:(void(^)(RemoveNodeResponse *_Nullable response, NSError *_Nullable error))handler;

- (GRPCProtoCall *)RPCToRemoveNodeWithRequest:(RemoveNodeRequest *)request handler:(void(^)(RemoveNodeResponse *_Nullable response, NSError *_Nullable error))handler;


#pragma mark RemoveNodes(RemoveNodesRequest) returns (RemoveNodesResponse)

- (void)removeNodesWithRequest:(RemoveNodesRequest *)request handler:(void(^)(RemoveNodesResponse *_Nullable response, NSError *_Nullable error))handler;

- (GRPCProtoCall *)RPCToRemoveNodesWithRequest:(RemoveNodesRequest *)request handler:(void(^)(RemoveNodesResponse *_Nullable response, NSError *_Nullable error))handler;


#pragma mark ResolveLink(ResolveLinkRequest) returns (ResolveLinkResponse)

/**
 * Node provides a ResloveLink method and the Resolver methods Resolve and Tree
 * 
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (void)resolveLinkWithRequest:(ResolveLinkRequest *)request handler:(void(^)(ResolveLinkResponse *_Nullable response, NSError *_Nullable error))handler;

/**
 * Node provides a ResloveLink method and the Resolver methods Resolve and Tree
 * 
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (GRPCProtoCall *)RPCToResolveLinkWithRequest:(ResolveLinkRequest *)request handler:(void(^)(ResolveLinkResponse *_Nullable response, NSError *_Nullable error))handler;


#pragma mark Tree(TreeRequest) returns (TreeResponse)

- (void)treeWithRequest:(TreeRequest *)request handler:(void(^)(TreeResponse *_Nullable response, NSError *_Nullable error))handler;

- (GRPCProtoCall *)RPCToTreeWithRequest:(TreeRequest *)request handler:(void(^)(TreeResponse *_Nullable response, NSError *_Nullable error))handler;


@end


#if !defined(GPB_GRPC_PROTOCOL_ONLY) || !GPB_GRPC_PROTOCOL_ONLY
/**
 * Basic service implementation, over gRPC, that only does
 * marshalling and parsing.
 */
@interface IpfsLite : GRPCProtoService<IpfsLite2, IpfsLite>
- (instancetype)initWithHost:(NSString *)host callOptions:(GRPCCallOptions *_Nullable)callOptions NS_DESIGNATED_INITIALIZER;
+ (instancetype)serviceWithHost:(NSString *)host callOptions:(GRPCCallOptions *_Nullable)callOptions;
// The following methods belong to a set of old APIs that have been deprecated.
- (instancetype)initWithHost:(NSString *)host;
+ (instancetype)serviceWithHost:(NSString *)host;
@end
#endif

NS_ASSUME_NONNULL_END

