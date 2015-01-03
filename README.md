#Feature Versioning
Semantic Versioning is a very popular versioning scheme. Like everything in the world,
there is no such thing as perfect. Everything good, should evolve to keep up with the worlds needs.

##Semantic Versioning Evolving
In order to become more effective, it's important to understand what was strong to begin with. So
let's take a deeper look into why Semantic Versioning is so popular.

###The Good
####Developers trust Patches
Developers trust patches. Upgrading patching in most cases feel risk free as the changes should
have no breaking changes. Some teams even go as far as to auto update packages on patch level.

####Major indicates breakable changes
Major changes are automatically a warning to developers. We know this new update could break the
implementation. Therefor the update is treated with additional care and planned accordingly.

###The Bad
####Major is hardly used
In general developers try to make backwards compatible changes. If we look at the popular projects
on github, we see most of the project hanging with the major version around the 0 to 3.

####Semver or no Semver?
Whether a project is applying Semver or not is not always clear. This could also mean that even
though the package gets upgrade as a `patch`, the changes could break the implementation.

##Learn and evolve
We have learned a lot from Semver and we should bring it to the next level. Making the good, better
and the bad, good.

###Feature, Fix, Pushed Fix
####Feature
Every new feature receives a new feature number. This means: `1.0.0 -> 2.0.0`. The first digit will tell
up to what feature has been implemented in this package.

####Fix
It's unavoidable to have no bugs or left out specs on every feature. These `fixes` will receive a place
on the second digit. This way you can also track how many times a certain feature has been `fixed`. This
will result in `1.0.0 -> 1.1.0`.

####Pushed Fix
A fix is made on the feature it self, i.e. on feature `1.0.0` and not on `3.0.0`. That means we have to push
the fix up to the later implemented features as well. This will be reserved on the third digit.
This will result:

    1.0.0 -> 1.1.0
    2.0.0 -> 2.0.1
    3.0.0 -> 3.0.1

##Examples
A few examples to illustrate the `good` and the `bad` of FeatVer.

Imagine a library to help with some simple math:

    v1.0.0 -> Sum (x + y)
    v2.0.0 -> Substract (x - y)
    v3.0.0 -> Product (x * y)
    v4.0.0 -> Power (x^y)
    v5.0.0 -> Divide (x / y)

###First feature needs a bug fix
The Sum feature didn't accept negative numbers. To `fix` this we do the following:

    git checkout -b fixSum v1.0.0
    git add .
    git commit -m "fix for summing up negative numbers"
    git tag -a v1.1.0

Now we have fixed it for one version and we would need to push this to all next versions:

    git rebase v2.0.0
    git tag -a v2.0.1
    git rebase v3.0.0
    git tag -a v3.0.1
    ... (apply the same for all next versions)

By `rebasing` the changes on top of the next tag, you don't have to resolve the same conflict for every tag.

As you can see, this could be a pretty heavy job to maintain if performed manually. Therefore I created a small
script which takes most of the heavy lifting for you.

    patch.sh v1.1.0

###The Good
Teams depending on libraries using FeatVer scheme will be able to receive patches even when they aren't on the
latest version. Teams can depend on a specific version based on the feature.

###The Bad
The maintainers of the libraries using FeatVer will need to perform some more work in order to support the
depending teams with all versions.
