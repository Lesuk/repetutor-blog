Middleman classic-man
=======

Static site starter template for [Middleman](http://middlemanapp.com/).

###### Preprocessing
- [Slim](http://slim-lang.com) *[for html]*
- [SASS](http://sass-lang.com) *[for css]*

###### Tools
- [Bower](http://bower.io) *[js package management]*
- [Compass](http://compass-style.org) *[sass helpers/mixins]*

## Getting Started

1. Install Middleman

  ```
  $ gem install middleman
  ```

2. Install template

  ```
  $ mkdir ~/.middleman #if it doesn't exist yet
  $ cd ~/.middleman
  $ git clone git@github.com:Lesuk/classic-man.git classic-man
  ```

3. Start your project

  ```
  $ cd ~/path/to/your/project
  $ middleman init PROJECT_NAME --template=classic-man
  ```

## Using Bower

1. Find and install the packages you need...

  ```
  $ npm install -g bower  # If you don't have it already.
  $ bower install
  $ bower search PACKAGE_NAME
  $ bower install ACTUAL_PACKAGE_NAME -S
  ```

**Note**: By default, Bower Components install to the default `bower_components` directory at the root. You can change this, if you want, in the `.bowerrc` file, but make sure to update the `.gitignore` with your new directory.

2. Include the assets in your js/css files (paths relative to the root 'bower' directory )

  `#=require 'folder/file'` - *for js files*
  
  `@import 'folder/file'` - *for css files*


## Running the Application

You run the application by starting the Middleman server:

```shell
bundle exec middleman s
```

## Building the Static Files

To build the static files:

```shell
bundle exec middleman build
```
