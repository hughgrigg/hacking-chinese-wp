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
