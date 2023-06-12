# Install Action for HoloViz CI

This action handles the setup and caching of environments used for testing on various HoloViz projects. It also has support for including some difficult to manage dependencies such as OpenGL and playwright.

## Inputs

- name: str (required)
  The name of the task
- channels: str (default: "defaults", required)
  The conda channels to fetch packages from
- channel-priority: str (default: "strict")
  Channel priority determines if packages in lower priority channels are considered if a package with the same name appears in a higher priority channel.
- python-version: str (default: "3.7", required)
- envs: str (default: "-o examples", required:
  The string passed to doit develop_install
- cache: bool (default: false)
  Whether to enable caching
- nodejs: bool (default: false)
  Whether to install nodejs in the base environment
- opengl: bool (default: false)
  Whether to install openGL
- playwright: bool (default: false)
  Whether to install playwright
- conda-mamba: 'conda' / 'mamba' (default: 'conda')
  Whether to use conda or mamba for installing

## Outputs

- cache-hit:
  Whether the cache was hit (if caching is enabled)

## Example

Here is an example using the install action to set up and cache a complicated environment: 

```yaml
- uses: holoviz-dev/holoviz_tasks/install@main
  with:
    name: ui_test_suite
    python_version: 3.9
    channels: pyviz/label/dev,bokeh,conda-forge,nodefaults
    envs: "-o recommended -o tests -o build"
    cache: true
    playwright: true
  id: install
```
