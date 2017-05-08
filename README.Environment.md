Setup Development Environment
===

In this documentation is shared the setup of the development environment for Java Enterprise in Ubuntu

## 1.1. 3rd-Party Components

| # | Software     | Version      | Command           | PATH                |
| - | ------------ | ------------ | ----------------- | ------------------- |
| 0 | Ubuntu       | 16.04.01 LTS | lsb_release -a    | /home/esales        |
| 1 | Oracle Java  | 1.8.0_121    | java -version     | /etc/java-8-oracle/ |
| 1 | MAVEN        | 3.3.9        | mvn -v            | /usr/share/maven    |
| 1 | ANT          | 1.9.6        | ant -v            | /usr/share/ant      |
| 2 | PostgreSQL   | 9.4.11       | psql --version    | /etc/postgresql     |
| 3 | Tomcat       |              |         |                   |
| 5 | ImageMagick  | 6.8.9-9      | convert --version |                   |
| 9 | FFMPeg       | 3.2.4        | ffmpeg            |                   |
| 4 | SWFTools     |        |             |                   |
| 4 | LibreOffice  |        |             |                   |
| 8 | Eclipse J2EE | Neon         | UNCHECK           |                     |


> 8GB RAM available in the server: 4 for Alfresco and the other for PostgreSQL, LibreOffice and OS
> Repository size is 30 GB and it includes more than 100.000 documents
> Authentication is integrated with OpenLDAP


## 1.2. //TODO: Angular2 & NodeJS Environment

| # | Software     | Version      | Command           | PATH                |
| - | ------------ | ------------ | ----------------- | ------------------- |
| 4 | NodeJS       | v6.10.1 LTS  | node -v           |                   |
| 5 | npm          | v4.4.4       | npm -v            |                   |
| 6 | angular-cli  |              | ng version        |                   |
| 7 | ng           |              | ng version        |                   |
| 8 | Eclipse J2EE | Neon         | UNCHECK           |                   |
| 9 | Augury       |              | 10.138.1.1        |                   |

### 1. Create Google Compute Engine Instance

| #  | PARAMS                | DEFAULT (alfresco-ubuntu-install)             | Description                                   |
| -- | --------------------- | --------------------------------------------- | --------------------------------------------- |
|  1 | ALF_HOME              | /opt/alfresco                                 |                                               |
|  2 | ALF_DATA_HOME         | $ALF_HOME/alf_data                            |                        |
|  3 | ALF_USER              | alfresco                                      |                                     |
|  3 | ALF_GROUP             | $ALF_USER                                     |                                     |
|  4 | TMP_INSTALL           | /tmp/alfrescoinstall                          |                               |

|  2 | CATALINA_HOME         | $ALF_HOME/tomcat                              |                        |

|  5 | TOMCAT_DOWNLOAD       |                                               |                                               |
|  6 | JDBCPOSTGRESURL       |                                               |                                               |
|  7 | JDBCPOSTGRES          |                                               |                                               |
|  8 | JDBCMYSQLURL          |                                               |                                               |
|  9 | JDBCMYSQL             |                                               |                                               |
| 10 | LIBREOFFICE           |                                               |                                               |
| 11 | ALFREPOWAR            |                                               |                                               |
| 12 | ALFSHAREWAR           |                                               |                                               |
| 13 | ALFSHARESERVICES      |                                               |
| 16 | SOLR4_WAR_DOWNLOAD    |                                               |                                               |
| 17 | SOLR4_CONFIG_DOWNLOAD |                                               |                                               |                                               |
| 14 | GOOGLEDOCSREPO        |                                               |                                               |
| 15 | GOOGLEDOCSSHARE       |                                               |                                               |
| 18 | AOS_VTI               |                                               |                                               |
| 19 | AOS_SERVER_ROOT       |                                               |                                               |
| 20 |                       |                                               |                                               |


===

