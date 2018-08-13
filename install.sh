#!/bin/bash  

echo ""
echo "#######################################################################"
echo "#                          Start to configurate!                      #"
echo "#                                 V 1.0.0                             #"
echo "#######################################################################"
echo ""


echo ""
swDir="/SW"
#downloadFolderName="ubuntuSW"

sudo mkdir ${swDir}
#sudo mkdir ~/Downloads/${downloadFolder}

# update system
echo "update system"
sudo apt-get update -y
sudo apt-get upgrade -y

# 安装搜狗拼音

echo "安装搜狗拼音..."
sudo apt-get install fcitx
sudo apt-get install fcitx-config-gtk
sudo apt-get install fcitx-table-all
sudo apt-get install im-switch
if [ ! -f "./sogoupinyin_amd64.deb"]; then
    echo "不存在sogoupinyin_amd64.deb"
    echo "开始下载sogoupinyin_amd64.deb"
    wget -c "https://pinyin.sogou.com/linux/download.php?f=linux&bit=64" -O "sogoupinyin_amd64.deb"
    echo "开始安装sogoupinyin_amd64.deb"
    sudo dpkg -i sogoupinyin_amd64.deb
    sudo apt -f -y install
    sudo dpkg -i sogoupinyin_amd64.deb
else
    echo "开始安装sogoupinyin_amd64.deb"
    sudo dpkg -i sogoupinyin_amd64.deb
    sudo apt -f -y install
    sudo dpkg -i sogoupinyin_amd64.deb
fi

# 安装System Monitor
echo "正在安装System Monitor..."
sudo add-apt-repository ppa:fossfreedom/indicator-sysmonitor
sudo apt-get update
sudo apt-get install indicator-sysmonitor
indicator-sysmonitor &  # 按ctrl+C退出

# 安装sublime text3
echo "安装sublime text3..."
if [ ! -f "./sublime_text_3_build_3143_x64.tar.bz2" ]; then
    echo "不存在sublime_text_3_build_3143_x64.tar.bz2"
    echo "开始下载sublime_text_3_build_3143_x64.tar.bz2"
    wget "https://download.sublimetext.com/sublime_text_3_build_3143_x64.tar.bz2" -O "sublime_text_3_build_3143_x64.tar.bz2"
    sudo dpkg -i sublime_text_3_build_3143_x64.tar.bz2
    sudo tar -xjvf sublime_text_3_build_3143_x64.tar.bz2
    sudo mv sublime_text_3 /opt/  
    sudo ln -s /opt/sublime_text_3/sublime_text /usr/bin/subl
else
    sudo dpkg -i sublime_text_3_build_3143_x64.tar.bz2
    sudo tar -xjvf sublime_text_3_build_3143_x64.tar.bz2
    sudo mv sublime_text_3 /opt/
    sudo ln -s /opt/sublime_text_3/sublime_text /usr/bin/subl
fi


# install some tools:
echo "install git"
sudo apt-get install git -y
echo "install curl"
apt-get install curl -y
echo "install gdebi"
apt-get install gdebi -y
echo "install vim"
sudo apt-get install -y vim
echo "install unzip"
sudo apt-get install unzip -y
echo "install unrar"
sudo apt-get install unrar -y
echo "install gradle 4.2.1"            0
sdk install gradle 4.2.1
gradle -version
echo "install docker.io"
sudo apt-get install -y docker.io
sudo docker pull  nginx
sudo docker pull tomcat
sudo docker pull mysql
echo "install clementine"
sudo apt-get install clementine -y

# fixed time zone problem
echo "time fix..."
sudo timedatectl set-local-rtc true
sudo timedatectl set-ntp true


# generate github ssh public key
while getopts "g: b: c:" arg #选项后面的冒号表示该选项需要参数
do
        case $arg in
             g)
                echo "a's arg:$OPTARG" #参数存在$OPTARG中
                # configure github ssh public key
                ssh-keygen -t rsa -b 4096 -C "$OPTARG"
                eval "$(ssh-agent -s)"
                ssh-add ~/.ssh/id_rsa
                sudo apt-get install xclip
                xclip -sel clip < ~/.ssh/id_rsa.pub
                cat ~/.ssh/id_rsa > ~/desktop/github_ssh_key.txt
                eval "$(ssh-agent -s)"
                ssh-add
                ;;
             b)
                echo "b's arg:$OPTARG"
                ;;
             c)
                echo "c"
                ;;
             ?) #当有不认识的选项的时候arg为?
            echo "unkonw argument"
        exit 1
        ;;
        esac
done


#install gnome desktop
echo "install gnome shell and tweak tool"
sudo apt-get install gnome-session -y
sudo apt-get install gnome-tweak-tool -y
sudo apt-get install gnome-shell-extensions

# install gnome arc theme
echo "install gnome arc theme"
sudo add-apt-repository ppa:noobslab/themes -y
sudo apt-get update -y
sudo apt-get install arc-theme -y

# install gnome flat remix icon

echo "install gnome flat remix icon"
sudo add-apt-repository ppa:noobslab/icons -y
sudo apt-get update -y
sudo apt-get install flat-remix-icons -y

# install dash to dock
echo "install dash to dock plug in"
cd ~/Downloads
git clone https://github.com/micheleg/dash-to-dock.git
cd dash-to-dock
make 
make install

# install nodejs and npm
echo "configure nodejs and npm environment"
curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash -
sudo apt-get install -y nodejs
sudo apt-get install -y build-essential




