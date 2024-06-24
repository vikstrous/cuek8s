// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go k8s.io/ingress-gce/pkg/apis/backendconfig/v1

package v1

import metav1 "github.com/vikstrous/cuek8s/gen/k8s.io/apimachinery/pkg/apis/meta/v1"

// +k8s:openapi-gen=true
#BackendConfig: {
	metav1.#TypeMeta
	metadata?: metav1.#ObjectMeta   @go(ObjectMeta)
	spec?:     #BackendConfigSpec   @go(Spec)
	status?:   #BackendConfigStatus @go(Status)
}

// BackendConfigSpec is the spec for a BackendConfig resource
// +k8s:openapi-gen=true
#BackendConfigSpec: {
	iap?:                   null | #IAPConfig                   @go(Iap,*IAPConfig)
	cdn?:                   null | #CDNConfig                   @go(Cdn,*CDNConfig)
	securityPolicy?:        null | #SecurityPolicyConfig        @go(SecurityPolicy,*SecurityPolicyConfig)
	timeoutSec?:            null | int64                        @go(TimeoutSec,*int64)
	connectionDraining?:    null | #ConnectionDrainingConfig    @go(ConnectionDraining,*ConnectionDrainingConfig)
	sessionAffinity?:       null | #SessionAffinityConfig       @go(SessionAffinity,*SessionAffinityConfig)
	customRequestHeaders?:  null | #CustomRequestHeadersConfig  @go(CustomRequestHeaders,*CustomRequestHeadersConfig)
	customResponseHeaders?: null | #CustomResponseHeadersConfig @go(CustomResponseHeaders,*CustomResponseHeadersConfig)
	healthCheck?:           null | #HealthCheckConfig           @go(HealthCheck,*HealthCheckConfig)

	// Logging specifies the configuration for access logs.
	logging?: null | #LogConfig @go(Logging,*LogConfig)
}

// BackendConfigStatus is the status for a BackendConfig resource
#BackendConfigStatus: {}

// BackendConfigList is a list of BackendConfig resources
#BackendConfigList: {
	metav1.#TypeMeta
	metadata: metav1.#ListMeta @go(ListMeta)
	items: [...#BackendConfig] @go(Items,[]BackendConfig)
}

// IAPConfig contains configuration for IAP-enabled backends.
// +k8s:openapi-gen=true
#IAPConfig: {
	enabled: bool @go(Enabled)

	// +optional
	oauthclientCredentials?: null | #OAuthClientCredentials @go(OAuthClientCredentials,*OAuthClientCredentials)
}

// OAuthClientCredentials contains credentials for a single IAP-enabled backend.
// +k8s:openapi-gen=true
#OAuthClientCredentials: {
	// The name of a k8s secret which stores the OAuth client id & secret.
	secretName: string @go(SecretName)

	// Direct reference to OAuth client id.
	clientID?: string @go(ClientID)

	// Direct reference to OAuth client secret.
	clientSecret?: string @go(ClientSecret)
}

// CDNConfig contains configuration for CDN-enabled backends.
// +k8s:openapi-gen=true
#CDNConfig: {
	enabled: bool @go(Enabled)
	bypassCacheOnRequestHeaders?: [...null | #BypassCacheOnRequestHeader] @go(BypassCacheOnRequestHeaders,[]*BypassCacheOnRequestHeader)
	cachePolicy?:     null | #CacheKeyPolicy @go(CachePolicy,*CacheKeyPolicy)
	cacheMode?:       null | string          @go(CacheMode,*string)
	clientTtl?:       null | int64           @go(ClientTtl,*int64)
	defaultTtl?:      null | int64           @go(DefaultTtl,*int64)
	maxTtl?:          null | int64           @go(MaxTtl,*int64)
	negativeCaching?: null | bool            @go(NegativeCaching,*bool)
	negativeCachingPolicy?: [...null | #NegativeCachingPolicy] @go(NegativeCachingPolicy,[]*NegativeCachingPolicy)
	requestCoalescing?:       null | bool  @go(RequestCoalescing,*bool)
	serveWhileStale?:         null | int64 @go(ServeWhileStale,*int64)
	signedUrlCacheMaxAgeSec?: null | int64 @go(SignedUrlCacheMaxAgeSec,*int64)
	signedUrlKeys?: [...null | #SignedUrlKey] @go(SignedUrlKeys,[]*SignedUrlKey)
}

// BypassCacheOnRequestHeader contains configuration for how requests containing specific request
// headers bypass the cache, even if the content was previously cached.
// +k8s:openapi-gen=true
#BypassCacheOnRequestHeader: {
	// The header field name to match on when bypassing cache. Values are
	// case-insensitive.
	headerName?: string @go(HeaderName)
}

// NegativeCachingPolicy contains configuration for how negative caching is applied.
// +k8s:openapi-gen=true
#NegativeCachingPolicy: {
	// The HTTP status code to define a TTL against. Only HTTP status codes
	// 300, 301, 308, 404, 405, 410, 421, 451 and 501 are can be specified
	// as values, and you cannot specify a status code more than once.
	code?: int64 @go(Code)

	// The TTL (in seconds) for which to cache responses with the
	// corresponding status code. The maximum allowed value is 1800s (30
	// minutes), noting that infrequently accessed objects may be evicted
	// from the cache before the defined TTL.
	ttl?: int64 @go(Ttl)
}

