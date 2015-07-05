<?php

if (is_date()): ?>
    <small class="title-note">
        Articles published
        <?php if (is_day()): ?>
            on
        <?php else: ?>
            in
        <?php endif; ?>
    </small>
    <?php if (is_month()):
        the_time('F Y');
    elseif (is_year()):
        the_time('Y');
    else:
        the_time('l jS F Y');
    endif;
elseif (is_tag()): ?>
    <small class="title-note">Articles tagged with</small>
    &lsquo;<?php single_tag_title(); ?>&rsquo;
<?php elseif (is_category()): ?>
    <small class="title-note">Articles in the</small>
    &lsquo;<?php single_cat_title(); ?>&rsquo;
    <small class="title-note">category</small>
<?php else:
    wp_title('');
endif;
