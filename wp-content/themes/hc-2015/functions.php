<?php

function hc2015_scripts() {
	wp_enqueue_style('hc2015-style', get_stylesheet_uri());
}
add_action('wp_enqueue_scripts', 'hc2015_scripts');
