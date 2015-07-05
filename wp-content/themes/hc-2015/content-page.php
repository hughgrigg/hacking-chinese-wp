<article id="page-<?php the_ID(); ?>" <?php post_class(); ?>>

    <header class="entry-header">
        <h1 class="entry-title"><?php the_title(); ?></h1>
    </header>

    <div class="entry-content">
        <?php
            global $more;
            $more = 1;
            the_content();
        ?>
    </div>

    <?php edit_post_link( __( 'Edit', 'hackingchinese' ), '<span class="edit-link">', '</span>'); ?>

</article>
