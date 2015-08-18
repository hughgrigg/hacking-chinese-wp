const gulp       = require('gulp');
const sass       = require('gulp-sass');
const sourcemaps = require('gulp-sourcemaps');
const minifyCSS  = require('gulp-minify-css');
const autoprefix = require('gulp-autoprefixer');
const concat     = require('gulp-concat');
const addSrc     = require('gulp-add-src');
const insert     = require('gulp-insert');
const fs         = require('fs');

const unzip      = require('gulp-unzip');
const save       = require('gulp-save');
const filter     = require('gulp-filter');
const replace    = require('gulp-replace');
const rename     = require('gulp-rename');

const zip        = require('gulp-zip');

const livereload = require('gulp-livereload');

const gitRev     = require('git-rev-sync');

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
    .pipe(replace(/(\t|    )/g, '  '))
    .pipe(rename('icomoon.scss'))
    .pipe(gulp.dest('./design/scss/vendor/'))
    .pipe(save.restore('before-style-filter'))
    .pipe(filter('fonts/*.*'))
    .pipe(gulp.dest('./wp-content/themes/hc-2015/'));
});

gulp.task('export', ['style'], function() {
  return gulp.src('./wp-content/themes/**/*')
    .pipe(zip(['hc2015-wp-theme-revision', gitRev.short()].join('-') + '.zip'))
    .pipe(gulp.dest('./export/'));
});

gulp.task('watch', function() {
  livereload.listen();
  return gulp.watch('./design/scss/**/*.scss', ['style']);
});
