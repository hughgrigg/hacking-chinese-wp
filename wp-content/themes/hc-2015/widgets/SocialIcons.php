<?php

namespace HC2015;

class SocialIcons extends \WP_Widget
{
    /**
     * Set up widget base ID and name
     */
    public function __construct() {
        parent::__construct(
            'hc2015_social_icons',
            'HC Social Icons',
            array(
                'description' => 'Hacking Chinese custom social media icons'
            )
        );
    }

    /**
     * Render widget content
     * @param array $args
     * @param array $instance
     */
    public function widget(array $args, array $instance)
    {
        echo $args['before_widget'];

        if (!empty($instance['title'])) {
            echo $args['before_title'] . apply_filters('widget_title', $instance['title']) . $args['after_title'];
        }

        get_template_part('partials/social-icons');

        echo $args['after_widget'];
    }
}
