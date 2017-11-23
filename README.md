# Hosting Drupal 8 on Elastic Beanstalk using Ubuntu/PHP/Nginx

This repo is referenced from a [post from Delicious Brain](https://deliciousbrains.com/hosting-wordpress-2017-update/) in order to create a good performance WordPress environment. 
This project is revised from [AWS Sample NodePlatform_Ubuntu.zip](http://docs.aws.amazon.com/elasticbeanstalk/latest/dg/custom-platforms.html#custom-platforms-sample), I am not a Ubuntu/Nginx expert, any feedback will be very appreciated.

## Howto

### Install Elastic Beanstalk CLI
- [Install the Elastic Beanstalk Command Line Interface (EB CLI)](http://docs.aws.amazon.com/elasticbeanstalk/latest/dg/eb-cli3-install.html)

### Config wp_eb_nginx_customize.json **builders** section
- region: input your aws region
- source_ami: check [Ubuntu](#Ubuntu) section to choose your AMI 
- instance_type: input the type you need
- ami_name: specify your AMI name

### Create Elastic Beanstalk Custom Platform
- In your project folder, execute the following
```
eb platform init
eb platform create
```
- More information can ref to [Launch: AWS Elastic Beanstalk launches support for Custom Platforms](https://aws.amazon.com/blogs/aws/launch-aws-elastic-beanstalk-launches-support-for-custom-platforms/)

## Environment built by this repo

### Ubuntu 16.04<a name="Ubuntu"></a>
- Depends on where your region is, change **region** and **source_ami** in [wp_eb_nginx_customize.json](wp_eb_nginx_customize.json)
- **Please use the AMI release BEFORE 2017/03/29** due to Ubuntu issue,  the issue is with the kernel version "vmlinuz-4.4.0-72-generic".
Beanstalk environment builder generates a second version of "wp_eb_nginx_customize.json" configuration file named "eb-packer.json" by appending a command to run "eb-bootstrap.sh" on the base instance for the AMI. 
This "eb-bootstrap.sh" bootstraps the AMI with the Beanstalk gems, tarballs etc. 
In executing one of the command "apt-get upgrade" of eb-bootstrap.sh file, it is getting stuck and the environment is timing out. 
This is because new kernel version throws an interactive prompt while running "apt-get upgrade" to let the user decide how/if to replace the existing GRUB "menu.lst" configuration that decides the sequence/priority of available kernels to load during boot-up. 
I even put `export DEBIAN_FRONTEND=noninteractive` in shell script but it doesn't help.
So please use the AMI release before 2017/03/29 at this moment.
- You can go to [https://cloud-images.ubuntu.com/locator/](https://cloud-images.ubuntu.com/locator/) to find the latest AMI in your region by using following filters

|Filter|Value|
|:---:|:---:|
|Cloud|Amazon AWS|
|Zone|[choose your region]|
|Name|xenial|
|Version|16.04|
|Arch|amd64|
|Instance Type|hvm-ssd|
|Release|[choose the one before 20170329]|

### Nginx
- Use [mainline version](https://deliciousbrains.com/hosting-wordpress-yourself-nginx-php-mysql/)
- [Difference between 2 branches](https://www.nginx.com/blog/nginx-1-6-1-7-released/)
- Use [FastCGI caching](https://deliciousbrains.com/hosting-wordpress-yourself-server-monitoring-caching/#page-cache)

### PHP 7.1
- This PHP is maintained by [Ondřej Surý](https://launchpad.net/~ondrej/+archive/ubuntu/php)

## Start Your Drupal8
Please go to [https://github.com/patilstar/eb_ubuntu_nginx_php_platform](https://github.com/patilstar/eb_ubuntu_nginx_php_platform)

## References
- [Hosting Drupal 8 Update](https://www.itekniikka.com/blog/hosting-aws-ubuntu16-drupal8-php7-eb-nginx-mariadb)
https://deliciousbrains.com/hosting-wordpress-setup-secure-virtual-server/
- [AWS Elastic Beanstalk Supports Custom Platforms](https://aws.amazon.com/tw/about-aws/whats-new/2017/02/aws-elastic-beanstalk-supports-custom-platforms/)
- [Launch: AWS Elastic Beanstalk launches support for Custom Platforms](https://aws.amazon.com/tw/blogs/aws/launch-aws-elastic-beanstalk-launches-support-for-custom-platforms/)

ssh -i key.pem ubuntu@xxx.xxx.xxx.xxx
    sudo apt-get update
    sudo apt-get upgrade
    sudo apt-get autoremove
    sudo dpkg-reconfigure tzdata
    sudo adduser deepak
    sudo usermod -a -G sudo deepak
    sudo add-apt-repository ppa:nginx/development -y
    sudo apt-get update
    sudo apt-get install nginx -y
    nginx -v

grep processor /proc/cpuinfo | wc -l
ulimit -n
		
ssh -i key.pem deepak@xxx.xxx.xxx.xxx
