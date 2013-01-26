# Wanda – the fish

This is implementation of Gnome's easter egg "free the fish" for browser.

Check the [preview](http://htmlpreview.github.com/?https://github.com/horejsek/wanda-html/blob/master/wanda/example.html).

## Usage

You have to just include these lines in your page:

    <link rel="stylesheet" href="https://raw.github.com/horejsek/wanda-html/master/wanda/wanda.css" type="text/css" />
    <script src="https://raw.github.com/horejsek/wanda-html/master/wanda/wanda.min.js"></script>
    <script>new Wanda();</script>

If you want to show the fish only after typing of 'free the fish', type this: `new Wanda(true);`. That's all.

And one more thing. If you use 'easter egg' variant, you can pass second parametr (`new Wanda(true, true);`) by which you tell whether to show the fish after reload or not. You know, you have to kill real easter egg and this is similar except you have to close browser window.