# Branch name to pull from server. Use master for stable.
BRANCH=master
export BASE_DOWNLOAD=https://raw.githubusercontent.com/loftuxab/alfresco-ubuntu-install/$BRANCH
export KEYSTOREBASE=https://svn.alfresco.com/repos/alfresco-open-mirror/alfresco/HEAD/root/projects/repository/config/alfresco/keystore

#Change this to prefered locale to make sure it exists. This has impact on LibreOffice transformations
#export LOCALESUPPORT=sv_SE.utf8
export LOCALESUPPORT=en_US.utf8
===

- Upgrade Ubuntu Packages

  ```
   sudo apt-get update && sudo apt-get upgrade
  ```
 
## 1. Installing & Configuring Java 8

- Option 1: Default Java

  ```
   sudo apt-get install default-jdk
  ```

- Option 2: Oracle JDK

  ```
   sudo apt-get install oracle-java8-installer
  ```


- 1.1. Download Java



  ```
   sudo apt-get install openjdk-8*
  ```

  ``` //BUG: Maven No compiler is provided in this environment. Perhaps you are running on a JRE rather than a JDK?
   cd /home/esales/download
   sudo add-apt-repository ppa:webupd8team/java
   sudo apt-get update
   sudo apt-get install oracle-java8-installer
  ```

  ```Workdesk
   sudo apt-get install openjdk-7-jdk
  ```
  
- 1.2. Java Version: `java -version`

  ```
   // sudo update-alternatives --config java
   // sudo update-java-alternatives -s java-8-oracle
   // sudo update-java-alternatives -l
  ```

- 1.3. If not `echo $JAVA_HOME` then `sudo nano /etc/environment`

  ```GCP
   // JAVA_HOME="/usr/lib/jvm/java-8-oracle"
   JAVA_HOME="/usr/lib/jvm/java-8-openjdk-amd64"
  ```
  
  ```AlfrescoInstaller
   JAVA_HOME="/usr/lib/jvm/java-8-openjdk-amd64"
  ``` 

  ```Workdesk
   JAVA_HOME="/usr/lib/jvm/java-7-openjdk-amd64"
  ```
  
  ```
   //Reload Java
   source /etc/environment
  ```
  
> Check JAVA_HOME: `env | grep JAVA_HOME` or `echo $JAVA_HOME`

- 1.4.1. Maven in Ubuntu

  ```
   sudo apt-get install maven
   mvn -v
  ```

