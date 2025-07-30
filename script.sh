sudo apt update -y
sudo apt install -y nginx
sudo systemctl start nginx
sudo systemctl enable nginx
echo "<h1>welcome to your nginx server!</h1>" | sudo tee /var/www/html/index.html
sudo systemctl restart nginx
echo "provisioning completed!"
