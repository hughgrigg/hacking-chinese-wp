const gulp       = require('gulp');
const sass       = require('gulp-sass')(require('sass'));
const sourcemaps = require('gulp-sourcemaps');
const minifyCSS  = require('gulp-minify-css');
const autoprefix = require('gulp-autoprefixer');
const concat     = require('gulp-concat');
const addSrc     = require('gulp-add-src');
const insert     = require('gulp-insert');
const fs         = require('fs');
const uglify = require('gulp-uglify');
const zip        = require('gulp-zip');
const gitRev     = require('git-rev-sync');

const themeDir = './wp-content/themes/hc-2015';

gulp.task('style', function() {
  const themeDescription = fs.readFileSync('./design/theme-description.css');
  return gulp.src('./design/scss/hc.scss')
    .pipe(sourcemaps.init())
    .pipe(sass())
    .pipe(addSrc([
      './node_modules/purecss/build/pure.css',
      './node_modules/purecss/build/grids-responsive.css',
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
    .pipe(gulp.dest(themeDir));
});

gulp.task('js', function() {
  return gulp.src('./js/**/*.js')
    .pipe(sourcemaps.init())
    .pipe(concat('hc-2015.js'))
    .pipe(uglify())
    .pipe(sourcemaps.write('maps/'))
    .pipe(gulp.dest(themeDir + '/js/'));
});

gulp.task('export', gulp.series(['style', 'js'], function() {
  return gulp.src('./wp-content/themes/**/*')
    .pipe(zip([
        (new Date()).toISOString().slice(0,19),
      'hc2015-wp-theme-revision',
      gitRev.short()
    ].join('-') + '.zip'))
    .pipe(gulp.dest('./export/'));
}));
