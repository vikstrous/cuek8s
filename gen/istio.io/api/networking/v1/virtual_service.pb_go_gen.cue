// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go istio.io/api/networking/v1

package v1

import "github.com/vikstrous/cuek8s/gen/google.golang.org/protobuf/types/known/durationpb"

#HTTPRedirect_RedirectPortSelection: int32 // #enumHTTPRedirect_RedirectPortSelection

#enumHTTPRedirect_RedirectPortSelection:
	#HTTPRedirect_FROM_PROTOCOL_DEFAULT |
	#HTTPRedirect_FROM_REQUEST_PORT

#values_HTTPRedirect_RedirectPortSelection: {
	HTTPRedirect_FROM_PROTOCOL_DEFAULT: #HTTPRedirect_FROM_PROTOCOL_DEFAULT
	HTTPRedirect_FROM_REQUEST_PORT:     #HTTPRedirect_FROM_REQUEST_PORT
}

#HTTPRedirect_FROM_PROTOCOL_DEFAULT: #HTTPRedirect_RedirectPortSelection & 0
#HTTPRedirect_FROM_REQUEST_PORT:     #HTTPRedirect_RedirectPortSelection & 1

// Configuration affecting traffic routing.
//
// <!-- crd generation tags
// +cue-gen:VirtualService:groupName:networking.istio.io
// +cue-gen:VirtualService:version:v1
// +cue-gen:VirtualService:annotations:helm.sh/resource-policy=keep
// +cue-gen:VirtualService:labels:app=istio-pilot,chart=istio,heritage=Tiller,release=istio
// +cue-gen:VirtualService:subresource:status
// +cue-gen:VirtualService:scope:Namespaced
// +cue-gen:VirtualService:resource:categories=istio-io,networking-istio-io,shortNames=vs
// +cue-gen:VirtualService:printerColumn:name=Gateways,type=string,JSONPath=.spec.gateways,description="The names of gateways and sidecars
// that should apply these routes"
// +cue-gen:VirtualService:printerColumn:name=Hosts,type=string,JSONPath=.spec.hosts,description="The destination hosts to which traffic is being sent"
// +cue-gen:VirtualService:printerColumn:name=Age,type=date,JSONPath=.metadata.creationTimestamp,description="CreationTimestamp is a timestamp
// representing the server time when this object was created. It is not guaranteed to be set in happens-before order across separate operations.
// Clients may not set this value. It is represented in RFC3339 form and is in UTC.
// Populated by the system. Read-only. Null for lists. More info: https://git.k8s.io/community/contributors/devel/api-conventions.md#metadata"
// +cue-gen:VirtualService:preserveUnknownFields:false
// -->
//
// <!-- go code generation tags
// +kubetype-gen
// +kubetype-gen:groupVersion=networking.istio.io/v1
// +genclient
// +k8s:deepcopy-gen=true
// -->
// <!-- istio code generation tags
// +istio.io/sync-from:networking/v1alpha3/virtual_service.proto
// -->
#VirtualService: _

