#if !defined(GPB_GRPC_PROTOCOL_ONLY) || !GPB_GRPC_PROTOCOL_ONLY
#import "IpfsLite.pbrpc.h"
#import "IpfsLite.pbobjc.h"
#import <ProtoRPC/ProtoRPCLegacy.h>
#import <RxLibrary/GRXWriter+Immediate.h>


@implementation TTEIpfsLite

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wobjc-designated-initializers"

// Designated initializer
- (instancetype)initWithHost:(NSString *)host callOptions:(GRPCCallOptions *_Nullable)callOptions {
  return [super initWithHost:host
                 packageName:@"ipfs_lite"
                 serviceName:@"IpfsLite"
                 callOptions:callOptions];
}

- (instancetype)initWithHost:(NSString *)host {
  return [super initWithHost:host
                 packageName:@"ipfs_lite"
                 serviceName:@"IpfsLite"];
}

#pragma clang diagnostic pop

// Override superclass initializer to disallow different package and service names.
- (instancetype)initWithHost:(NSString *)host
                 packageName:(NSString *)packageName
                 serviceName:(NSString *)serviceName {
  return [self initWithHost:host];
}

- (instancetype)initWithHost:(NSString *)host
                 packageName:(NSString *)packageName
                 serviceName:(NSString *)serviceName
                 callOptions:(GRPCCallOptions *)callOptions {
  return [self initWithHost:host callOptions:callOptions];
}

#pragma mark - Class Methods

+ (instancetype)serviceWithHost:(NSString *)host {
  return [[self alloc] initWithHost:host];
}

+ (instancetype)serviceWithHost:(NSString *)host callOptions:(GRPCCallOptions *_Nullable)callOptions {
  return [[self alloc] initWithHost:host callOptions:callOptions];
}

#pragma mark - Method Implementations

#pragma mark AddFile(stream AddFileRequest) returns (AddFileResponse)

