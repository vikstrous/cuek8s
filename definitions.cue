package cuek8s

import (
	managed_cert_networking "github.com/vikstrous/cuek8s/gen/github.com/GoogleCloudPlatform/gke-managed-certs/pkg/apis/networking.gke.io/v1"
	external_snapshotter_volume_snapshot "github.com/vikstrous/cuek8s/gen/github.com/kubernetes-csi/external-snapshotter/client/v4/apis/volumesnapshot/v1"
	istio_networking "github.com/vikstrous/cuek8s/gen/istio.io/api/networking/v1"
	istio_security "github.com/vikstrous/cuek8s/gen/istio.io/api/security/v1"
	apps "github.com/vikstrous/cuek8s/gen/k8s.io/api/apps/v1"
	batch "github.com/vikstrous/cuek8s/gen/k8s.io/api/batch/v1"
	core "github.com/vikstrous/cuek8s/gen/k8s.io/api/core/v1"
	networking "github.com/vikstrous/cuek8s/gen/k8s.io/api/networking/v1"
	policy "github.com/vikstrous/cuek8s/gen/k8s.io/api/policy/v1"
	storage "github.com/vikstrous/cuek8s/gen/k8s.io/api/storage/v1"
	backend "github.com/vikstrous/cuek8s/gen/k8s.io/ingress-gce/pkg/apis/backendconfig/v1"
	frontend "github.com/vikstrous/cuek8s/gen/k8s.io/ingress-gce/pkg/apis/frontendconfig/v1beta1"
)

#ManagedCertificate:    managed_cert_networking.#ManagedCertificate

#VolumeSnapshotClass:   external_snapshotter_volume_snapshot.#VolumeSnapshotClass

#ServiceEntry:          istio_networking.#ServiceEntry
#DestinationRule:       istio_networking.#DestinationRule

#PeerAuthentication:    istio_security.#PeerAuthentication
#AuthorizationPolicy:   istio_security.#AuthorizationPolicy

#Deployment:            apps.#Deployment
#StatefulSet:           apps.#StatefulSet

#CronJob:               batch.#CronJob
#Job:                   batch.#Job

#Service: core.#Service
#ServiceAccount: core.#ServiceAccount
#PersistentVolume: core.#PersistentVolume
#PersistentVolumeClaim: core.#PersistentVolumeClaim
#ConfigMap:             core.#ConfigMap

#Ingress:               networking.#Ingress

#PodDisruptionBudget:   policy.#PodDisruptionBudget

#StorageClass:          storage.#StorageClass

#BackendConfig:         backend.#BackendConfig

#FrontendConfig:        frontend.#FrontendConfig