- 1.4.2. Maven in MacOS: [MAVEN.3.5.0](https://maven.apache.org/download.cgi) & [ANT.1.9.7](https://ant.apache.org/bindownload.cgi) 

> `sudo nano ~/.bash_profile`

  ```
   export M2_HOME=/Library/Java/maven      
   export PATH=$PATH:$M2_HOME/bin 

   export ANT_HOME=/Library/Java/apache-ant-1.9.7
  ```

- 1.4.3. Check version: 

  ```
   mvn -v
   // ls ~/.m2/repository
   
   ant -v
  ```


- 1.5. 

  ```
   export ANT_OPTS="-Xmx1024M -XX:MaxPermSize=128M"
   
   export CATALINA_OPTS="-Djava.awt.headless=true -Xms384M -Xmx512M -XX:MaxPermSize=256M"
   
   echo 'export CATALINA_OPTS="-server -Djava.awt.headless=true -Xms384M -Xmx1536M -XX:MaxPermSize=256M"' >> /etc/profile.d/tomcat.sh
  ```


### 2. [Install PostgreSQL](https://www.postgresql.org/download/linux/ubuntu/)

- 2.1. Install PostgreSQL 9.4.x

  ```
   // Add a line for the repository
   sudo sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt/ $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list'
   
   // Import the repository signing key
   wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -

   // update the package lists & install
   sudo apt-get update
   sudo apt-get install postgresql-9.4 pgadmin3
  ```

- 2.2. PostgreSQL Checklist

  ```
   psql --version

   dpkg -l | grep postgres
  ```

- 2.3. `sudo -u postgres psql postgres` --> $`postgres=#`

  ``` 
    \password postgres
    // Enter new password: MyPassion2017
    \q
  ```

- 2.4. `sudo nano /etc/postgresql/9.4/main/pg_hba.conf`

  ```
   //Change the line described below, setting `peer` to `md5`.

   # Database administrative login by Unix domain socket
   local   all             postgres                                md5
   

  ```

- 2.5. Configure PostgreSQL Remote Access

> 2.5.1. Edit pg_hba.conf: `sudo nano /etc/postgresql/9.4/main/pg_hba.conf`

  ```
   // [Get local-computer-IP](http://ip4.me)
   115.79.48.173
  ```

  ```
   # IPv4 remote connections:
   host    all             all             115.79.48.173/32            md5
  ```
  
> 2.5.2. Edit postgresql.conf: `sudo nano /etc/postgresql/9.4/main/postgresql.conf `

  ```
   # Delete `#` character & replace `localhost` with `*`
   listen_addresses = '*'                  # what IP address(es) to listen on;
   
   # max_connections = 275
   max_connections = 600
   
   # Retrieving decimal numbers in the database
   lc_numeric = 'en_US.UTF-8'
   # PostgreSQL on windows then ` lc_numeric = 'English_United States.1252'`   
  ```   


> 2.5.3. Restart Database Service
  
  ```
   sudo service postgresql restart
  ```
    
> 2.5.4. [Google Cloud Console > Networking > Firewall Rules](https://console.cloud.google.com/networking/firewalls/list?project=smart-enterprise&organizationId=1064385271676): `CREATE FIREWALL RULE`

  ```
   Name: postgres-remote-access
   Source IP ranges: 115.79.48.173
   Allowed protocols and ports: tcp:5432
  ```
  
      
- 2.6. To complete the installation, reload the database service eceting the command below.

    `sudo /etc/init.d/postgresql reload`

- 2.6. Execute `pgadmin3` and add the `localhost` connection to administer the database instances.



- 2.8. Restart PostgreSQL

  ```
   /etc/init.d/postgresql restart
  ```
  
  
### 3. Install Tomcat 8

- 3.1. Create `esales` User: (Note: to list all local users `cut -d: -f1 /etc/passwd` )

  ```
   sudo mkdir esales
   sudo groupadd esales
   sudo useradd -s /bin/false -g esales -d /home/esales/tomcat esales
   // Add existing user thanhnguyen to esales group
   sudo usermod -a -G esales thanhnguyen
  ```   

- 3.2. Download Tomcat

  $CATALINA_HOME = =$ALF_HOME/tomcat = /home/esales/tomcat

  ```
   sudo curl -# -L -O http://archive.apache.org/dist/tomcat/tomcat-8/v8.0.38/bin/apache-tomcat-8.0.38.tar.gz
   sudo tar xf "$(find . -type f -name "apache-tomcat*")"
   sudo mv "$(find . -type d -name "apache-tomcat*")" /home/esales/tomcat
   // Remove apps not needed
   sudo rm -rf tomcat/webapps/docs/ tomcat/webapps/examples/
  ```

  ```
   //TODO
   sudo mkdir /home/esales/logs
  ```

- 3.3. Update Permissions

  ```
   cd /home/esales/tomcat
   // esales group read access & execute to the conf directory
   sudo chgrp -R esales /home/esales/tomcat
   sudo chmod -R g+r conf
   // esales user the owner of the webapps, work, temp, and logs
   sudo chown -R esales webapps/ work/ temp/ logs/
   // sudo chown -R esales tomcat/
  ```
  
- 3.4. Download esales.service & esales-service.sh; then


  ```
   cd /home/esales
   sudo mv esales.service /etc/systemd/system/
   sudo chmod 755 esales-service.sh
  ```

- 3.5. `sudo nano tomcat/conf/tomcat-users.xml `

  ```
   <user username="admin" password="MyPassion2017" roles="manager-gui,admin-gui"/>
  ```

-  3.6. Start & Stop Tomcat
  
  ```
   sudo /home/esales/esales-service.sh start
   sudo /home/esales/esales-service.sh stop
   tail -f /home/esales/tomcat/logs/catalina.out
  ```
    
- //TODO: Install and configure authbind

  ```
   sudo apt install authbind
   sudo touch /etc/authbind/byport/{443,80}
   sudo chmod 500 /etc/authbind/byport/{443,80}
   sudo chown esales:esales /etc/authbind/byport/{443,80}
  ```

- //TODO: Configure Tomcat server.xml

  ```
   sudo sed -i 's/8080/80/g' /home/esales/tomcat/conf/server.xml
   sudo sed -i 's/8443/443/g' /home/esales/tomcat/conf/server.xml
  ```
  
- //TODO: Enable the service

  `sudo mv /home/thanhnguyen/esales.service /etc/systemd/system/`

  ```  
    // Reload the systemd daemon
    sudo systemctl daemon-reload
    sudo systemctl enable esales.service
    sudo systemctl restart esales.service
  ```
  
- //TODO

  ```
   sudo /home/esales/esales-service.sh start
   sudo /home/esales/esales-service.sh stop
   sudo /home/esales/esales-service.sh status
   sudo /home/esales/esales-service.sh cleanup
  ```  

- //TODO: Keystore
  
  ```
   
   sudo mkdir -p /home/esales/ecm_data/keystore
   cd /home/esales/ecm_data/keystore

   // echo "Downloading keystore files..."
    sudo curl -# -o /home/esales/ecm_data/keystore/browser.p12 https://svn.alfresco.com/repos/alfresco-open-mirror/alfresco/HEAD/root/projects/repository/config/alfresco/keystore/browser.p12 &&
    sudo curl -# -o /home/esales/ecm_data/keystore/generate_keystores.sh https://svn.alfresco.com/repos/alfresco-open-mirror/alfresco/HEAD/root/projects/repository/config/alfresco/keystore/generate_keystores.sh &&
    sudo curl -# -o /home/esales/ecm_data/keystore/keystore https://svn.alfresco.com/repos/alfresco-open-mirror/alfresco/HEAD/root/projects/repository/config/alfresco/keystore/keystore &&
    sudo curl -# -o /home/esales/ecm_data/keystore/keystore-passwords.properties https://svn.alfresco.com/repos/alfresco-open-mirror/alfresco/HEAD/root/projects/repository/config/alfresco/keystore/keystore-passwords.properties &&
    sudo curl -# -o /home/esales/ecm_data/keystore/ssl-keystore-passwords.properties https://svn.alfresco.com/repos/alfresco-open-mirror/alfresco/HEAD/root/projects/repository/config/alfresco/keystore/ssl-keystore-passwords.properties &&
    sudo curl -# -o /home/esales/ecm_data/keystore/ssl-truststore-passwords.properties https://svn.alfresco.com/repos/alfresco-open-mirror/alfresco/HEAD/root/projects/repository/config/alfresco/keystore/ssl-truststore-passwords.properties &&
    sudo curl -# -o /home/esales/ecm_data/keystore/ssl.keystore https://svn.alfresco.com/repos/alfresco-open-mirror/alfresco/HEAD/root/projects/repository/config/alfresco/keystore/ssl.keystore &&
    sudo curl -# -o /home/esales/ecm_data/keystore/ssl.truststore https://svn.alfresco.com/repos/alfresco-open-mirror/alfresco/HEAD/root/projects/repository/config/alfresco/keystore/ssl.truststore
  ```
 
- //TODO: iptables

  `sudo ufw allow 80`

  `sudo iptables -t nat -A PREROUTING -i eth0 -p tcp --dport 80 -j REDIRECT --to-port 80`

- //TODO: Check if eSales is running properly.

  ```
   systemctl status esales.service
   // Service Troubleshooting
   journalctl -xe
  ```


- //TODO: : Tomcat automatically starts at boot

  ```
   sudo systemctl enable esales
  ```

### 5. Installation of the Dependencies

- Install ImageMagick

  ```
   sudo wget http://www.imagemagick.org/download/ImageMagick.tar.gz
   sudo tar -xvf ImageMagick.tar.gz
   cd ImageMagick-7.*
   ./configure
   make
   sudo make install
   sudo ldconfig /usr/local/lib
  ```

  ```
   sudo apt-get install ghostscript imagemagick
   convert --version
   // $ `whereis convert`
  ```

- Install FFMPeg

  ```
   sudo add-apt-repository ppa:jonathonf/ffmpeg-3
   sudo apt update && sudo apt install ffmpeg libav-tools x264 x265
  ```

  ```
   // To restore and downgrade FFmpeg to the stock version in Ubuntu 16.04
   sudo apt install ppa-purge && sudo ppa-purge ppa:jonathonf/ffmpeg-3
  ```

- 

  ```
   sudo wget http://dl.fedoraproject.org/pub/epel/6/x86_64/unpaper-0.3-4.el6.x86_64.rpm
   
  ```  

- Install SWFTools

  ```
   sudo apt-get install swftools
   
  ```


## 10. Installing and Configuring NodeJS

- Running NodeJS on Linux on Windows (Bash on Ubuntu on Windows)

  ```
   curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash -
   sudo apt-get install nodejs
  ``` 

-

  ```
   curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.32.0/install.sh | bash
   . ~/.nvm/nvm.sh
   nvm install 6.10.1
  ```

- 

  ```
   sudo npm install express -g

   // Node.js App with forever running as a service daemon
    sudo npm install forever -g
  ```

  ```
   // sudo mkdir /home/environment
   sudo yum install git
   git clone https://SolutionPortal@bitbucket.org/ttvsolutions/prudential.git
   cd prudential/src/Server/TCTAV\ Server/
   npm install
  ```

  ```
   http://ec2-54-255-158-200.ap-southeast-1.compute.amazonaws.com:4000/
  ```



## A. Openbravo ERP 

### 11.1. : $ `sudo nano postgresql.conf`

  ```
     lc_numeric = 'en_US.UTF-8'
  ```

###

## B. Alfresco ECM

  ```
   sudo apt-get install zip unzip
  ```

## C. Activiti BPM

- 

  ```
   sudo curl -# -L -O https://github.com/Activiti/Activiti/releases/download/activiti-5.22.0/activiti-5.22.0.zip
   unzip activiti-5.22.0.zip
  ```

  sudo cp activiti-5.22.0/wars/* ecm/tomcat/webapps/

- 

  ```
   sudo curl -# -L -O https://github.com/Activiti/Activiti/releases/download/activiti-6.0.0.Beta4/activiti-6.0.0.Beta4.zip
   sudo unzip activiti-6.0.0.Beta4.zip
  ```

  sudo cp activiti-6.0.0.Beta4/wars/* ecm/tomcat/webapps/
  
- Roles & Responsibility

| # | User, Password       | Roles                                                  | Description                     |
| - | -------------------- | ------------------------------------------------------ | ------------------------------- |
| 1 |                      | User, Sales, Marketing, Engineering, Management, Admin | kermit                          |
| 2 |                      | User, Sales, Marketing,              !Management        | gonzo                           |
| 3 |                      | User,        Marketing, Engineering                    | fozzie       |

 - `sudo nano /home/enterprise/ecm/tomcat/webapps/activiti-explorer/WEB-INF/classes/db.properties`

   ```
    db=h2
    jdbc.driver=org.h2.Driver
    jdbc.url=jdbc:h2:mem:activiti;DB_CLOSE_DELAY=1000
    jdbc.username=sa
    jdbc.password=
   ```

   ```
    db=activitiBPM
    jdbc.driver=org.postgresql.Driver
    jdbc.url=jdbc:postgresql://localhost:5432/activitiBPM
    jdbc.username=postgre
    jdbc.password=
   ```

- Activiti Enterprise

  ```
   datasource.driver=org.postgresql.Driver
   datasource.url=jdbc:postgresql://localhost:5432/activiti
   hibernate.dialect=org.hibernate.dialect.PostgreSQLDialect
   datasource.preferred-test-query=select 1
  ```
  
- 

  ```
    admin, test
  ```