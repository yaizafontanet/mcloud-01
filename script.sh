#!/bin/bash
# automatitzar la instalación WORDPRESS INSTALLER IN  AWS Ubuntu Server 20.04 LTS (HVM)

# varaible will be populated by terraform template
db_username="yaiza"
db_user_password="yaiza12345"
db_name="mcloud"
db_RDS=${aws_db_instance.DataBase.endpoint}
                                                                                          
sudo yum install httpd php php-mysql -y -q                                                              
sudo cd /var/www/html                                                                                   
echo "MCLOUD" > hw.html                                                                                
sudo wget https://es.wordpress.org/wordpress-latest-es_ES.tar.gz                                                 
sudo tar -xzvf wordpress-latest-es_ES.tar.gz                                                                    
sudo cp -r wordpress/* /var/www/html/                                                               
sudo rm -rf wordpress                                                                                   
sudo rm -rf wordpress-latest-es_ES.tar.gz                                                                      
sudo chmod -R 755 wp-content                                                                            
sudo chown -R apache:apache wp-content                                                                  
sudo wget https://s3.amazonaws.com/bucketforwordpresslab-donotdelete/htaccess.txt                       
sudo mv htaccess.txt .htaccess                                                                          
sudo systemctl start httpd                                                                              
systemctl enable httpd
touch /var/www/html/wp-config.php
cat > /var/www/html/wp-config.php << EOF
<?php
/**
 * The base configuration for WordPress
 *
 * The wp-config.php creation script uses this file during the installation.
 * You don't have to use the web site, you can copy this file to "wp-config.php"
 * and fill in the values.
 *
 * This file contains the following configurations:
 *
 * * Database settings
 * * Secret keys
 * * Database table prefix
 * * ABSPATH
 *
 * @link https://wordpress.org/support/article/editing-wp-config-php/
 *
 * @package WordPress
 */

// ** Database settings - You can get this info from your web host ** //
/** The name of the database for WordPress */
define( 'DB_NAME', '$db_name' );

/** Database username */
define( 'DB_USER', '$db_username' );

/** Database password */
define( 'DB_PASSWORD', '$db_user_password' );

/** Database hostname */
define( 'DB_HOST', '$db_RDS' );

/** Database charset to use in creating database tables. */
define( 'DB_CHARSET', 'utf8' );

/** The database collate type. Don't change this if in doubt. */
define( 'DB_COLLATE', '' );

/**#@+
 * Authentication unique keys and salts.
 *
 * Change these to different unique phrases! You can generate these using
 * the {@link https://api.wordpress.org/secret-key/1.1/salt/ WordPress.org secret-key service}.
 *
 * You can change these at any point in time to invalidate all existing cookies.
 * This will force all users to have to log in again.
 *
 * @since 2.6.0
 */
define( 'AUTH_KEY',         'put your unique phrase here' );
define( 'SECURE_AUTH_KEY',  'put your unique phrase here' );
define( 'LOGGED_IN_KEY',    'put your unique phrase here' );
define( 'NONCE_KEY',        'put your unique phrase here' );
define( 'AUTH_SALT',        'put your unique phrase here' );
define( 'SECURE_AUTH_SALT', 'put your unique phrase here' );
define( 'LOGGED_IN_SALT',   'put your unique phrase here' );
define( 'NONCE_SALT',       'put your unique phrase here' );

/**#@-*/

/**
 * WordPress database table prefix.
 *
 * You can have multiple installations in one database if you give each
 * a unique prefix. Only numbers, letters, and underscores please!
 */
$table_prefix = 'wp_';

/**
 * For developers: WordPress debugging mode.
 *
 * Change this to true to enable the display of notices during development.
 * It is strongly recommended that plugin and theme developers use WP_DEBUG
 * in their development environments.
 *
 * For information on other constants that can be used for debugging,
 * visit the documentation.
 *
 * @link https://wordpress.org/support/article/debugging-in-wordpress/
 */
define( 'WP_DEBUG', false );

/* Add any custom values between this line and the "stop editing" line. */



/* That's all, stop editing! Happy publishing. */

/** Absolute path to the WordPress directory. */
if ( ! defined( 'ABSPATH' ) ) {
	define( 'ABSPATH', __DIR__ . '/' );
}

/** Sets up WordPress vars and included files. */
require_once ABSPATH . 'wp-settings.php';
EOF