# install oracle jdk
echo "ready configure oracle java jdk"
jdkContainer="jdk.tar.gz"
cd ~/Downloads
sudo wget -O ${jdkContainer} --no-check-certificate -c --header "Cookie: oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jdk/8u151-b12/e758a0de34e24606bca991d704f6dcbf/jdk-8u151-linux-x64.tar.gz
tar -xvzf ${jdkContainer}
sudo mv  ~/Downloads/jdk1.8.0_151 ${swDir}/jdk

sudo echo "export JAVA_HOME=${swDir}/jdk" >> /etc/profile
sudo echo "export JRE_HOME=\${JAVA_HOME}/jre" >> /etc/profile
sudo echo "export CLASSPATH=.:\${JAVA_HOME}/lib:\${JRE_HOME}/lib" >> /etc/profile
sudo echo "export PATH=\${JAVA_HOME}/bin:\$PATH" >> /etc/profile
source /etc/profile
echo "finish configure oracle java jdk"



echo ""
echo "#######################################################################"
echo "#                        INSTALL SOFTWARE                             #"
echo "#######################################################################"
echo ""


androidStudioLink="https://dl.google.com/dl/android/studio/ide-zips/2.3.3.0/android-studio-ide-162.4069837-linux.zip"
intellijIdeaLink="https://download-cf.jetbrains.com/idea/ideaIU-2017.2.5.tar.gz"
skypeLink="https://repo.skype.com/latest/skypeforlinux-64.deb"
vsCodeLink="https://az764295.vo.msecnd.net/stable/b813d12980308015bcd2b3a2f6efa5c810c33ba5/code_1.17.2-1508162334_amd64.deb"
virtualBoxLink="http://download.virtualbox.org/virtualbox/5.2.0/virtualbox-5.2_5.2.0-118431~Ubuntu~xenial_amd64.deb"
#osxArcCollectionThemeLink="https://github-production-release-asset-2e65be.s3.amazonaws.com/77880841/16a14c7c-45a6-11e7-81ac-28673f670d57?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAIWNJYAX4CSVEH53A%2F20171022%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20171022T093955Z&X-Amz-Expires=300&X-Amz-Signature=98b29dcd8849047f0e774fa1dd00353c8d8c60e4927c6273aa9afba5f5e3d14b&X-Amz-SignedHeaders=host&actor_id=22359905&response-content-disposition=attachment%3B%20filename%3Dosx-arc-collection_1.4.3_amd64.deb"
googleChromeLink="https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb"
sougouLink="http://cdn2.ime.sogou.com/dl/index/1491565850/sogoupinyin_2.1.0.0086_amd64.deb?st=bBYOyY4OxnTa-_ElgJuKDw&e=1508784697&fn=sogoupinyin_2.1.0.0086_amd64.deb"
netMusicLink="http://s1.music.126.net/download/pc/netease-cloud-music_1.0.0-2_amd64_ubuntu16.04.deb"



# install software
cd ~/Downloads/
# install sougou input 
sougouName="sougou.deb"
sudo wget -O ${sougouName} -c ${sougouLink}
sudo dpkg -i ${sougouName}

skypeName="skype.deb"
sudo wget -O ${skypeName} -c ${skypeLink}
sudo dpkg -i ${skypeName}


vscodeName="vsCode.deb"
sudo wget -O ${vscodeName} -c ${vsCodeLink}
sudo dpkg -i ${vscodeName}

virtualBoxName="virtualBox.deb"
sudo wget -O ${virtualBoxName} -c ${virtualBoxLink}
sudo dpkg -i ${virtualBoxName}

chromeName="chrome.deb"
sudo wget -O ${chromeName} -c ${googleChromeLink}
sudo dpkg -i ${chromeName}

netMusicName="netMusic.deb"
sudo wget -O ${netMusicName} -c ${netMusicLink}
sudo dpkg -i ${netMusicName}

#http link error
#osxArcName="osxArc.deb"
#sudo wget -O ${osxArcName} --no-check-certificate -c ${osxArcCollectionThemeLink}
#sudo dpkg -i ${osxArcName}

#install genymotion
genymotionLink="https://dl.genymotion.com/releases/genymotion-2.10.0/genymotion-2.10.0-linux_x64.bin"
genymotionName="genymotion.bin"
sudo wget -O ${genymotionName} --no-check-certificate -c ${genymotionLink}
chmod +x ${genymotionName}
sudo ./${genymotionName}

#install android studio
sudo wget -c ${androidStudioLink}
unzip android-studio-ide-162.4069837-linux.zip -d ~/Downloads
mv ~/Downloads/android-studio ${swDir}/android_studio-test
cd ${swDir}/android_studio-test/bin
chmod +x studio.sh
./studio.sh 

#install intellij
sudo wget -c ${intellijIdeaLink}
tar -xvzf ideaIU-2017.2.5.tar.gz
mv idea-IU-172.4343.14 ${swDir}/idea-IU-172.4343.14
cd ${swDir}/idea-IU-172.4343.14/bin
./idea.sh 



echo ""
echo "#######################################################################"
echo "#                          FINISH!!!!!!!!!                            #"
echo "#######################################################################"
echo ""



# install linux weixin
#git clone https://github.com/geeeeeeeeek/electronic-wechat.git
# Go into the repository
#cd electronic-wechat
# Install dependencies and run the app
#npm install && npm start
#npm run build:linux
