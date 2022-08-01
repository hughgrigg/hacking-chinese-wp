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
<script id="mcjs">!function(c,h,i,m,p){m=c.createElement(h),p=c.getElementsByTagName(h)[0],m.async=1,m.src=i,p.parentNode.insertBefore(m,p)}(document,"script","https://chimpstatic.com/mcjs-connected/js/users/cb29a354184258b3e353fc7ea/4ad609414cc4dd23ba04f3470.js");</script>
    <?php wp_head(); ?>


</head>

<!-- Google Tag Manager -->
<noscript><iframe src="//www.googletagmanager.com/ns.html?id=GTM-KKR9L8"
height="0" width="0" style="display:none;visibility:hidden"></iframe></noscript>
<script>(function(w,d,s,l,i){w[l]=w[l]||[];w[l].push({'gtm.start':
new Date().getTime(),event:'gtm.js'});var f=d.getElementsByTagName(s)[0],
j=d.createElement(s),dl=l!='dataLayer'?'&l='+l:'';j.async=true;j.src=
'//www.googletagmanager.com/gtm.js?id='+i+dl;f.parentNode.insertBefore(j,f);
})(window,document,'script','dataLayer','GTM-KKR9L8');</script>
<!-- End Google Tag Manager -->

<body <?php body_class(); ?>>