// Destination indicates the network addressable service to which the
// request/connection will be sent after processing a routing rule. The
// destination.host should unambiguously refer to a service in the service
// registry. Istio's service registry is composed of all the services found
// in the platform's service registry (e.g., Kubernetes services, Consul
// services), as well as services declared through the
// [ServiceEntry](https://istio.io/docs/reference/config/networking/service-entry/#ServiceEntry) resource.
//
// *Note for Kubernetes users*: When short names are used (e.g. "reviews"
// instead of "reviews.default.svc.cluster.local"), Istio will interpret
// the short name based on the namespace of the rule, not the service. A
// rule in the "default" namespace containing a host "reviews will be
// interpreted as "reviews.default.svc.cluster.local", irrespective of the
// actual namespace associated with the reviews service. _To avoid potential
// misconfigurations, it is recommended to always use fully qualified
// domain names over short names._
//
// The following Kubernetes example routes all traffic by default to pods
// of the reviews service with label "version: v1" (i.e., subset v1), and
// some to subset v2, in a Kubernetes environment.
//
// ```yaml
// apiVersion: networking.istio.io/v1
// kind: VirtualService
// metadata:
//
//	name: reviews-route
//	namespace: foo
//
// spec:
//
//	hosts:
//	- reviews # interpreted as reviews.foo.svc.cluster.local
//	http:
//	- match:
//	  - uri:
//	      prefix: "/wpcatalog"
//	  - uri:
//	      prefix: "/consumercatalog"
//	  rewrite:
//	    uri: "/newcatalog"
//	  route:
//	  - destination:
//	      host: reviews # interpreted as reviews.foo.svc.cluster.local
//	      subset: v2
//	- route:
//	  - destination:
//	      host: reviews # interpreted as reviews.foo.svc.cluster.local
//	      subset: v1
//
// ```
//
// # And the associated DestinationRule
//
// ```yaml
// apiVersion: networking.istio.io/v1
// kind: DestinationRule
// metadata:
//
//	name: reviews-destination
//	namespace: foo
//
// spec:
//
//	host: reviews # interpreted as reviews.foo.svc.cluster.local
//	subsets:
//	- name: v1
//	  labels:
//	    version: v1
//	- name: v2
//	  labels:
//	    version: v2
//
// ```
//
// The following VirtualService sets a timeout of 5s for all calls to
// productpage.prod.svc.cluster.local service in Kubernetes. Notice that
// there are no subsets defined in this rule. Istio will fetch all
// instances of productpage.prod.svc.cluster.local service from the service
// registry and populate the sidecar's load balancing pool. Also, notice
// that this rule is set in the istio-system namespace but uses the fully
// qualified domain name of the productpage service,
// productpage.prod.svc.cluster.local. Therefore the rule's namespace does
// not have an impact in resolving the name of the productpage service.
//
// ```yaml
// apiVersion: networking.istio.io/v1
// kind: VirtualService
// metadata:
//
//	name: my-productpage-rule
//	namespace: istio-system
//
// spec:
//
//	hosts:
//	- productpage.prod.svc.cluster.local # ignores rule namespace
//	http:
//	- timeout: 5s
//	  route:
//	  - destination:
//	      host: productpage.prod.svc.cluster.local
//
// ```
//
// To control routing for traffic bound to services outside the mesh, external
// services must first be added to Istio's internal service registry using the
// ServiceEntry resource. VirtualServices can then be defined to control traffic
// bound to these external services. For example, the following rules define a
// Service for wikipedia.org and set a timeout of 5s for HTTP requests.
//
// ```yaml
// apiVersion: networking.istio.io/v1
// kind: ServiceEntry
// metadata:
//
//	name: external-svc-wikipedia
//
// spec:
//
//	hosts:
//	- wikipedia.org
//	location: MESH_EXTERNAL
//	ports:
//	- number: 80
//	  name: example-http
//	  protocol: HTTP
//	resolution: DNS
//
// ---
// apiVersion: networking.istio.io/v1
// kind: VirtualService
// metadata:
//
//	name: my-wiki-rule
//
// spec:
//
//	hosts:
//	- wikipedia.org
//	http:
//	- timeout: 5s
//	  route:
//	  - destination:
//	      host: wikipedia.org
//
// ```
#Destination: _

// Describes match conditions and actions for routing HTTP/1.1, HTTP2, and
// gRPC traffic. See VirtualService for usage examples.
#HTTPRoute: _

// Describes the delegate VirtualService.
// The following routing rules forward the traffic to `/productpage` by a delegate VirtualService named `productpage`,
// forward the traffic to `/reviews` by a delegate VirtualService named `reviews`.
//
// ```yaml
// apiVersion: networking.istio.io/v1
// kind: VirtualService
// metadata:
//
//	name: bookinfo
//
// spec:
//
//	hosts:
//	- "bookinfo.com"
//	gateways:
//	- mygateway
//	http:
//	- match:
//	  - uri:
//	      prefix: "/productpage"
//	  delegate:
//	     name: productpage
//	     namespace: nsA
//	- match:
//	  - uri:
//	      prefix: "/reviews"
//	  delegate:
//	      name: reviews
//	      namespace: nsB
//
// ```
//
// ```yaml
// apiVersion: networking.istio.io/v1
// kind: VirtualService
// metadata:
//
//	name: productpage
//	namespace: nsA
//
// spec:
//
//	http:
//	- match:
//	   - uri:
//	      prefix: "/productpage/v1/"
//	  route:
//	  - destination:
//	      host: productpage-v1.nsA.svc.cluster.local
//	- route:
//	  - destination:
//	      host: productpage.nsA.svc.cluster.local
//
// ```
//
// ```yaml
// apiVersion: networking.istio.io/v1
// kind: VirtualService
// metadata:
//
//	name: reviews
//	namespace: nsB
//
// spec:
//
//	http:
//	- route:
//	  - destination:
//	      host: reviews.nsB.svc.cluster.local
//
// ```
#Delegate: _

