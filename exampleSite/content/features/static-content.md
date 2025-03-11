+++
date = '2025-02-22T01:11:57-03:00'
title = 'Static Content'
series = ['content','features']
+++

Some of the static content on the site, like the home greetings and side pane content, can be defined in the file at `data/rtwt/content.yaml`. The structure to do so is as follows:

> Note: It's possible to use file formats other than YAML, but the key structure must remain the same!

```yaml
home:
  image: 'images/greetings.jpg'
  greetings: 'A Hugo Theme for Bloggers!'
  text: 'The definitive, configurable, customizable, old fashioned rusty coloured theme for web writers and readers.'
side:
  home:
  - content: 'Oh, and did I mention it has support for static side pane content? Cool, right?'
  - title: 'Media Support'
    content: 'Side content can have images!'
    imagePath: 'images/hugo.svg'
    imageHref: 'https://gohugo.io'
    imageWidth: '100%'
```

> Didn't find a value you're looking for? Check the [repository](https://github.com/math-queiroz/rusty-typewriter) for the given file (which may be updated with it), or create a new feature request!
