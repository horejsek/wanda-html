# Wanda - the fish

This is implementation of Gnome's easter egg "free the fish" for browser.

Check the [preview](http://htmlpreview.github.com/?https://github.com/horejsek/wanda-html/blob/master/example.html).

## Usage

You have to just include these lines in your page:

    <link rel="stylesheet" href="wanda.css" type="text/css" />
    <script src="wanda.js"></script>
    <script>new Wanda();</script>

If you want to show the fish only after typing of 'free the fish', type this: `new Wanda(true);`.
