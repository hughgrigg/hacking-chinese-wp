<a class="pure-g site-header" href="<?php bloginfo('url'); ?>">
    <div class="pure-u-1 pure-u-sm-1-6 pure-u-md-1-8">
        <div class="header-logo icon icon-zhongwen-jiemi"></div>
    </div>
    <div class="pure-u-1 pure-u-sm-5-6  pure-u-md-7-8 site-titles">
        <h2 class="site-title"><?php bloginfo('name'); ?></h2>
        <h3 class="site-subtitle"><?php bloginfo('description'); ?></h3>
    </div>
</a>

<button class="menu-button pure-button" id="menu-button">Menu</button>
<div class="menu-collapse" id="menu-collapse">
    <?php wp_nav_menu(array(
        'theme_location' => 'top-nav',
        'menu_class'     => 'top-menu',
        'menu_id'        => 'top-nav-menu',
    )) ?>
</div>
