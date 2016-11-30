I intent to put several scripts that help my programming life easier over here.


### iconsCreator.sh
For iOS apps, app icon is required to be in 10-15 different sizes to support different devices. It'd be quite frustrating if you had to manually edit icons to have different sizes. 
`iconsCreator.sh` helps you with that. You'd need to install [imagemagick](http://www.imagemagick.org/script/index.php), a command line tool to edit image first.

#### Usage:

Install `imagemagick`

```brew install imagemagick```

Run iconsCreator

```~/.iconsCreator BigIcon.png```

### Publish.sh
If you have a github.io site in [Jekyll](https://github.com/jekyll/jekyll/wiki/themes) template, you might find this useful. It helps you quickly publish a `markdown` file to your github.io page.
Feel free to checkout my github.io public page [here](https://freesuraj.github.io), and [source code](https://github.com/freesuraj/freesuraj.github.io).

#### Usage:
```
./Publish.sh [options]

  Options
  --------
    -u : github user name
    -t : title (Optional)
    -g : tags (Optional)
    -f : the input md file

  eg:
    ./Publish.sh -t TITLE -g tag1 tag2 -f /path/to/md/file.md -u githubUsername
    
    ./Publish.sh -f /path/to/md/file.md -u githubUsername
```

## Other Cool scripts

### imgcat
As it says, [imgcat](https://github.com/eddieantonio/imgcat) is like a cat but for images. Image is displayed right on `iTerm` terminal. Both local image and image URL are supported.

```
brew tap eddieantonio/eddieantonio
brew install imgcat
```
