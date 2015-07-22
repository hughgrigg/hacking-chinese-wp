<!DOCTYPE html>
<html <?php language_attributes(); ?>>

<head>
    <meta charset="utf-8">
    <meta name=viewport content="width=device-width, initial-scale=1">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta http-equiv="x-dns-prefetch-control" content="on">
    <link rel="dns-prefetch" href="http://fonts.useso.com/">
    <link rel="dns-prefetch" href="http://fonts.googleapis.com/">
    <link rel="profile" href="http://gmpg.org/xfn/11">
    <link rel="icon" type="image/png" href="<?php echo get_template_directory_uri(); ?>/img/favicon.png">
    <link rel="pingback" href="<?php bloginfo('pingback_url'); ?>">
    <title>
        <?php if (is_front_page()):
            bloginfo('name'); ?> | <?php bloginfo('description');
        else:
            wp_title(''); ?> | <?php bloginfo('name');
        endif; ?>
    </title>
    <?php wp_head(); ?>
</head>

<body <?php body_class(); ?>>

<a class="pure-g site-header" href="<?php bloginfo('url'); ?>">
    <div class="pure-u-1 pure-u-sm-1-6 pure-u-md-1-8">
        <div class="header-logo icon icon-zhongwen-jiemi"></div>
    </div>
    <div class="pure-u-1 pure-u-sm-5-6  pure-u-md-7-8 site-titles">
        <h2 class="site-title"><?php bloginfo('name'); ?></h2>
        <h3 class="site-subtitle"><?php bloginfo('description'); ?></h3>
    </div>
</a>

<button class="menu-button pure-button">Menu</button>
<?php wp_nav_menu(array('theme_location' => 'top-nav', 'menu_class' => 'top-menu')) ?>

<div class="pure-g layout">

    <div id="content" class="content pure-u-1 pure-u-lg-3-4 pure-u-xl-2-3">

    <?php if ( function_exists('yoast_breadcrumb') ) {
        yoast_breadcrumb('<p id="breadcrumbs" class="breadcrumbs">','</p>');
    } ?>
