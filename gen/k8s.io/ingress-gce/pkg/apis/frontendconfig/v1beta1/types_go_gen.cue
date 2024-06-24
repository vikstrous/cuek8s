// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go k8s.io/ingress-gce/pkg/apis/frontendconfig/v1beta1

package v1beta1

import metav1 "github.com/vikstrous/cuek8s/gen/k8s.io/apimachinery/pkg/apis/meta/v1"

// +genclient
// +genclient:noStatus
// +k8s:deepcopy-gen:interfaces=k8s.io/apimachinery/pkg/runtime.Object
//
// +k8s:openapi-gen=true
#FrontendConfig: {
	metav1.#TypeMeta
	metadata?: metav1.#ObjectMeta    @go(ObjectMeta)
	spec?:     #FrontendConfigSpec   @go(Spec)
	status?:   #FrontendConfigStatus @go(Status)
}

// FrontendConfigSpec is the spec for a FrontendConfig resource
// +k8s:openapi-gen=true
#FrontendConfigSpec: {
	sslPolicy?:       null | string               @go(SslPolicy,*string)
	redirectToHttps?: null | #HttpsRedirectConfig @go(RedirectToHttps,*HttpsRedirectConfig)
}

// HttpsRedirectConfig representing the configuration of Https redirects
// +k8s:openapi-gen=true
#HttpsRedirectConfig: {
	enabled: bool @go(Enabled)

	// String representing the HTTP response code
	// Options are MOVED_PERMANENTLY_DEFAULT, FOUND, TEMPORARY_REDIRECT, or PERMANENT_REDIRECT
	responseCodeName?: string @go(ResponseCodeName)
}

// FrontendConfigStatus is the status for a FrontendConfig resource
#FrontendConfigStatus: {}

// FrontendConfigList is a list of FrontendConfig resources
#FrontendConfigList: {
	metav1.#TypeMeta
	metadata: metav1.#ListMeta @go(ListMeta)
	items: [...#FrontendConfig] @go(Items,[]FrontendConfig)
}