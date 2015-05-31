var
    gulp        = require('gulp'),
    sass        = require('gulp-sass'),
    sourcemaps  = require('gulp-sourcemaps'),
    minifyCSS   = require('gulp-minify-css'),
    autoprefix  = require('gulp-autoprefixer');

gulp.task('style', function() {
    return gulp.src('./scss/style.scss')
        .pipe(sourcemaps.init())
        .pipe(sass())
        .pipe(autoprefix())
        .pipe(minifyCSS({
            advanced:            true,
            aggressiveMerging:   true,
            keepBreaks:          true,
            keepSpecialComments: 1
        }))
        .pipe(sourcemaps.write('.'))
        .pipe(gulp.dest('./wp-content/themes/hc-2015'));
});

gulp.task('watch', function() {
    gulp.watch('./themes/2015/scss/**/*.scss', ['style']);
});
