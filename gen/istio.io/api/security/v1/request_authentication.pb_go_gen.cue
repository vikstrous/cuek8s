// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go istio.io/api/security/v1

package v1

// RequestAuthentication defines what request authentication methods are supported by a workload.
// It will reject a request if the request contains invalid authentication information, based on the
// configured authentication rules. A request that does not contain any authentication credentials
// will be accepted but will not have any authenticated identity. To restrict access to authenticated
// requests only, this should be accompanied by an authorization rule.
// Examples:
//
// - Require JWT for all request for workloads that have label `app:httpbin`
//
// ```yaml
// apiVersion: security.istio.io/v1
// kind: RequestAuthentication
// metadata:
//
//	name: httpbin
//	namespace: foo
//
// spec:
//
//	selector:
//	  matchLabels:
//	    app: httpbin
//	jwtRules:
//	- issuer: "issuer-foo"
//	  jwksUri: https://example.com/.well-known/jwks.json
//
// ---
// apiVersion: security.istio.io/v1
// kind: AuthorizationPolicy
// metadata:
//
//	name: httpbin
//	namespace: foo
//
// spec:
//
//	selector:
//	  matchLabels:
//	    app: httpbin
//	rules:
//	- from:
//	  - source:
//	      requestPrincipals: ["*"]
//
// ```
//
// - A policy in the root namespace ("istio-system" by default) applies to workloads in all namespaces
// in a mesh. The following policy makes all workloads only accept requests that contain a
// valid JWT token.
//
// ```yaml
// apiVersion: security.istio.io/v1
// kind: RequestAuthentication
// metadata:
//
//	name: req-authn-for-all
//	namespace: istio-system
//
// spec:
//
//	jwtRules:
//	- issuer: "issuer-foo"
//	  jwksUri: https://example.com/.well-known/jwks.json
//
// ---
// apiVersion: security.istio.io/v1
// kind: AuthorizationPolicy
// metadata:
//
//	name: require-jwt-for-all
//	namespace: istio-system
//
// spec:
//
//	rules:
//	- from:
//	  - source:
//	      requestPrincipals: ["*"]
//
// ```
//
// - The next example shows how to set a different JWT requirement for a different `host`. The `RequestAuthentication`
// declares it can accept JWTs issued by either `issuer-foo` or `issuer-bar` (the public key set is implicitly
// set from the OpenID Connect spec).
//
// ```yaml
// apiVersion: security.istio.io/v1
// kind: RequestAuthentication
// metadata:
//
//	name: httpbin
//	namespace: foo
//
// spec:
//
//	selector:
//	  matchLabels:
//	    app: httpbin
//	jwtRules:
//	- issuer: "issuer-foo"
//	- issuer: "issuer-bar"
//
// ---
// apiVersion: security.istio.io/v1
// kind: AuthorizationPolicy
// metadata:
//
//	name: httpbin
//	namespace: foo
//
// spec:
//
//	selector:
//	  matchLabels:
//	    app: httpbin
//	rules:
//	- from:
//	  - source:
//	      requestPrincipals: ["issuer-foo/*"]
//	  to:
//	  - operation:
//	      hosts: ["example.com"]
//	- from:
//	  - source:
//	      requestPrincipals: ["issuer-bar/*"]
//	  to:
//	  - operation:
//	      hosts: ["another-host.com"]
//
// ```
//
// - You can fine tune the authorization policy to set different requirement per path. For example,
// to require JWT on all paths, except /healthz, the same `RequestAuthentication` can be used, but the
// authorization policy could be:
//
// ```yaml
// apiVersion: security.istio.io/v1
// kind: AuthorizationPolicy
// metadata:
//
//	name: httpbin
//	namespace: foo
//
// spec:
//
//	selector:
//	  matchLabels:
//	    app: httpbin
//	rules:
//	- from:
//	  - source:
//	      requestPrincipals: ["*"]
//	- to:
//	  - operation:
//	      paths: ["/healthz"]
//
// ```
//
// [Experimental] Routing based on derived [metadata](https://istio.io/latest/docs/reference/config/security/conditions/)
// is now supported. A prefix '@' is used to denote a match against internal metadata instead of the headers in the request.
// Currently this feature is only supported for the following metadata:
//
// - `request.auth.claims.{claim-name}[.{nested-claim}]*` which are extracted from validated JWT tokens.
// Use the `.` or `[]` as a separator for nested claim names.
// Examples: `request.auth.claims.sub`, `request.auth.claims.name.givenName` and `request.auth.claims[foo.com/name]`.
// For more information, see [JWT claim based routing](https://istio.io/latest/docs/tasks/security/authentication/jwt-route/).
//
// The use of matches against JWT claim metadata is only supported in Gateways. The following example shows:
//
// - RequestAuthentication to decode and validate a JWT. This also makes the `@request.auth.claims` available for use in the VirtualService.
// - AuthorizationPolicy to check for valid principals in the request. This makes the JWT required for the request.
// - VirtualService to route the request based on the "sub" claim.
//
// ```yaml
// apiVersion: security.istio.io/v1
// kind: RequestAuthentication
// metadata:
//
//	name: jwt-on-ingress
//	namespace: istio-system
//
// spec:
//
//	selector:
//	  matchLabels:
//	    app: istio-ingressgateway
//	jwtRules:
//	- issuer: "example.com"
//	  jwksUri: https://example.com/.well-known/jwks.json
//
// ---
// apiVersion: security.istio.io/v1
// kind: AuthorizationPolicy
// metadata:
//
//	name: require-jwt
//	namespace: istio-system
//
// spec:
//
//	selector:
//	  matchLabels:
//	    app: istio-ingressgateway
//	rules:
//	- from:
//	  - source:
//	      requestPrincipals: ["*"]
//
// ---
// apiVersion: networking.istio.io/v1alpha3
// kind: VirtualService
// metadata:
//
//	name: route-jwt
//
// spec:
//
//	hosts:
//	- foo.prod.svc.cluster.local
//	gateways:
//	- istio-ingressgateway
//	http:
//	- name: "v2"
//	  match:
//	  - headers:
//	      "@request.auth.claims.sub":
//	        exact: "dev"
//	  route:
//	  - destination:
//	      host: foo.prod.svc.cluster.local
//	      subset: v2
//	- name: "default"
//	  route:
//	  - destination:
//	      host: foo.prod.svc.cluster.local
//	      subset: v1
//
// ```
//
// <!-- crd generation tags
// +cue-gen:RequestAuthentication:groupName:security.istio.io
// +cue-gen:RequestAuthentication:version:v1
// +cue-gen:RequestAuthentication:annotations:helm.sh/resource-policy=keep
// +cue-gen:RequestAuthentication:labels:app=istio-pilot,chart=istio,istio=security,heritage=Tiller,release=istio
// +cue-gen:RequestAuthentication:subresource:status
// +cue-gen:RequestAuthentication:scope:Namespaced
// +cue-gen:RequestAuthentication:resource:categories=istio-io,security-istio-io,shortNames=ra
// +cue-gen:RequestAuthentication:preserveUnknownFields:false
// -->
//
// <!-- go code generation tags
// +kubetype-gen
// +kubetype-gen:groupVersion=security.istio.io/v1
// +genclient
// +k8s:deepcopy-gen=true
// -->
// <!-- istio code generation tags
// +istio.io/sync-from:security/v1beta1/request_authentication.proto
// -->
#RequestAuthentication: _
