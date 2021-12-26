# github-action-kustomize-and-push

Useful to push images updates to a master repository containing central manifests.

There are different variables to setup the action:

## Inputs

### `kustomize-version` (argument) [optional]

Kustomize version to use. If not set the latest available will be use.
Check https://github.com/kubernetes-sigs/kustomize/releases for available versions

### `kustomize-edit-images` (argument)

The images (space separated) to edit using kustomize.
For example: node:8.15.0 mysql=mariadb
For more information run: kustomize edit set image -h

### `user-email` (argument)

The email that will be used for the commit in the destination-repository-name.

### `user-name` (argument) [optional]

The name that will be used for the commit in the destination-repository-name. If not specified, the `repository-username` will be used instead.

### `repository-username` (argument)

The repository we will push the kustomize results to.
For the repository `https://github.com/rusowyler/github-action-kustomize-and-push` is `rusowyler`.

### `repository-name` (argument)

For the repository `https://github.com/rusowyler/github-action-kustomize-and-push` is `github-action-kustomize-and-push`

### `branch` (argument) [optional]

The branch name for the destination repository. It defaults to `main`.

### `directory` (argument) [optional]

The directory to wipe and replace in the target repository. Defaults to wiping the entire repository

### `commit-message` (argument) [optional]

The commit message to be used. Defaults to "Updated KUSTOMIZE_IMAGES from ORIGIN_COMMIT". ORIGIN_COMMIT and KUSTOMIZE_IMAGES are replaced by the URL@commit and the submited images

### `API_TOKEN_GITHUB` (environment)

E.g.:
`API_TOKEN_GITHUB: ${{ secrets.API_TOKEN_GITHUB }}`

Generate your personal token following the steps:

- Go to the Github Settings (on the right hand side on the profile picture)
- On the left hand side pane click on "Developer Settings"
- Click on "Personal Access Tokens" (also available at https://github.com/settings/tokens)
- Generate a new token, choose "Repo". Copy the token.

Then make the token available to the Github Action following the steps:

- Go to the Github page for the repository that you push from, click on "Settings"
- On the left hand side pane click on "Secrets"
- Click on "Add a new secret" and name it "API_TOKEN_GITHUB"

## Example usage

```yaml
- name: Kustomize and push
  uses: rusowyler/github-action-kustomize-and-push@main
  env:
    API_TOKEN_GITHUB: ${{ secrets.API_TOKEN_GITHUB }}
  with:
    kustomize-edit-images: "node:8.15.0"
    repository-username: "rusowyler"
    repository-name: "central-k8s-repository"
    user-email: demo@usermail.com
    directory: enviroment/qa
```
