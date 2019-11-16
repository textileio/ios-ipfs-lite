#if !defined(GPB_GRPC_FORWARD_DECLARE_MESSAGE_PROTO) || !GPB_GRPC_FORWARD_DECLARE_MESSAGE_PROTO
#import "IpfsLite.pbobjc.h"
#endif

#if !defined(GPB_GRPC_PROTOCOL_ONLY) || !GPB_GRPC_PROTOCOL_ONLY
#import <ProtoRPC/ProtoService.h>
#import <ProtoRPC/ProtoRPCLegacy.h>
#import <RxLibrary/GRXWriteable.h>
#import <RxLibrary/GRXWriter.h>
#endif

@class TTEAddFileRequest;
@class TTEAddFileResponse;
@class TTEAddNodeRequest;
@class TTEAddNodeResponse;
@class TTEAddNodesRequest;
@class TTEAddNodesResponse;
@class TTEGetFileRequest;
@class TTEGetFileResponse;
@class TTEGetNodeRequest;
@class TTEGetNodeResponse;
@class TTEGetNodesRequest;
@class TTEGetNodesResponse;
@class TTEHasBlockRequest;
@class TTEHasBlockResponse;
@class TTERemoveNodeRequest;
@class TTERemoveNodeResponse;
@class TTERemoveNodesRequest;
@class TTERemoveNodesResponse;
@class TTEResolveLinkRequest;
@class TTEResolveLinkResponse;
@class TTETreeRequest;
@class TTETreeResponse;

#if !defined(GPB_GRPC_FORWARD_DECLARE_MESSAGE_PROTO) || !GPB_GRPC_FORWARD_DECLARE_MESSAGE_PROTO
#endif

@class GRPCUnaryProtoCall;
@class GRPCStreamingProtoCall;
@class GRPCCallOptions;
@protocol GRPCProtoResponseHandler;
@class GRPCProtoCall;


NS_ASSUME_NONNULL_BEGIN

@protocol TTEIpfsLite2 <NSObject>

#pragma mark AddFile(stream AddFileRequest) returns (AddFileResponse)

- (GRPCStreamingProtoCall *)addFileWithResponseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions;

#pragma mark GetFile(GetFileRequest) returns (stream GetFileResponse)

