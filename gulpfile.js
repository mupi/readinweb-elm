'use strict';

var gulp = require('gulp'),
  http = require('http'),
  st = require('st'),
  exec = require('child_process').exec,
  gutil = require('gulp-util'),
  clear = require('clear')

var elm = require('gulp-elm');
var plumber = require('gulp-plumber');
var connect = require('gulp-connect');

// File paths
var paths = {
  dest: 'dist',
  elm: 'src/*.elm'
};

clear();
gulp.task('default', ['server', 'watch', 'elm']);

gulp.task('server', function(done) {
  gutil.log(gutil.colors.blue('Starting server at http://localhost:4000'));
  http.createServer(
    st({
      path: __dirname,
      index: 'index.html',
      cache: false
    })
  ).listen(4000, done);
});

gulp.task('watch', function(cb) {
  gulp.watch(paths.elm, ['elm']);
});

gulp.task('elm', function(cb) {
  return gulp.src(paths.elm)
      .pipe(plumber())
      .pipe(elm())
      .pipe(gulp.dest(paths.dest));
});