// Message headers can be manipulated when Envoy forwards requests to,
// or responses from, a destination service. Header manipulation rules can
// be specified for a specific route destination or for all destinations.
// The following VirtualService adds a `test` header with the value `true`
// to requests that are routed to any `reviews` service destination.
// It also removes the `foo` response header, but only from responses
// coming from the `v1` subset (version) of the `reviews` service.
//
// ```yaml
// apiVersion: networking.istio.io/v1
// kind: VirtualService
// metadata:
//
//	name: reviews-route
//
// spec:
//
//	hosts:
//	- reviews.prod.svc.cluster.local
//	http:
//	- headers:
//	    request:
//	      set:
//	        test: "true"
//	  route:
//	  - destination:
//	      host: reviews.prod.svc.cluster.local
//	      subset: v2
//	    weight: 25
//	  - destination:
//	      host: reviews.prod.svc.cluster.local
//	      subset: v1
//	    headers:
//	      response:
//	        remove:
//	        - foo
//	    weight: 75
//
// ```
#Headers: _

// Describes match conditions and actions for routing unterminated TLS
// traffic (TLS/HTTPS) The following routing rule forwards unterminated TLS
// traffic arriving at port 443 of gateway called "mygateway" to internal
// services in the mesh based on the SNI value.
//
// ```yaml
// apiVersion: networking.istio.io/v1
// kind: VirtualService
// metadata:
//
//	name: bookinfo-sni
//
// spec:
//
//	hosts:
//	- "*.bookinfo.com"
//	gateways:
//	- mygateway
//	tls:
//	- match:
//	  - port: 443
//	    sniHosts:
//	    - login.bookinfo.com
//	  route:
//	  - destination:
//	      host: login.prod.svc.cluster.local
//	- match:
//	  - port: 443
//	    sniHosts:
//	    - reviews.bookinfo.com
//	  route:
//	  - destination:
//	      host: reviews.prod.svc.cluster.local
//
// ```
#TLSRoute: _

// Describes match conditions and actions for routing TCP traffic. The
// following routing rule forwards traffic arriving at port 27017 for
// mongo.prod.svc.cluster.local to another Mongo server on port 5555.
//
// ```yaml
// apiVersion: networking.istio.io/v1
// kind: VirtualService
// metadata:
//
//	name: bookinfo-mongo
//
// spec:
//
//	hosts:
//	- mongo.prod.svc.cluster.local
//	tcp:
//	- match:
//	  - port: 27017
//	  route:
//	  - destination:
//	      host: mongo.backup.svc.cluster.local
//	      port:
//	        number: 5555
//
// ```
#TCPRoute: _

// HttpMatchRequest specifies a set of criterion to be met in order for the
// rule to be applied to the HTTP request. For example, the following
// restricts the rule to match only requests where the URL path
// starts with /ratings/v2/ and the request contains a custom `end-user` header
// with value `jason`.
//
// ```yaml
// apiVersion: networking.istio.io/v1
// kind: VirtualService
// metadata:
//
//	name: ratings-route
//
// spec:
//
//	hosts:
//	- ratings.prod.svc.cluster.local
//	http:
//	- match:
//	  - headers:
//	      end-user:
//	        exact: jason
//	    uri:
//	      prefix: "/ratings/v2/"
//	    ignoreUriCase: true
//	  route:
//	  - destination:
//	      host: ratings.prod.svc.cluster.local
//
// ```
//
// HTTPMatchRequest CANNOT be empty.
// **Note:**
// 1. If a root VirtualService have matched any property (path, header etc.) by regex, delegate VirtualServices should not have any other matches on the same property.
// 2. If a delegate VirtualService have matched any property (path, header etc.) by regex, root VirtualServices should not have any other matches on the same property.
#HTTPMatchRequest: _