- (GRPCUnaryProtoCall *)getFileWithMessage:(TTEGetFileRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions;

#pragma mark HasBlock(HasBlockRequest) returns (HasBlockResponse)

- (GRPCUnaryProtoCall *)hasBlockWithMessage:(TTEHasBlockRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions;

#pragma mark AddNode(AddNodeRequest) returns (AddNodeResponse)

/**
 * DAGService
 * 
 */
- (GRPCUnaryProtoCall *)addNodeWithMessage:(TTEAddNodeRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions;

#pragma mark AddNodes(AddNodesRequest) returns (AddNodesResponse)

- (GRPCUnaryProtoCall *)addNodesWithMessage:(TTEAddNodesRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions;

#pragma mark GetNode(GetNodeRequest) returns (GetNodeResponse)

- (GRPCUnaryProtoCall *)getNodeWithMessage:(TTEGetNodeRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions;

#pragma mark GetNodes(GetNodesRequest) returns (stream GetNodesResponse)

- (GRPCUnaryProtoCall *)getNodesWithMessage:(TTEGetNodesRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions;

#pragma mark RemoveNode(RemoveNodeRequest) returns (RemoveNodeResponse)

- (GRPCUnaryProtoCall *)removeNodeWithMessage:(TTERemoveNodeRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions;

#pragma mark RemoveNodes(RemoveNodesRequest) returns (RemoveNodesResponse)

- (GRPCUnaryProtoCall *)removeNodesWithMessage:(TTERemoveNodesRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions;

#pragma mark ResolveLink(ResolveLinkRequest) returns (ResolveLinkResponse)

/**
 * Node provides a ResloveLink method and the Resolver methods Resolve and Tree
 * 
 */
- (GRPCUnaryProtoCall *)resolveLinkWithMessage:(TTEResolveLinkRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions;

#pragma mark Tree(TreeRequest) returns (TreeResponse)

- (GRPCUnaryProtoCall *)treeWithMessage:(TTETreeRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions;

@end

/**
 * The methods in this protocol belong to a set of old APIs that have been deprecated. They do not
 * recognize call options provided in the initializer. Using the v2 protocol is recommended.
 */
@protocol TTEIpfsLite <NSObject>

#pragma mark AddFile(stream AddFileRequest) returns (AddFileResponse)

- (void)addFileWithRequestsWriter:(GRXWriter *)requestWriter handler:(void(^)(TTEAddFileResponse *_Nullable response, NSError *_Nullable error))handler;

- (GRPCProtoCall *)RPCToAddFileWithRequestsWriter:(GRXWriter *)requestWriter handler:(void(^)(TTEAddFileResponse *_Nullable response, NSError *_Nullable error))handler;


#pragma mark GetFile(GetFileRequest) returns (stream GetFileResponse)

- (void)getFileWithRequest:(TTEGetFileRequest *)request eventHandler:(void(^)(BOOL done, TTEGetFileResponse *_Nullable response, NSError *_Nullable error))eventHandler;

- (GRPCProtoCall *)RPCToGetFileWithRequest:(TTEGetFileRequest *)request eventHandler:(void(^)(BOOL done, TTEGetFileResponse *_Nullable response, NSError *_Nullable error))eventHandler;


#pragma mark HasBlock(HasBlockRequest) returns (HasBlockResponse)

- (void)hasBlockWithRequest:(TTEHasBlockRequest *)request handler:(void(^)(TTEHasBlockResponse *_Nullable response, NSError *_Nullable error))handler;

- (GRPCProtoCall *)RPCToHasBlockWithRequest:(TTEHasBlockRequest *)request handler:(void(^)(TTEHasBlockResponse *_Nullable response, NSError *_Nullable error))handler;


#pragma mark AddNode(AddNodeRequest) returns (AddNodeResponse)

/**
 * DAGService
 * 
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (void)addNodeWithRequest:(TTEAddNodeRequest *)request handler:(void(^)(TTEAddNodeResponse *_Nullable response, NSError *_Nullable error))handler;

/**
 * DAGService
 * 
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (GRPCProtoCall *)RPCToAddNodeWithRequest:(TTEAddNodeRequest *)request handler:(void(^)(TTEAddNodeResponse *_Nullable response, NSError *_Nullable error))handler;


#pragma mark AddNodes(AddNodesRequest) returns (AddNodesResponse)

- (void)addNodesWithRequest:(TTEAddNodesRequest *)request handler:(void(^)(TTEAddNodesResponse *_Nullable response, NSError *_Nullable error))handler;

- (GRPCProtoCall *)RPCToAddNodesWithRequest:(TTEAddNodesRequest *)request handler:(void(^)(TTEAddNodesResponse *_Nullable response, NSError *_Nullable error))handler;


#pragma mark GetNode(GetNodeRequest) returns (GetNodeResponse)

- (void)getNodeWithRequest:(TTEGetNodeRequest *)request handler:(void(^)(TTEGetNodeResponse *_Nullable response, NSError *_Nullable error))handler;

- (GRPCProtoCall *)RPCToGetNodeWithRequest:(TTEGetNodeRequest *)request handler:(void(^)(TTEGetNodeResponse *_Nullable response, NSError *_Nullable error))handler;


#pragma mark GetNodes(GetNodesRequest) returns (stream GetNodesResponse)

- (void)getNodesWithRequest:(TTEGetNodesRequest *)request eventHandler:(void(^)(BOOL done, TTEGetNodesResponse *_Nullable response, NSError *_Nullable error))eventHandler;

- (GRPCProtoCall *)RPCToGetNodesWithRequest:(TTEGetNodesRequest *)request eventHandler:(void(^)(BOOL done, TTEGetNodesResponse *_Nullable response, NSError *_Nullable error))eventHandler;


#pragma mark RemoveNode(RemoveNodeRequest) returns (RemoveNodeResponse)

- (void)removeNodeWithRequest:(TTERemoveNodeRequest *)request handler:(void(^)(TTERemoveNodeResponse *_Nullable response, NSError *_Nullable error))handler;

- (GRPCProtoCall *)RPCToRemoveNodeWithRequest:(TTERemoveNodeRequest *)request handler:(void(^)(TTERemoveNodeResponse *_Nullable response, NSError *_Nullable error))handler;


#pragma mark RemoveNodes(RemoveNodesRequest) returns (RemoveNodesResponse)

- (void)removeNodesWithRequest:(TTERemoveNodesRequest *)request handler:(void(^)(TTERemoveNodesResponse *_Nullable response, NSError *_Nullable error))handler;

- (GRPCProtoCall *)RPCToRemoveNodesWithRequest:(TTERemoveNodesRequest *)request handler:(void(^)(TTERemoveNodesResponse *_Nullable response, NSError *_Nullable error))handler;


#pragma mark ResolveLink(ResolveLinkRequest) returns (ResolveLinkResponse)

/**
 * Node provides a ResloveLink method and the Resolver methods Resolve and Tree
 * 
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (void)resolveLinkWithRequest:(TTEResolveLinkRequest *)request handler:(void(^)(TTEResolveLinkResponse *_Nullable response, NSError *_Nullable error))handler;

/**
 * Node provides a ResloveLink method and the Resolver methods Resolve and Tree
 * 
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (GRPCProtoCall *)RPCToResolveLinkWithRequest:(TTEResolveLinkRequest *)request handler:(void(^)(TTEResolveLinkResponse *_Nullable response, NSError *_Nullable error))handler;


#pragma mark Tree(TreeRequest) returns (TreeResponse)

- (void)treeWithRequest:(TTETreeRequest *)request handler:(void(^)(TTETreeResponse *_Nullable response, NSError *_Nullable error))handler;

- (GRPCProtoCall *)RPCToTreeWithRequest:(TTETreeRequest *)request handler:(void(^)(TTETreeResponse *_Nullable response, NSError *_Nullable error))handler;


@end


#if !defined(GPB_GRPC_PROTOCOL_ONLY) || !GPB_GRPC_PROTOCOL_ONLY
/**
 * Basic service implementation, over gRPC, that only does
 * marshalling and parsing.
 */
@interface TTEIpfsLite : GRPCProtoService<TTEIpfsLite2, TTEIpfsLite>
- (instancetype)initWithHost:(NSString *)host callOptions:(GRPCCallOptions *_Nullable)callOptions NS_DESIGNATED_INITIALIZER;
+ (instancetype)serviceWithHost:(NSString *)host callOptions:(GRPCCallOptions *_Nullable)callOptions;
// The following methods belong to a set of old APIs that have been deprecated.
- (instancetype)initWithHost:(NSString *)host;
+ (instancetype)serviceWithHost:(NSString *)host;
@end
#endif

NS_ASSUME_NONNULL_END

