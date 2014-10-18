var sass = require('node-sass');

sass.render({
  file: 'templates/_grids.scss',
  success: function(css) {
    console.log(css);
  }
});

// susy-count(1 2 3 4 5)1 2 3 4 6
