//go:build tool

package tool

import (
	_ "github.com/GoogleCloudPlatform/gke-managed-certs/pkg/apis/networking.gke.io/v1"
	_ "github.com/kubernetes-csi/external-snapshotter/client/v4/apis/volumesnapshot/v1"
	_ "istio.io/api/networking/v1"
	_ "istio.io/api/security/v1"
	_ "k8s.io/api/apps/v1"
	_ "k8s.io/api/batch/v1"
	_ "k8s.io/api/core/v1"
	_ "k8s.io/api/networking/v1"
	_ "k8s.io/api/policy/v1"
	_ "k8s.io/api/storage/v1"
	_ "k8s.io/ingress-gce/pkg/apis/backendconfig/v1"
	_ "k8s.io/ingress-gce/pkg/apis/frontendconfig/v1beta1"
)
