<?php get_header(); ?>

<?php

// Start the loop.
while (have_posts()) : the_post();
    get_template_part('content', get_post_format());
endwhile;

// Comments
comments_template();

?>
</div>

<aside class="sidebar pure-u-1 pure-u-lg-1-4 pure-u-xl-1-3">
    <ul class="widgets">
        <?php dynamic_sidebar(HC_2015_RIGHT_SIDEBAR); ?>
    </ul>
</aside>

</div>

<?php get_footer(); ?>
