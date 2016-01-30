var gulp       = require('gulp');
var sass       = require('gulp-sass');
var sourcemaps = require('gulp-sourcemaps');
var minifyCSS  = require('gulp-minify-css');
var autoprefix = require('gulp-autoprefixer');
var concat     = require('gulp-concat');
var addSrc     = require('gulp-add-src');
var insert     = require('gulp-insert');
var fs         = require('fs');

var uglify = require('gulp-uglify');

var unzip      = require('gulp-unzip');
var save       = require('gulp-save');
var filter     = require('gulp-filter');
var replace    = require('gulp-replace');
var rename     = require('gulp-rename');

var zip        = require('gulp-zip');

var livereload = require('gulp-livereload');

var gitRev     = require('git-rev-sync');

var themeDir = './wp-content/themes/hc-2015';

gulp.task('style', function() {
  var themeDescription = fs.readFileSync('./design/theme-description.css');
  return gulp.src('./design/scss/hc.scss')
    .pipe(sourcemaps.init())
    .pipe(sass())
    .pipe(addSrc([
      './node_modules/purecss/build/pure.css',
      './node_modules/purecss/build/grids-responsive.css',
      './import/*.css'
    ]))
    .pipe(autoprefix({
      browsers: [
        '> 1%',
        'Firefox ESR',
        'last 3 versions',
        'last 3 ios_saf versions'
      ]
    }))
    .pipe(concat('style.css'))
    .pipe(minifyCSS({
      advanced:            true,
      aggressiveMerging:   true,
      keepBreaks:          false,
      keepSpecialComments: false
    }))
    .pipe(insert.prepend(themeDescription))
    .pipe(sourcemaps.write('.'))
    .pipe(gulp.dest(themeDir))
    .pipe(livereload());
});

gulp.task('js', function() {
  return gulp.src('./js/**/*.js')
    .pipe(sourcemaps.init())
    .pipe(concat('hc-2015.js'))
    .pipe(uglify())
    .pipe(sourcemaps.write('maps/'))
    .pipe(gulp.dest(themeDir + '/js/'));
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
    .pipe(gulp.dest(themeDir));
});

gulp.task('export', ['style', 'js'], function() {
  return gulp.src('./wp-content/themes/**/*')
    .pipe(zip(['hc2015-wp-theme-revision', gitRev.short()].join('-') + '.zip'))
    .pipe(gulp.dest('./export/'));
});

gulp.task('watch', function() {
  livereload.listen();
  return gulp.watch('./design/scss/**/*.scss', ['style']);
});
