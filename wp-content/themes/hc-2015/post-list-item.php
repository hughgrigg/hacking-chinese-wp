<li class="post-list-item">
    <h3 class="post-list-title">
        <a href="<?php the_permalink(); ?>"><?php the_title(); ?></a>
    </h3>
    <?php if (has_post_thumbnail()): ?>
    <div class="pure-g">
        <div class="pure-u-1 pure-u-sm-1-3 pure-u-md-1-4 post-list-thumbnail">
            <a href="<?php the_permalink(); ?>">
                <?php the_post_thumbnail('thumbnail'); ?>
            </a>
        </div>
        <div class="pure-u-1 pure-u-sm-2-3 pure-u-md-3-4">
            <p><?php the_excerpt(); ?><a href="<?php the_permalink(); ?>">Read &rarr;</a></p>
        </div>
    </div>
    <?php else: ?>
        <p><?php the_excerpt(); ?><a href="<?php the_permalink(); ?>">Read &rarr;</a></p>
    <?php endif; ?>
</li>
