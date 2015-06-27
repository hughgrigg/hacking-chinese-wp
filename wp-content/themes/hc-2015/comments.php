<section id="comments" class="comments">

    <?php if (have_comments()): ?>

        <h2 class="comments-title">
            <?php printf(
                _nx('One comment', '%1$s comments', get_comments_number(), 'hackingchinese'),
                number_format_i18n(get_comments_number())
            ); ?>
        </h2>

        <ol class="comments-list">
            <?php wp_list_comments(array(
                'style'       => 'ol',
                'short_ping'  => true,
                'avatar_size' => 56
            )); ?>
        </ol>

    <?php endif;

    if (!comments_open() && get_comments_number() && post_type_supports(get_post_type(), 'comments')): ?>
        <p class="no-comments"><?php _e( 'Comments are closed.', 'hackingchinese' ); ?></p>
    <?php endif;

    // comment form: wtf WordPress...
    ob_start();
    comment_form(array(
        'title_reply'         => __('Leave a comment'),
        'comment_notes_after' => '',
        'class_submit'        => 'pure-button',
        'comment_field'       => hc2015_comment_field(),
    ));
    echo str_replace('class="comment-form"','class="comment-form pure-form pure-form-stacked"', ob_get_clean());
    ?>

</section>
