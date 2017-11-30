# WORDPRESS THEMING

	# 1. NEW CHILDTHEME:

		# style.css:

			/*
			 Theme Name:   elementorslate
			 Author:       benqzq
			 Template:     elementorslate
			 Version:      1.0.0
			 License:      GNU General Public License v2 or later
			 License URI:  http://www.gnu.org/licenses/gpl-2.0.html
			 Tags:         pagebuilder-oriented
			*/

		# functions.php:

			<?php
				add_action( 'my_theme_enqueue_styles', 'wp_enqueue_styles' );
				function my_theme_enqueue_styles() {
					wp_enqueue_style( 'parent-style', get_template_directory_uri() . '/style.css' );
				}

				add_action( 'wp_enqueue_scripts', 'wpb_adding_scripts' );  
				function wpb_adding_scripts() {
				wp_register_script('behavior', get_template_directory_uri() . '/behavior.js', array(), null, true);
				wp_enqueue_script('behavior');
				}
			?>

		# HFE extension:

			https://gist.github.com/anonymous/71adde4eca8eb2c5e1bd3e4c602fba38

	# 2. NEW REGION (new sidebar):

		# 1. template.php

			<?php if ( !function_exists('dynamic_sidebar') || !dynamic_sidebar("NEW_AREA") ) : ?> <?php endif; ?>

		# 2. functions.php

			if ( function_exists('register_sidebar') )
				register_sidebar(array(
					'name' => 'NEW_AREA',
					'before_widget' => '<div class = "NEW_AREA">',
					'after_widget' => '</div>'
				)
			);

	# 3. NEW MENU:

		# 1. template.php:

			<? wp_nav_menu( array( 'theme_location' => 'secondary', 'container_class' => 'container' ) ); ?>

		# 2. functions.php:

			function register_my_menu() {register_nav_menu('secondary',__( 'secondary' ));}
			add_action( 'init', 'register_my_menu' );
			add_filter('nav_menu_css_class' , 'special_nav_class' , 10 , 2);

			function special_nav_class ($classes, $item) {
			if (in_array('current-menu-item', $classes) ){
			$classes[] = 'active ';
			}
			return $classes;
			}

		# 3. CSS for menu:

			#menu-secondary {display: none}
			@media screen and (min-width: 519px) {
				#menu-secondary {display: block; margin: 30px auto 0; padding: 0; background: rgba(243,243,243,1)}
				#menu-secondary ul {display: block}
				#menu-secondary li {display: inline-block; padding: 10px 20px 10px 20px}
				#menu-secondary a {display: inline-block; padding: 10px 20px 10px 20px; margin: -10px -20px -10px -20px; font-family: Heebo; font-size: 16px; color: #000}
				#menu-secondary li:hover {border-top: 1px solid #1c57ff} 
				#menu-secondary li:active {border-top: 1px solid #1c57ff}
				#menu-secondary li.active {border-top: 1px solid #1c57ff}
				#menu-secondary li.active > a {color: #1c57ff}
			}