// Each routing rule is associated with one or more service versions (see
// glossary in beginning of document). Weights associated with the version
// determine the proportion of traffic it receives. For example, the
// following rule will route 25% of traffic for the "reviews" service to
// instances with the "v2" tag and the remaining traffic (i.e., 75%) to
// "v1".
//
// ```yaml
// apiVersion: networking.istio.io/v1
// kind: VirtualService
// metadata:
//
//	name: reviews-route
//
// spec:
//
//	hosts:
//	- reviews.prod.svc.cluster.local
//	http:
//	- route:
//	  - destination:
//	      host: reviews.prod.svc.cluster.local
//	      subset: v2
//	    weight: 25
//	  - destination:
//	      host: reviews.prod.svc.cluster.local
//	      subset: v1
//	    weight: 75
//
// ```
//
// # And the associated DestinationRule
//
// ```yaml
// apiVersion: networking.istio.io/v1
// kind: DestinationRule
// metadata:
//
//	name: reviews-destination
//
// spec:
//
//	host: reviews.prod.svc.cluster.local
//	subsets:
//	- name: v1
//	  labels:
//	    version: v1
//	- name: v2
//	  labels:
//	    version: v2
//
// ```
//
// Traffic can also be split across two entirely different services without
// having to define new subsets. For example, the following rule forwards 25% of
// traffic to reviews.com to dev.reviews.com
//
// ```yaml
// apiVersion: networking.istio.io/v1
// kind: VirtualService
// metadata:
//
//	name: reviews-route-two-domains
//
// spec:
//
//	hosts:
//	- reviews.com
//	http:
//	- route:
//	  - destination:
//	      host: dev.reviews.com
//	    weight: 25
//	  - destination:
//	      host: reviews.com
//	    weight: 75
//
// ```
#HTTPRouteDestination: _

// L4 routing rule weighted destination.
#RouteDestination: _

// L4 connection match attributes. Note that L4 connection matching support
// is incomplete.
#L4MatchAttributes: _

// TLS connection match attributes.
#TLSMatchAttributes: _

// HTTPRedirect can be used to send a 301 redirect response to the caller,
// where the Authority/Host and the URI in the response can be swapped with
// the specified values. For example, the following rule redirects
// requests for /v1/getProductRatings API on the ratings service to
// /v1/bookRatings provided by the bookratings service.
//
// ```yaml
// apiVersion: networking.istio.io/v1
// kind: VirtualService
// metadata:
//
//	name: ratings-route
//
// spec:
//
//	hosts:
//	- ratings.prod.svc.cluster.local
//	http:
//	- match:
//	  - uri:
//	      exact: /v1/getProductRatings
//	  redirect:
//	    uri: /v1/bookRatings
//	    authority: newratings.default.svc.cluster.local
//	...
//
// ```
#HTTPRedirect: _

_#isHTTPRedirect_RedirectPort: _

#HTTPRedirect_Port: {
	// On a redirect, overwrite the port portion of the URL with this value.
	Port: uint32 @protobuf(4,varint,opt,name=port,proto3,oneof)
}

#HTTPRedirect_DerivePort: {
	// On a redirect, dynamically set the port:
	// * FROM_PROTOCOL_DEFAULT: automatically set to 80 for HTTP and 443 for HTTPS.
	// * FROM_REQUEST_PORT: automatically use the port of the request.
	DerivePort: #HTTPRedirect_RedirectPortSelection @protobuf(5,varint,opt,name=derive_port,json=derivePort,proto3,enum=istio.networking.v1.HTTPRedirect_RedirectPortSelection,oneof)
}

// HTTPDirectResponse can be used to send a fixed response to clients.
// For example, the following rule returns a fixed 503 status with a body
// to requests for /v1/getProductRatings API.
//
// ```yaml
// apiVersion: networking.istio.io/v1
// kind: VirtualService
// metadata:
//
//	name: ratings-route
//
// spec:
//
//	hosts:
//	- ratings.prod.svc.cluster.local
//	http:
//	- match:
//	  - uri:
//	      exact: /v1/getProductRatings
//	  directResponse:
//	    status: 503
//	    body:
//	      string: "unknown error"
//	...
//
// ```
//
// It is also possible to specify a binary response body.
// This is mostly useful for non text-based protocols such as gRPC.
//
// ```yaml
// apiVersion: networking.istio.io/v1
// kind: VirtualService
// metadata:
//
//	name: ratings-route
//
// spec:
//
//	hosts:
//	- ratings.prod.svc.cluster.local
//	http:
//	- match:
//	  - uri:
//	      exact: /v1/getProductRatings
//	  directResponse:
//	    status: 503
//	    body:
//	      bytes: "dW5rbm93biBlcnJvcg==" # "unknown error" in base64
//	...
//
// ```
//
// It is good practice to add headers in the HTTPRoute
// as well as the direct_response, for example to specify
// the returned Content-Type.
//
// ```yaml
// apiVersion: networking.istio.io/v1
// kind: VirtualService
// metadata:
//
//	name: ratings-route
//
// spec:
//
//	hosts:
//	- ratings.prod.svc.cluster.local
//	http:
//	- match:
//	  - uri:
//	      exact: /v1/getProductRatings
//	  directResponse:
//	    status: 503
//	    body:
//	      string: "{\"error\": \"unknown error\"}"
//	  headers:
//	    response:
//	      set:
//	        content-type: "text/plain"
//	...
//
// ```
#HTTPDirectResponse: _

