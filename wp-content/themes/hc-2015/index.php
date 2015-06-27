<?php get_header(); ?>

        <?php
        // Start the loop.
        while (have_posts()) : the_post();
            get_template_part('content', get_post_format());
        endwhile;
        // Comments
        if (is_single()):
            comments_template();
        endif;
        ?>
    </div>

    <aside class="sidebar pure-u-1 pure-u-lg-1-4 pure-u-xl-1-3">
        <h2>Sidebar</h2>
    </aside>

</div>


<?php get_footer(); ?>