// CacheKeyPolicy contains configuration for how requests to a CDN-enabled backend are cached.
// +k8s:openapi-gen=true
#CacheKeyPolicy: {
	// If true, requests to different hosts will be cached separately.
	includeHost?: bool @go(IncludeHost)

	// If true, http and https requests will be cached separately.
	includeProtocol?: bool @go(IncludeProtocol)

	// If true, query string parameters are included in the cache key
	// according to QueryStringBlacklist and QueryStringWhitelist.
	// If neither is set, the entire query string is included and if false
	// the entire query string is excluded.
	includeQueryString?: bool @go(IncludeQueryString)

	// Names of query strint parameters to exclude from cache keys. All other
	// parameters are included. Either specify QueryStringBlacklist or
	// QueryStringWhitelist, but not both.
	queryStringBlacklist?: [...string] @go(QueryStringBlacklist,[]string)

	// Names of query string parameters to include in cache keys. All other
	// parameters are excluded. Either specify QueryStringBlacklist or
	// QueryStringWhitelist, but not both.
	queryStringWhitelist?: [...string] @go(QueryStringWhitelist,[]string)
}

// SignedUrlKey represents a customer-supplied Signing Key used by
// Cloud CDN Signed URLs
// +k8s:openapi-gen=true
#SignedUrlKey: {
	// KeyName: Name of the key. The name must be 1-63 characters long, and
	// comply with RFC1035. Specifically, the name must be 1-63 characters
	// long and match the regular expression `[a-z]([-a-z0-9]*[a-z0-9])?`
	// which means the first character must be a lowercase letter, and all
	// following characters must be a dash, lowercase letter, or digit,
	// except the last character, which cannot be a dash.
	keyName?: string @go(KeyName)

	// KeyValue: 128-bit key value used for signing the URL. The key value
	// must be a valid RFC 4648 Section 5 base64url encoded string.
	keyValue?: string @go(KeyValue)

	// The name of a k8s secret which stores the 128-bit key value
	// used for signing the URL. The key value must be a valid RFC 4648 Section 5
	// base64url encoded string
	secretName?: string @go(SecretName)
}

// SecurityPolicyConfig contains configuration for CloudArmor-enabled backends.
// If not specified, the controller will not reconcile the security policy
// configuration. In other words, users can make changes in GCE without the
// controller overwriting them.
// +k8s:openapi-gen=true
#SecurityPolicyConfig: {
	// Name of the security policy that should be associated. If set to empty, the
	// existing security policy on the backend will be removed.
	name: string @go(Name)
}

// ConnectionDrainingConfig contains configuration for connection draining.
// For now the draining timeout. May manage more settings in the future.
// +k8s:openapi-gen=true
#ConnectionDrainingConfig: {
	// Draining timeout in seconds.
	drainingTimeoutSec?: int64 @go(DrainingTimeoutSec)
}

// SessionAffinityConfig contains configuration for stickiness parameters.
// +k8s:openapi-gen=true
#SessionAffinityConfig: {
	affinityType?:         string       @go(AffinityType)
	affinityCookieTtlSec?: null | int64 @go(AffinityCookieTtlSec,*int64)
}

// CustomRequestHeadersConfig contains configuration for custom request headers
// +k8s:openapi-gen=true
#CustomRequestHeadersConfig: {
	headers?: [...string] @go(Headers,[]string)
}

// CustomResponseHeadersConfig contains configuration for custom response headers
// +k8s:openapi-gen=true
#CustomResponseHeadersConfig: {
	headers?: [...string] @go(Headers,[]string)
}

// HealthCheckConfig contains configuration for the health check.
// +k8s:openapi-gen=true
#HealthCheckConfig: {
	// CheckIntervalSec is a health check parameter. See
	// https://cloud.google.com/compute/docs/reference/rest/v1/healthChecks.
	checkIntervalSec?: null | int64 @go(CheckIntervalSec,*int64)

	// TimeoutSec is a health check parameter. See
	// https://cloud.google.com/compute/docs/reference/rest/v1/healthChecks.
	timeoutSec?: null | int64 @go(TimeoutSec,*int64)

	// HealthyThreshold is a health check parameter. See
	// https://cloud.google.com/compute/docs/reference/rest/v1/healthChecks.
	healthyThreshold?: null | int64 @go(HealthyThreshold,*int64)

	// UnhealthyThreshold is a health check parameter. See
	// https://cloud.google.com/compute/docs/reference/rest/v1/healthChecks.
	unhealthyThreshold?: null | int64 @go(UnhealthyThreshold,*int64)

	// Type is a health check parameter. See
	// https://cloud.google.com/compute/docs/reference/rest/v1/healthChecks.
	type?: null | string @go(Type,*string)

	// Port is a health check parameter. See
	// https://cloud.google.com/compute/docs/reference/rest/v1/healthChecks.
	// If Port is used, the controller updates portSpecification as well
	port?: null | int64 @go(Port,*int64)

	// RequestPath is a health check parameter. See
	// https://cloud.google.com/compute/docs/reference/rest/v1/healthChecks.
	requestPath?: null | string @go(RequestPath,*string)
}

// LogConfig contains configuration for logging.
// +k8s:openapi-gen=true
#LogConfig: {
	// This field denotes whether to enable logging for the load balancer
	// traffic served by this backend service.
	enable?: bool @go(Enable)

	// This field can only be specified if logging is enabled for this
	// backend service. The value of the field must be in [0, 1]. This
	// configures the sampling rate of requests to the load balancer where
	// 1.0 means all logged requests are reported and 0.0 means no logged
	// requests are reported. The default value is 1.0.
	sampleRate?: null | float64 @go(SampleRate,*float64)
}