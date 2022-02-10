#! /bin/bash                                                                                            
sudo yum install httpd php php-mysql -y -q                                                              
sudo cd /var/www/html                                                                                   
echo "Hello World! MCLOUD" > hw.html                                                                                
sudo wget https://wordpress.org/wordpress-5.1.1.tar.gz                                                  
sudo tar -xzf wordpress-5.1.1.tar.gz                                                                    
sudo cp -r wordpress/* /var/www/html/                                                                   
sudo rm -rf wordpress                                                                                   
sudo rm -rf wordpress-5.1.1.tar.gz                                                                      
sudo chmod -R 755 wp-content                                                                            
sudo chown -R apache:apache wp-content                                                                  
sudo wget https://s3.amazonaws.com/bucketforwordpresslab-donotdelete/htaccess.txt                       
sudo mv htaccess.txt .htaccess                                                                          
sudo systemctl start httpd                                                                              
systemctl enable httpd