- (void)addFileWithRequestsWriter:(GRXWriter *)requestWriter handler:(void(^)(TTEAddFileResponse *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToAddFileWithRequestsWriter:requestWriter handler:handler] start];
}
// Returns a not-yet-started RPC object.
- (GRPCProtoCall *)RPCToAddFileWithRequestsWriter:(GRXWriter *)requestWriter handler:(void(^)(TTEAddFileResponse *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"AddFile"
            requestsWriter:requestWriter
             responseClass:[TTEAddFileResponse class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
- (GRPCStreamingProtoCall *)addFileWithResponseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions {
  return [self RPCToMethod:@"AddFile"
           responseHandler:handler
               callOptions:callOptions
             responseClass:[TTEAddFileResponse class]];
}

#pragma mark GetFile(GetFileRequest) returns (stream GetFileResponse)

- (void)getFileWithRequest:(TTEGetFileRequest *)request eventHandler:(void(^)(BOOL done, TTEGetFileResponse *_Nullable response, NSError *_Nullable error))eventHandler{
  [[self RPCToGetFileWithRequest:request eventHandler:eventHandler] start];
}
// Returns a not-yet-started RPC object.
- (GRPCProtoCall *)RPCToGetFileWithRequest:(TTEGetFileRequest *)request eventHandler:(void(^)(BOOL done, TTEGetFileResponse *_Nullable response, NSError *_Nullable error))eventHandler{
  return [self RPCToMethod:@"GetFile"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[TTEGetFileResponse class]
        responsesWriteable:[GRXWriteable writeableWithEventHandler:eventHandler]];
}
- (GRPCUnaryProtoCall *)getFileWithMessage:(TTEGetFileRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions {
  return [self RPCToMethod:@"GetFile"
                   message:message
           responseHandler:handler
               callOptions:callOptions
             responseClass:[TTEGetFileResponse class]];
}

#pragma mark HasBlock(HasBlockRequest) returns (HasBlockResponse)

- (void)hasBlockWithRequest:(TTEHasBlockRequest *)request handler:(void(^)(TTEHasBlockResponse *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToHasBlockWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
- (GRPCProtoCall *)RPCToHasBlockWithRequest:(TTEHasBlockRequest *)request handler:(void(^)(TTEHasBlockResponse *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"HasBlock"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[TTEHasBlockResponse class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
- (GRPCUnaryProtoCall *)hasBlockWithMessage:(TTEHasBlockRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions {
  return [self RPCToMethod:@"HasBlock"
                   message:message
           responseHandler:handler
               callOptions:callOptions
             responseClass:[TTEHasBlockResponse class]];
}

#pragma mark AddNode(AddNodeRequest) returns (AddNodeResponse)

/**
 * DAGService
 * 
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (void)addNodeWithRequest:(TTEAddNodeRequest *)request handler:(void(^)(TTEAddNodeResponse *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToAddNodeWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
/**
 * DAGService
 * 
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (GRPCProtoCall *)RPCToAddNodeWithRequest:(TTEAddNodeRequest *)request handler:(void(^)(TTEAddNodeResponse *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"AddNode"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[TTEAddNodeResponse class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
/**
 * DAGService
 * 
 */
- (GRPCUnaryProtoCall *)addNodeWithMessage:(TTEAddNodeRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions {
  return [self RPCToMethod:@"AddNode"
                   message:message
           responseHandler:handler
               callOptions:callOptions
             responseClass:[TTEAddNodeResponse class]];
}

#pragma mark AddNodes(AddNodesRequest) returns (AddNodesResponse)

- (void)addNodesWithRequest:(TTEAddNodesRequest *)request handler:(void(^)(TTEAddNodesResponse *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToAddNodesWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
- (GRPCProtoCall *)RPCToAddNodesWithRequest:(TTEAddNodesRequest *)request handler:(void(^)(TTEAddNodesResponse *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"AddNodes"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[TTEAddNodesResponse class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
- (GRPCUnaryProtoCall *)addNodesWithMessage:(TTEAddNodesRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions {
  return [self RPCToMethod:@"AddNodes"
                   message:message
           responseHandler:handler
               callOptions:callOptions
             responseClass:[TTEAddNodesResponse class]];
}

#pragma mark GetNode(GetNodeRequest) returns (GetNodeResponse)

- (void)getNodeWithRequest:(TTEGetNodeRequest *)request handler:(void(^)(TTEGetNodeResponse *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToGetNodeWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
- (GRPCProtoCall *)RPCToGetNodeWithRequest:(TTEGetNodeRequest *)request handler:(void(^)(TTEGetNodeResponse *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"GetNode"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[TTEGetNodeResponse class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
- (GRPCUnaryProtoCall *)getNodeWithMessage:(TTEGetNodeRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions {
  return [self RPCToMethod:@"GetNode"
                   message:message
           responseHandler:handler
               callOptions:callOptions
             responseClass:[TTEGetNodeResponse class]];
}

#pragma mark GetNodes(GetNodesRequest) returns (stream GetNodesResponse)

- (void)getNodesWithRequest:(TTEGetNodesRequest *)request eventHandler:(void(^)(BOOL done, TTEGetNodesResponse *_Nullable response, NSError *_Nullable error))eventHandler{
  [[self RPCToGetNodesWithRequest:request eventHandler:eventHandler] start];
}
// Returns a not-yet-started RPC object.
- (GRPCProtoCall *)RPCToGetNodesWithRequest:(TTEGetNodesRequest *)request eventHandler:(void(^)(BOOL done, TTEGetNodesResponse *_Nullable response, NSError *_Nullable error))eventHandler{
  return [self RPCToMethod:@"GetNodes"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[TTEGetNodesResponse class]
        responsesWriteable:[GRXWriteable writeableWithEventHandler:eventHandler]];
}
- (GRPCUnaryProtoCall *)getNodesWithMessage:(TTEGetNodesRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions {
  return [self RPCToMethod:@"GetNodes"
                   message:message
           responseHandler:handler
               callOptions:callOptions
             responseClass:[TTEGetNodesResponse class]];
}

#pragma mark RemoveNode(RemoveNodeRequest) returns (RemoveNodeResponse)

- (void)removeNodeWithRequest:(TTERemoveNodeRequest *)request handler:(void(^)(TTERemoveNodeResponse *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToRemoveNodeWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
- (GRPCProtoCall *)RPCToRemoveNodeWithRequest:(TTERemoveNodeRequest *)request handler:(void(^)(TTERemoveNodeResponse *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"RemoveNode"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[TTERemoveNodeResponse class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
- (GRPCUnaryProtoCall *)removeNodeWithMessage:(TTERemoveNodeRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions {
  return [self RPCToMethod:@"RemoveNode"
                   message:message
           responseHandler:handler
               callOptions:callOptions
             responseClass:[TTERemoveNodeResponse class]];
}

#pragma mark RemoveNodes(RemoveNodesRequest) returns (RemoveNodesResponse)

- (void)removeNodesWithRequest:(TTERemoveNodesRequest *)request handler:(void(^)(TTERemoveNodesResponse *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToRemoveNodesWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
- (GRPCProtoCall *)RPCToRemoveNodesWithRequest:(TTERemoveNodesRequest *)request handler:(void(^)(TTERemoveNodesResponse *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"RemoveNodes"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[TTERemoveNodesResponse class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
- (GRPCUnaryProtoCall *)removeNodesWithMessage:(TTERemoveNodesRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions {
  return [self RPCToMethod:@"RemoveNodes"
                   message:message
           responseHandler:handler
               callOptions:callOptions
             responseClass:[TTERemoveNodesResponse class]];
}

#pragma mark ResolveLink(ResolveLinkRequest) returns (ResolveLinkResponse)

/**
 * Node provides a ResloveLink method and the Resolver methods Resolve and Tree
 * 
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (void)resolveLinkWithRequest:(TTEResolveLinkRequest *)request handler:(void(^)(TTEResolveLinkResponse *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToResolveLinkWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
/**
 * Node provides a ResloveLink method and the Resolver methods Resolve and Tree
 * 
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (GRPCProtoCall *)RPCToResolveLinkWithRequest:(TTEResolveLinkRequest *)request handler:(void(^)(TTEResolveLinkResponse *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"ResolveLink"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[TTEResolveLinkResponse class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
/**
 * Node provides a ResloveLink method and the Resolver methods Resolve and Tree
 * 
 */
- (GRPCUnaryProtoCall *)resolveLinkWithMessage:(TTEResolveLinkRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions {
  return [self RPCToMethod:@"ResolveLink"
                   message:message
           responseHandler:handler
               callOptions:callOptions
             responseClass:[TTEResolveLinkResponse class]];
}

#pragma mark Tree(TreeRequest) returns (TreeResponse)

- (void)treeWithRequest:(TTETreeRequest *)request handler:(void(^)(TTETreeResponse *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToTreeWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
- (GRPCProtoCall *)RPCToTreeWithRequest:(TTETreeRequest *)request handler:(void(^)(TTETreeResponse *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"Tree"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[TTETreeResponse class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
- (GRPCUnaryProtoCall *)treeWithMessage:(TTETreeRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions {
  return [self RPCToMethod:@"Tree"
                   message:message
           responseHandler:handler
               callOptions:callOptions
             responseClass:[TTETreeResponse class]];
}

@end
#endif
