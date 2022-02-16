#! /bin/bash                                                                                            
sudo yum install httpd php php-mysql -y -q                                                              
sudo cd /var/www/html                                                                                   
echo "MCLOUD" > hw.html                                                                                
sudo wget https://es.wordpress.org/wordpress-latest-es_ES.tar.gz                                                 
sudo tar -xzvf wordpress-latest-es_ES.tar.gz                                                                    
sudo cp -r wordpress/* /var/www/html/
sudo cd /var/www/html/wordpress/
sudo cp wp-config-sample.php wp-config.php
sudo cd                                                                  
sudo rm -rf wordpress                                                                                   
sudo rm -rf wordpress-latest-es_ES.tar.gz                                                                      
sudo chmod -R 755 wp-content                                                                            
sudo chown -R apache:apache wp-content                                                                  
sudo wget https://s3.amazonaws.com/bucketforwordpresslab-donotdelete/htaccess.txt                       
sudo mv htaccess.txt .htaccess                                                                          
sudo systemctl start httpd                                                                              
systemctl enable httpd