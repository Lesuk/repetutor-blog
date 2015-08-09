---
title: What is a Module?
slug: what-is-a-module
date: 2015-08-09 10:07 EEST
description: Confused about this module.exports = ... business? This is an implementation of the Common JS modules spec.
tags:
category: gulp
---
Confused about this module.exports = ... business? This is an implementation of the Common JS modules spec. If you're familiar with RequireJS, which is an implementation of the AMD module spec, it's the same idea— just a different (I think nicer) syntax. Modules are a way to organize your code into separate files that export a chunk of code that other files can require. This can be anything—a function, a string, array, etc.

The first time you require('someModule'), that instance gets cached, and each future require('someModule') will refer to that original instance. That way, no matter how many different files require('someModule'), it will only be included once in your combined js.

If you're referencing a module installed to your node_modules folder, you can reference the name directly.
