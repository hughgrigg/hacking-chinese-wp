<?php

get_header();
get_template_part('partials/navigation');
get_template_part('partials/layout-standard');

if ( function_exists('yoast_breadcrumb') ) {
    yoast_breadcrumb('<p id="breadcrumbs" class="breadcrumbs">','</p>');
}

the_post();
get_template_part('content', 'page');

?>
</div>

<?php get_template_part('partials/sidebar'); ?>

</div>

<?php

get_template_part('partials/visual-footer');
get_footer();

?>
