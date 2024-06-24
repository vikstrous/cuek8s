# Usage:

1. Make sure your cue version is at least 0.9

2. Add the module as a dependency:

```bash
cue mod get github.com/vikstrous/cuek8s
```

3. Use the definitions available

```cue
package cuek8stest

import "github.com/vikstrous/cuek8s"

service: cuek8s.#Service & {
        metadata: {
                name: "my-service"
        }
}
```

4. Confirm that invalid definitions will trigger an error:

```cue
service: cuek8s.#Service & {
        metadata: {
                nonsense: true
        }
}
```

```bash
service.metadata.nonsense: field not allowed:
    ../.cache/cue/mod/extract/github.com/vikstrous/cuek8s@v0.0.13/definitions.cue:34:11
    ../.cache/cue/mod/extract/github.com/vikstrous/cuek8s@v0.0.13/gen/k8s.io/api/core/v1/types_go_gen.cue:5941:13
    ../.cache/cue/mod/extract/github.com/vikstrous/cuek8s@v0.0.13/gen/k8s.io/apimachinery/pkg/apis/meta/v1/types_go_gen.cue:89:14
    ./test.cue:5:10
    ./test.cue:7:3
```

See [definitions.cue](./definitions.cue) to the complete list of kubernetes types exposed. If you want to see more added, open a Github issue!