#HTTPBody: _

_#isHTTPBody_Specifier: _

#HTTPBody_String_: {
	// response body as a string
	String_: string @protobuf(1,bytes,opt,name=string,proto3,oneof)
}

#HTTPBody_Bytes: {
	// response body as base64 encoded bytes.
	Bytes: bytes @go(,[]byte) @protobuf(2,bytes,opt,name=bytes,proto3,oneof)
}

// HTTPRewrite can be used to rewrite specific parts of a HTTP request
// before forwarding the request to the destination. Rewrite primitive can
// be used only with HTTPRouteDestination. The following example
// demonstrates how to rewrite the URL prefix for api call (/ratings) to
// ratings service before making the actual API call.
//
// ```yaml
// apiVersion: networking.istio.io/v1
// kind: VirtualService
// metadata:
//
//	name: ratings-route
//
// spec:
//
//	hosts:
//	- ratings.prod.svc.cluster.local
//	http:
//	- match:
//	  - uri:
//	      prefix: /ratings
//	  rewrite:
//	    uri: /v1/bookRatings
//	  route:
//	  - destination:
//	      host: ratings.prod.svc.cluster.local
//	      subset: v1
//
// ```
#HTTPRewrite: _

#RegexRewrite: _

// Describes how to match a given string in HTTP headers. Match is
// case-sensitive.
#StringMatch: _

_#isStringMatch_MatchType: _

#StringMatch_Exact: {
	// exact string match
	Exact: string @protobuf(1,bytes,opt,name=exact,proto3,oneof)
}

#StringMatch_Prefix: {
	// prefix-based match
	Prefix: string @protobuf(2,bytes,opt,name=prefix,proto3,oneof)
}

#StringMatch_Regex: {
	// RE2 style regex-based match (https://github.com/google/re2/wiki/Syntax).
	Regex: string @protobuf(3,bytes,opt,name=regex,proto3,oneof)
}

// Describes the retry policy to use when a HTTP request fails. For
// example, the following rule sets the maximum number of retries to 3 when
// calling ratings:v1 service, with a 2s timeout per retry attempt.
// A retry will be attempted if there is a connect-failure, refused_stream
// or when the upstream server responds with Service Unavailable(503).
//
// ```yaml
// apiVersion: networking.istio.io/v1
// kind: VirtualService
// metadata:
//
//	name: ratings-route
//
// spec:
//
//	hosts:
//	- ratings.prod.svc.cluster.local
//	http:
//	- route:
//	  - destination:
//	      host: ratings.prod.svc.cluster.local
//	      subset: v1
//	  retries:
//	    attempts: 3
//	    perTryTimeout: 2s
//	    retryOn: gateway-error,connect-failure,refused-stream
//
// ```
#HTTPRetry: _

// Describes the Cross-Origin Resource Sharing (CORS) policy, for a given
// service. Refer to [CORS](https://developer.mozilla.org/en-US/docs/Web/HTTP/Access_control_CORS)
// for further details about cross origin resource sharing. For example,
// the following rule restricts cross origin requests to those originating
// from example.com domain using HTTP POST/GET, and sets the
// `Access-Control-Allow-Credentials` header to false. In addition, it only
// exposes `X-Foo-bar` header and sets an expiry period of 1 day.
//
// ```yaml
// apiVersion: networking.istio.io/v1
// kind: VirtualService
// metadata:
//
//	name: ratings-route
//
// spec:
//
//	hosts:
//	- ratings.prod.svc.cluster.local
//	http:
//	- route:
//	  - destination:
//	      host: ratings.prod.svc.cluster.local
//	      subset: v1
//	  corsPolicy:
//	    allowOrigins:
//	    - exact: https://example.com
//	    allowMethods:
//	    - POST
//	    - GET
//	    allowCredentials: false
//	    allowHeaders:
//	    - X-Foo-Bar
//	    maxAge: "24h"
//
// ```
#CorsPolicy: _

// HTTPFaultInjection can be used to specify one or more faults to inject
// while forwarding HTTP requests to the destination specified in a route.
// Fault specification is part of a VirtualService rule. Faults include
// aborting the Http request from downstream service, and/or delaying
// proxying of requests. A fault rule MUST HAVE delay or abort or both.
//
// *Note:* Delay and abort faults are independent of one another, even if
// both are specified simultaneously.
#HTTPFaultInjection: _

