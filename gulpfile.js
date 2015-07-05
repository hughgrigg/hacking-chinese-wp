var
  gulp       = require('gulp'),
  sass       = require('gulp-sass'),
  sourcemaps = require('gulp-sourcemaps'),
  minifyCSS  = require('gulp-minify-css'),
  autoprefix = require('gulp-autoprefixer'),
  concat     = require('gulp-concat'),
  addSrc     = require('gulp-add-src'),
  insert     = require('gulp-insert'),
  fs         = require('fs'),

  unzip      = require('gulp-unzip'),
  save       = require('gulp-save'),
  filter     = require('gulp-filter'),
  replace    = require('gulp-replace'),
  rename     = require('gulp-rename'),

  zip        = require('gulp-zip'),

  livereload = require('gulp-livereload');

gulp.task('style', function() {
  var themeDescription = fs.readFileSync('./design/theme-description.css');
  return gulp.src('./design/scss/hc.scss')
    .pipe(sourcemaps.init())
    .pipe(sass())
    .pipe(addSrc([
      './bower_components/pure/pure.css',
      './bower_components/pure/grids-responsive.css',
      './import/*.css'
    ]))
    .pipe(autoprefix())
    .pipe(concat('style.css'))
    .pipe(minifyCSS({
      advanced:            true,
      aggressiveMerging:   true,
      keepBreaks:          false,
      keepSpecialComments: false
    }))
    .pipe(insert.prepend(themeDescription))
    .pipe(sourcemaps.write('.'))
    .pipe(gulp.dest('./wp-content/themes/hc-2015'))
    .pipe(livereload());
});

gulp.task('import', function() {
  return gulp.src('./import/icomoon.zip')
    .pipe(unzip())
    .pipe(save('before-style-filter'))
    .pipe(filter('style.css'))
    .pipe(replace(/\[class\^="icon-"], \[class\*=" icon-"]/g, '.icon'))
    .pipe(rename('icomoon.css'))
    .pipe(gulp.dest('./import/'))
    .pipe(save.restore('before-style-filter'))
    .pipe(filter('fonts/*.*'))
    .pipe(gulp.dest('./wp-content/themes/hc-2015/'));
});

gulp.task('export', ['style'], function() {
  return gulp.src('./wp-content/themes/**/*')
    .pipe(zip('hc2015-wp-theme-build-' + new Date().toISOString() + '.zip'))
    .pipe(gulp.dest('./export/'));
});

gulp.task('watch', function() {
  livereload.listen();
  return gulp.watch('./design/scss/**/*.scss', ['style']);
});
