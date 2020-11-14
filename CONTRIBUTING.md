# Contribution Guide

  - The branching strategy is based on git flow

## Branching strategy

If you're not sure of what you're doing, ask other dev or maintainer !

### master

This is the developing branch.
I must always ***build*** and pass the majority of tests

### stable

Production version of the project.

### {package}/feature/{featureName}
This branches holds upcoming features, sub features branches can be created from it.

Feature is the default name, but it can be more specialized as "UI".

Properties:

* Forked from master
* The branch must be removed after its merge
* The developer should open a merge request as soon as possible. So other dev can submit their feedback during the development and not only at the end.

### release/{semantic_versioning}
This branch starts a new release.

Properties:
* forked from master
* When the release branch is about to be merged, it's last commit must be tagged with the version number
* When the release branch is merged in stable, it must be merged back in dev then deleted.
* All commit on this branch must be release oriented (ex: adding doc, changing config files...)

### bugfix/{#issue_hash}
This branch fix bugs in release/master branches.

Properties:
* forked from master/release
* the branch name must begin with bugfix/{issue hash}
* the branch must be removed after it's merge

### hotfix/{#issue_hash}
This branch fix bugs in production

Properties:
* forked from stable
* merged in master and stable
* The branch must be removed after it's merge

## Commit format

Grammar:

{package?/subpackage}::{semantic_scope?/sub...}: {action_type} -> {imperative_verb} {msg...}

All commit must have only one type, so we can reach an atomic commit level

### Commit type

* feat     -> add new feature
* fix     -> fix a bug
* refactor   -> change/move a piece of code without changing it's logic/perf
* style   -> change indentation, naming or code format
* chore   -> other tasks as removing files, updating modules
* doc     -> modification on documentation
* it     -> modification on integration tests
* ut        -> modification on unit tests
* e2e       -> modification on end to end tests
* perf     -> improve performances
* deps     -> manage external dependancies
* ui     -> make GUI changes (not the same as style)

### Commit scope
Impacted scope of the current commit :
ex:
* server::session_dispatcher
* server/realtime::scheduler
* client::login_screen

### Commit message
The commit message must be in english and in imperative time
ex:
add axios node module
adding new axios module in app.json

### Examples

* server/realtime::dispatcher_actor: fix -> use Arc<T> instead of trivial RefCell<T>
* client::projectStore: feat -> implement CRUD actions
* server::authRoute: feat -> implement signIn and signOn routes