// HTTPMirrorPolicy can be used to specify the destinations to mirror HTTP traffic in addition
// to the original destination. Mirrored traffic is on a
// best effort basis where the sidecar/gateway will not wait for the
// mirrored destinations to respond before returning the response from the
// original destination. Statistics will be generated for the mirrored
// destination.
#HTTPMirrorPolicy: _

// PortSelector specifies the number of a port to be used for
// matching or selection for final routing.
#PortSelector: _

// Percent specifies a percentage in the range of [0.0, 100.0].
#Percent: _

// HeaderOperations Describes the header manipulations to apply
#Headers_HeaderOperations: _

// Delay specification is used to inject latency into the request
// forwarding path. The following example will introduce a 5 second delay
// in 1 out of every 1000 requests to the "v1" version of the "reviews"
// service from all pods with label env: prod
//
// ```yaml
// apiVersion: networking.istio.io/v1
// kind: VirtualService
// metadata:
//
//	name: reviews-route
//
// spec:
//
//	hosts:
//	- reviews.prod.svc.cluster.local
//	http:
//	- match:
//	  - sourceLabels:
//	      env: prod
//	  route:
//	  - destination:
//	      host: reviews.prod.svc.cluster.local
//	      subset: v1
//	  fault:
//	    delay:
//	      percentage:
//	        value: 0.1
//	      fixedDelay: 5s
//
// ```
//
// The _fixedDelay_ field is used to indicate the amount of delay in seconds.
// The optional _percentage_ field can be used to only delay a certain
// percentage of requests. If left unspecified, no request will be delayed.
#HTTPFaultInjection_Delay: _

_#isHTTPFaultInjection_Delay_HttpDelayType: _

#HTTPFaultInjection_Delay_FixedDelay: {
	// Add a fixed delay before forwarding the request. Format:
	// 1h/1m/1s/1ms. MUST be >=1ms.
	FixedDelay?: null | durationpb.#Duration @go(,*google.golang.org/protobuf/types/known/durationpb.Duration) @protobuf(2,bytes,opt,name=fixed_delay,json=fixedDelay,proto3,oneof)
}

#HTTPFaultInjection_Delay_ExponentialDelay: {
	// $hide_from_docs
	ExponentialDelay?: null | durationpb.#Duration @go(,*google.golang.org/protobuf/types/known/durationpb.Duration) @protobuf(3,bytes,opt,name=exponential_delay,json=exponentialDelay,proto3,oneof)
}

// Abort specification is used to prematurely abort a request with a
// pre-specified error code. The following example will return an HTTP 400
// error code for 1 out of every 1000 requests to the "ratings" service "v1".
//
// ```yaml
// apiVersion: networking.istio.io/v1
// kind: VirtualService
// metadata:
//
//	name: ratings-route
//
// spec:
//
//	hosts:
//	- ratings.prod.svc.cluster.local
//	http:
//	- route:
//	  - destination:
//	      host: ratings.prod.svc.cluster.local
//	      subset: v1
//	  fault:
//	    abort:
//	      percentage:
//	        value: 0.1
//	      httpStatus: 400
//
// ```
//
// The _httpStatus_ field is used to indicate the HTTP status code to
// return to the caller. The optional _percentage_ field can be used to only
// abort a certain percentage of requests. If not specified, no request will be
// aborted.
#HTTPFaultInjection_Abort: _

_#isHTTPFaultInjection_Abort_ErrorType: _

#HTTPFaultInjection_Abort_HttpStatus: {
	// HTTP status code to use to abort the Http request.
	HttpStatus: int32 @protobuf(2,varint,opt,name=http_status,json=httpStatus,proto3,oneof)
}

#HTTPFaultInjection_Abort_GrpcStatus: {
	// GRPC status code to use to abort the request. The supported
	// codes are documented in https://github.com/grpc/grpc/blob/master/doc/statuscodes.md
	// Note: If you want to return the status "Unavailable", then you should
	// specify the code as `UNAVAILABLE`(all caps), but not `14`.
	GrpcStatus: string @protobuf(3,bytes,opt,name=grpc_status,json=grpcStatus,proto3,oneof)
}

#HTTPFaultInjection_Abort_Http2Error: {
	// $hide_from_docs
	Http2Error: string @protobuf(4,bytes,opt,name=http2_error,json=http2Error,proto3,oneof)
}
