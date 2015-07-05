<article id="post-<?php the_ID(); ?>" <?php post_class(); ?>>
    <header class="entry-header">
        <h1 class="entry-title"><?php the_title(); ?></h1>
    </header>

    <div class="entry-content">
        <?php
        the_content(sprintf(
            __('Continue reading %s', 'hc2015'),
            the_title( '<span class="screen-reader-text">',
                '</span>',
                false
            )
        ));

        wp_link_pages( array(
            'before'      => '<div class="page-links"><span class="page-links-title">' . __('Pages:', 'hc2015') . '</span>',
            'after'       => '</div>',
            'link_before' => '<span>',
            'link_after'  => '</span>',
            'pagelink'    => '<span class="screen-reader-text">' . __('Page', 'hc2015') . ' </span>%',
            'separator'   => '<span class="screen-reader-text">, </span>',
        ) );
        ?>
    </div>

    <?php
    if (is_single() && get_the_author_meta('description')):
        get_template_part('author-bio');
    endif;
    ?>

    <footer class="entry-footer">

        <ul class="entry-meta">
            <li><?php the_author_link(); ?></li>
            <li>
                <a href="<?php echo get_month_link(get_the_time('Y'), get_the_time('m')); ?>">
                    <?php the_time('l, F jS, Y') ?>
                </a>
            </li>
            <?php if (is_single()): ?>
            <li>
                <a href="<?php comments_link(); ?>">
                    <?php comments_number('No comments', 'One comment', '% comments'); ?>
                </a>
            </li>
            <?php endif; ?>
        </ul>

        <?php edit_post_link( __( 'Edit', 'hackingchinese' ), '<span class="edit-link">', '</span>'); ?>
    </footer>

</article>
