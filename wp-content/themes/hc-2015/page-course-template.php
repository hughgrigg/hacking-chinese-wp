<?php /* Template Name: Landing */

get_header();

?>

<div class="pure-g layout">

    <div id="content" class="content pure-u-1">

        <?php

        the_post();

        get_template_part('content', 'page');

        ?>

</div>

</div>

<?php get_footer(); ?>
