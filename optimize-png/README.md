Add this actions:

```yaml
name: optimize-png
on:
  pull_request:
    branches:
      - "*"

permissions: {}

concurrency:
  group: ${{ github.workflow }}-${{ github.event.pull_request.number || github.ref }}
  cancel-in-progress: true

jobs:
  optimize_png:
    name: optimize-png
    runs-on: "ubuntu-latest"
    permissions:
      contents: write
    steps:
      - uses: holoviz-dev/holoviz_tasks/optimize-png@v1
        with:
          run-all: false # Change to true first time
```
