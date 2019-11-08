#if !defined(GPB_GRPC_PROTOCOL_ONLY) || !GPB_GRPC_PROTOCOL_ONLY
#import "IpfsLite.pbrpc.h"
#import "IpfsLite.pbobjc.h"
#import <ProtoRPC/ProtoRPCLegacy.h>
#import <RxLibrary/GRXWriter+Immediate.h>


@implementation IpfsLite

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wobjc-designated-initializers"

// Designated initializer
- (instancetype)initWithHost:(NSString *)host callOptions:(GRPCCallOptions *_Nullable)callOptions {
  return [super initWithHost:host
                 packageName:@""
                 serviceName:@"IpfsLite"
                 callOptions:callOptions];
}

- (instancetype)initWithHost:(NSString *)host {
  return [super initWithHost:host
                 packageName:@""
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

- (void)addFileWithRequestsWriter:(GRXWriter *)requestWriter handler:(void(^)(AddFileResponse *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToAddFileWithRequestsWriter:requestWriter handler:handler] start];
}
// Returns a not-yet-started RPC object.
- (GRPCProtoCall *)RPCToAddFileWithRequestsWriter:(GRXWriter *)requestWriter handler:(void(^)(AddFileResponse *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"AddFile"
            requestsWriter:requestWriter
             responseClass:[AddFileResponse class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
- (GRPCStreamingProtoCall *)addFileWithResponseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions {
  return [self RPCToMethod:@"AddFile"
           responseHandler:handler
               callOptions:callOptions
             responseClass:[AddFileResponse class]];
}

#pragma mark GetFile(GetFileRequest) returns (stream GetFileResponse)

- (void)getFileWithRequest:(GetFileRequest *)request eventHandler:(void(^)(BOOL done, GetFileResponse *_Nullable response, NSError *_Nullable error))eventHandler{
  [[self RPCToGetFileWithRequest:request eventHandler:eventHandler] start];
}
// Returns a not-yet-started RPC object.
- (GRPCProtoCall *)RPCToGetFileWithRequest:(GetFileRequest *)request eventHandler:(void(^)(BOOL done, GetFileResponse *_Nullable response, NSError *_Nullable error))eventHandler{
  return [self RPCToMethod:@"GetFile"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[GetFileResponse class]
        responsesWriteable:[GRXWriteable writeableWithEventHandler:eventHandler]];
}
- (GRPCUnaryProtoCall *)getFileWithMessage:(GetFileRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions {
  return [self RPCToMethod:@"GetFile"
                   message:message
           responseHandler:handler
               callOptions:callOptions
             responseClass:[GetFileResponse class]];
}

#pragma mark HasBlock(HasBlockRequest) returns (HasBlockResponse)

- (void)hasBlockWithRequest:(HasBlockRequest *)request handler:(void(^)(HasBlockResponse *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToHasBlockWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
- (GRPCProtoCall *)RPCToHasBlockWithRequest:(HasBlockRequest *)request handler:(void(^)(HasBlockResponse *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"HasBlock"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[HasBlockResponse class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
- (GRPCUnaryProtoCall *)hasBlockWithMessage:(HasBlockRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions {
  return [self RPCToMethod:@"HasBlock"
                   message:message
           responseHandler:handler
               callOptions:callOptions
             responseClass:[HasBlockResponse class]];
}

#pragma mark AddNode(AddNodeRequest) returns (AddNodeResponse)

/**
 * DAGService
 * 
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (void)addNodeWithRequest:(AddNodeRequest *)request handler:(void(^)(AddNodeResponse *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToAddNodeWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
/**
 * DAGService
 * 
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (GRPCProtoCall *)RPCToAddNodeWithRequest:(AddNodeRequest *)request handler:(void(^)(AddNodeResponse *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"AddNode"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[AddNodeResponse class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
/**
 * DAGService
 * 
 */
- (GRPCUnaryProtoCall *)addNodeWithMessage:(AddNodeRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions {
  return [self RPCToMethod:@"AddNode"
                   message:message
           responseHandler:handler
               callOptions:callOptions
             responseClass:[AddNodeResponse class]];
}

#pragma mark AddNodes(AddNodesRequest) returns (AddNodesResponse)

- (void)addNodesWithRequest:(AddNodesRequest *)request handler:(void(^)(AddNodesResponse *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToAddNodesWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
- (GRPCProtoCall *)RPCToAddNodesWithRequest:(AddNodesRequest *)request handler:(void(^)(AddNodesResponse *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"AddNodes"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[AddNodesResponse class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
- (GRPCUnaryProtoCall *)addNodesWithMessage:(AddNodesRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions {
  return [self RPCToMethod:@"AddNodes"
                   message:message
           responseHandler:handler
               callOptions:callOptions
             responseClass:[AddNodesResponse class]];
}

#pragma mark GetNode(GetNodeRequest) returns (GetNodeResponse)

- (void)getNodeWithRequest:(GetNodeRequest *)request handler:(void(^)(GetNodeResponse *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToGetNodeWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
- (GRPCProtoCall *)RPCToGetNodeWithRequest:(GetNodeRequest *)request handler:(void(^)(GetNodeResponse *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"GetNode"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[GetNodeResponse class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
- (GRPCUnaryProtoCall *)getNodeWithMessage:(GetNodeRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions {
  return [self RPCToMethod:@"GetNode"
                   message:message
           responseHandler:handler
               callOptions:callOptions
             responseClass:[GetNodeResponse class]];
}

#pragma mark GetNodes(GetNodesRequest) returns (stream GetNodesResponse)

- (void)getNodesWithRequest:(GetNodesRequest *)request eventHandler:(void(^)(BOOL done, GetNodesResponse *_Nullable response, NSError *_Nullable error))eventHandler{
  [[self RPCToGetNodesWithRequest:request eventHandler:eventHandler] start];
}
// Returns a not-yet-started RPC object.
- (GRPCProtoCall *)RPCToGetNodesWithRequest:(GetNodesRequest *)request eventHandler:(void(^)(BOOL done, GetNodesResponse *_Nullable response, NSError *_Nullable error))eventHandler{
  return [self RPCToMethod:@"GetNodes"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[GetNodesResponse class]
        responsesWriteable:[GRXWriteable writeableWithEventHandler:eventHandler]];
}
- (GRPCUnaryProtoCall *)getNodesWithMessage:(GetNodesRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions {
  return [self RPCToMethod:@"GetNodes"
                   message:message
           responseHandler:handler
               callOptions:callOptions
             responseClass:[GetNodesResponse class]];
}

#pragma mark RemoveNode(RemoveNodeRequest) returns (RemoveNodeResponse)

- (void)removeNodeWithRequest:(RemoveNodeRequest *)request handler:(void(^)(RemoveNodeResponse *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToRemoveNodeWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
- (GRPCProtoCall *)RPCToRemoveNodeWithRequest:(RemoveNodeRequest *)request handler:(void(^)(RemoveNodeResponse *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"RemoveNode"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[RemoveNodeResponse class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
- (GRPCUnaryProtoCall *)removeNodeWithMessage:(RemoveNodeRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions {
  return [self RPCToMethod:@"RemoveNode"
                   message:message
           responseHandler:handler
               callOptions:callOptions
             responseClass:[RemoveNodeResponse class]];
}

#pragma mark RemoveNodes(RemoveNodesRequest) returns (RemoveNodesResponse)

- (void)removeNodesWithRequest:(RemoveNodesRequest *)request handler:(void(^)(RemoveNodesResponse *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToRemoveNodesWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
- (GRPCProtoCall *)RPCToRemoveNodesWithRequest:(RemoveNodesRequest *)request handler:(void(^)(RemoveNodesResponse *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"RemoveNodes"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[RemoveNodesResponse class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
- (GRPCUnaryProtoCall *)removeNodesWithMessage:(RemoveNodesRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions {
  return [self RPCToMethod:@"RemoveNodes"
                   message:message
           responseHandler:handler
               callOptions:callOptions
             responseClass:[RemoveNodesResponse class]];
}

#pragma mark ResolveLink(ResolveLinkRequest) returns (ResolveLinkResponse)

/**
 * Node provides a ResloveLink method and the Resolver methods Resolve and Tree
 * 
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (void)resolveLinkWithRequest:(ResolveLinkRequest *)request handler:(void(^)(ResolveLinkResponse *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToResolveLinkWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
/**
 * Node provides a ResloveLink method and the Resolver methods Resolve and Tree
 * 
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (GRPCProtoCall *)RPCToResolveLinkWithRequest:(ResolveLinkRequest *)request handler:(void(^)(ResolveLinkResponse *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"ResolveLink"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[ResolveLinkResponse class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
/**
 * Node provides a ResloveLink method and the Resolver methods Resolve and Tree
 * 
 */
- (GRPCUnaryProtoCall *)resolveLinkWithMessage:(ResolveLinkRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions {
  return [self RPCToMethod:@"ResolveLink"
                   message:message
           responseHandler:handler
               callOptions:callOptions
             responseClass:[ResolveLinkResponse class]];
}

#pragma mark Tree(TreeRequest) returns (TreeResponse)

- (void)treeWithRequest:(TreeRequest *)request handler:(void(^)(TreeResponse *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToTreeWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
- (GRPCProtoCall *)RPCToTreeWithRequest:(TreeRequest *)request handler:(void(^)(TreeResponse *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"Tree"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[TreeResponse class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
- (GRPCUnaryProtoCall *)treeWithMessage:(TreeRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions {
  return [self RPCToMethod:@"Tree"
                   message:message
           responseHandler:handler
               callOptions:callOptions
             responseClass:[TreeResponse class]];
}

@end
#endif
