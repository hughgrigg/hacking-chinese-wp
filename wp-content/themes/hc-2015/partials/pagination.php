<?php

the_posts_pagination(array(
    'prev_text'          => '&laquo; ' . __('Previous page', 'hc2015'),
    'next_text'          => __('Next page', 'hc2015') . ' &raquo;',
    'before_page_number' => '<span class="meta-nav screen-reader-text">' . __('Page', 'hc2015') . ' </span>',
));
