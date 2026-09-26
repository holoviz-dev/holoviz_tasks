# pixi-diff

Compares `pixi.lock` against the base branch and reports the changed packages per environment.
The report is written to the job summary and, on pull requests from the same repository,
posted as a PR comment that is updated on later runs.

Packages that are direct dependencies of an environment in `pixi.toml` are listed first;
indirect dependencies are collapsed in a `<details>` block.

## Usage

```yaml
jobs:
  pixi_lock_diff:
    name: pixi-diff
    runs-on: ubuntu-latest
    permissions:
      pull-requests: write
    steps:
      - uses: holoviz-dev/holoviz_tasks/pixi-diff@<sha> # vX.Y.Z
```

## Inputs

| Name           | Required | Default                              | Description                                                                 |
| -------------- | -------- | ------------------------------------ | --------------------------------------------------------------------------- |
| `github-token` | no       | `github.token`                       | Token used to create or update the PR comment, needs `pull-requests: write` |
| `base-sha`     | no       | `github.event.pull_request.base.sha` | Revision to compare `pixi.lock` against, falls back to `origin/main`        |

## Outputs

| Name   | Description                                                          |
| ------ | -------------------------------------------------------------------- |
| `body` | Markdown summary of the `pixi.lock` changes, empty if there are none |

## Notes

- Nothing is reported when `pixi.lock` is identical to the base revision or to `origin/main`.
- PRs from forks only get the job summary, as their token cannot comment.
- The script is run with `pipx`, which is preinstalled on GitHub-hosted runners.
