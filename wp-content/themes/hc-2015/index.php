<?php get_header(); ?>

        <h1 class="entry-title">
            <?php get_template_part('partials/index-title');

            if (get_query_var('paged') > 1): ?>
                <small class="title-note">Page <?php echo get_query_var('paged') ?></small>
            <?php endif ?>
        </h1>

        <?php if (get_query_var('paged') > 1):
            get_template_part('partials/pagination');
        endif; ?>

        <ol class="post-list">
            <?php
            // Start the loop.
            while (have_posts()) : the_post();
                get_template_part('post-list-item', get_post_format());
            endwhile;
            ?>
        </ol>

        <?php get_template_part('partials/pagination'); ?>

    </div>

    <aside class="sidebar pure-u-1 pure-u-lg-1-4 pure-u-xl-1-3">
        <ul class="widgets">
            <?php dynamic_sidebar(HC_2015_RIGHT_SIDEBAR); ?>
        </ul>
    </aside>

</div>


<?php get_footer(); ?>
