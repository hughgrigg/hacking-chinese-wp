<?php

function hc2015_scripts() {
    wp_enqueue_style('hc2015-style', get_stylesheet_uri());
}
add_action('wp_enqueue_scripts', 'hc2015_scripts');

function register_hc2015_menu() {
    register_nav_menu('top-nav', __( 'Top Nav' ));
}
add_action('init', 'register_hc2015_menu');

/**
 * Get comment form parts from template files because wtf WordPress
 * @param array $commentFields
 * @return array
 */
function hc2015_comment_fields(array $commentFields) {
    foreach (array_keys($commentFields) as $fieldName) {
        ob_start();
        include get_template_directory() . "/partials/comment-form/{$fieldName}.php";
        $commentFields[$fieldName] = ob_get_clean();
    }
    return $commentFields;
}
add_filter('comment_form_default_fields', 'hc2015_comment_fields');

/**
 * As above
 * @see hackingChineseCommentFields
 * @return string
 */
function hc2015_comment_field() {
    ob_start();
    include get_template_directory() . "/partials/comment-form/comment.php";
    return ob_get_clean();
}
