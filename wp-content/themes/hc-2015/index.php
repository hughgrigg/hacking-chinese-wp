<?php get_header(); ?>

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
        <?php
        // Start the loop.
        while (have_posts()) : the_post();
            get_template_part('content', get_post_format());
        endwhile;
        ?>
    </div>

    <aside class="sidebar pure-u-1 pure-u-lg-1-4 pure-u-xl-1-3">
        <h2>Sidebar</h2>
    </aside>

</div>


<?php get_footer(); ?>
