<?php

const HC_2015_RIGHT_SIDEBAR = 'right-sidebar';
const HC_2015_FOOTER_WIDGETS = 'footer-widgets';

// Load required files
require __DIR__ . '/widgets/SocialIcons.php';

function hc2015_scripts() {
    wp_enqueue_style('hc2015-style', get_stylesheet_uri());
    wp_register_script(
        'hc2015',
        get_template_directory_uri() . '/js/hc-2015.js',
        array(),
        '1.0',
        true
    );
    wp_enqueue_script('hc2015');
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

// Register hc2015 sidebar
register_sidebar(array(
    'name'          => 'Right Sidebar',
    'id'            => HC_2015_RIGHT_SIDEBAR,
    'description'   => '',
    'class'         => '',
    'before_widget' => '<li id="%1$s" class="%2$s widget">',
    'after_widget'  => "</li>\n",
    'before_title'  => '<h2 class="widget-title">',
    'after_title'   => "</h2>\n",
));

// Register hc2015 footer
register_sidebar(array(
    'name'          => 'Footer Widgets',
    'id'            => HC_2015_FOOTER_WIDGETS,
    'description'   => '',
    'class'         => '',
    'before_widget' => '<li id="%1$s" class="%2$s widget footer-widget">',
    'after_widget'  => "</li>\n",
    'before_title'  => '<h2 class="widget-title">',
    'after_title'   => "</h2>\n",
));

// Register hc2015 widgets
add_action('widgets_init', function(){
    register_widget('HC2015\SocialIcons');
});

// Enable featured images
add_theme_support('post-thumbnails');
