<?php

function hc2015_scripts() {
    wp_enqueue_style('hc2015-style', get_stylesheet_uri());
}
add_action('wp_enqueue_scripts', 'hc2015_scripts');

function register_hc2015_menu() {
    register_nav_menu('top-nav', __( 'Top Nav' ));
}
add_action('init', 'register_hc2015_menu');
