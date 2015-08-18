<?php

get_header();
get_template_part('partials/navigation');
get_template_part('partials/layout-standard');

if ( function_exists('yoast_breadcrumb') ) {
    yoast_breadcrumb('<p id="breadcrumbs" class="breadcrumbs">','</p>');
}

?>

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

    <?php get_template_part('partials/sidebar'); ?>

</div>


<?php

get_template_part('partials/visual-footer');
get_footer();

?>
