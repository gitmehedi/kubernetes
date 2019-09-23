# CI/CD
[Documentation](#guideline)

## Install gradle in Debian/Ubuntu
```
cd ~/
wget -O ~/gradle-4.7-bin.zip https://services.gradle.org/distributions/gradle-4.7-bin.zip
sudo yum -y install unzip java-1.8.0-openjdk
sudo mkdir /opt/gradle
sudo unzip -d /opt/gradle/ ~/gradle-4.7-bin.zip
```
Create a file in 
```
$ sudo vi /etc/profile.d/gradle.sh
```
and insert below code in here
```
$ export PATH=$PATH:/opt/gradle/gradle-4.7/bin
$ sudo chmod 755 /etc/profile.d/gradle.sh
```
### And the commands used to install and run the Gradle Wrapper:
```
cd ~/
mkdir my-project
cd my-project
gradle wrapper
./gradlew build
```
### Example of gradle
```
plugins {
  id 'com.moowork.node' version '1.2.0'
}

task sayHello  {
  doLast {
    println 'Hello, World!'
  }
}

task anotherTask  {
  doLast {
    println 'This is another task'
  }
}
```
and above code using
```
gradle sayHello or ./gradlew sayHello
```
## Install Jenkins in Debian/Ubuntu 
```
wget -q -O - https://pkg.jenkins.io/debian/jenkins.io.key | sudo apt-key add -
sudo sh -c 'echo deb https://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'
sudo apt-get update -y
sudo apt-get install jenkins
```
Browse to ```http://localhost:8080``` (or whichever port you configured for Jenkins when installing it) and wait until the Unlock Jenkins page appears.

