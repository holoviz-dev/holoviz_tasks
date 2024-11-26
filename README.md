# holoviz_tasks

Shared GHA workflows and tasks used to maintain the HoloViz repositories

## Release

To make a release tag the commit with the version number and push it to the repo.

```bash
git tag -a v0.1.X -m "Version 0.1.X"
git push --tags v0.1.X
```

Afterwards merge the commits up tag into `v0` branch. This branch is used across
projects to not manually update to the latests tag.

``` bash
git checkout v0
git merge main
git push origin v0
```
