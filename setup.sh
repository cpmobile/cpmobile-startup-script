#!/bin/sh

# CP Mobile Development Environment Setup Script
#
# Author: 
#      Concept Plus, LLC
# Description: 
#      This shell script will setup a fresh 
#      Mac OSX mobile development environment 
#    

# Read setup variables
eval $(cat setup-vars.sh);

#echo "> Please enter you Stash userid: "
#read STASH_UID

# Create directories in home ~
echo "--------------------------------"
echo " Create development directories "
echo "--------------------------------"

# Development directory
if [ ! -d ~/$DEV_DIR ]; then
	echo "==> Create 'Development' directory."
  	mkdir ~/$DEV_DIR
else 
	echo "==> ~/$DEV_DIR directory exists."
fi

# Apps directory
if [ ! -d ~/$DEV_DIR/$APPS_DIR ]; then
	echo "==> Create 'Apps' directory."
  	mkdir ~/$DEV_DIR/$APPS_DIR
else 
	echo "==> ~/$DEV_DIR/$APPS_DIR directory exists."
fi

# Framework directory
# This directory will contain source code for this framework
if [ ! -d ~/$DEV_DIR/$FRAMEWORK_DIR ]; then
	echo "==> Create 'Framework' directory."
  	mkdir ~/$DEV_DIR/$FRAMEWORK_DIR
else 
	echo "==> ~/$DEV_DIR/$FRAMEWORK_DIR directory exists."
fi

# Install frameworks
echo "------------------"
echo " Installing SDKs  "
echo "------------------"

# Apache Ant
if [ ! -d ~/$DEV_DIR/$ANT_DIR ]; then
	if [ ! -f ~/$DEV_DIR/$ANT_DIR"-bin.zip" ]; then
		echo "==> Download Apache Ant $ANT_VER."
		curl -o ~/$DEV_DIR/$ANT_DIR"-bin.zip" http://apache.claz.org//ant/binaries/apache-ant-1.9.4-bin.zip
		echo "==> Extract Apache Ant."
		unzip -d ~/$DEV_DIR ~/$DEV_DIR/$ANT_DIR"-bin.zip"
	fi
else
	echo "==> Apache Ant $ANT_VER already installed."
fi

if [ -f ~/$DEV_DIR/$ANT_DIR"-bin.zip" ]; then
	echo "==> Cleanup Apache Ant download."
	rm ~/$DEV_DIR/$ANT_DIR"-bin.zip"
fi

if [ `echo $PATH | grep -c "$ANT_DIR" ` -gt 0 ]; then
  	echo "==> ~/$DEV_DIR/$ANT_DIR/bin already in PATH"
else
  	echo "==> Add ~/$DEV_DIR/$ANT_DIR/bin to PATH"
  	printf "%s\n" "export PATH=\$PATH:~/$DEV_DIR/$ANT_DIR/bin:\$PATH" >> ~/.bash_profile
fi

# Install frameworks
echo "--------------------------"
echo " Terminal customizations  "
echo "--------------------------"

# Terminal customization
if [ `echo $PS1 | grep -c "$PS1_VAL" ` -gt 0 ]; then
  	echo "==> PS1 already in PATH"
else
	echo "==> Terminal PS1 customization"
	printf "%s\n" "export PS1='$PS1_VAL'" >> ~/.bash_profile
fi
if [ `echo $CLICOLOR | grep -c "$CLICOLOR_VAL" ` -gt 0 ]; then
  	echo "==> CLICOLOR already in PATH"
else
	echo "==> Terminal CLICOLOR customization"
	printf "%s\n" "export CLICOLOR=$CLICOLOR_VAL" >> ~/.bash_profile
fi
if [ `echo $LSCOLORS | grep -c "$LSCOLORS_VAL" ` -gt 0 ]; then
  	echo "==> LSCOLORS in PATH"
else
	echo "==> Terminal LSCOLORS customization"
	printf "%s\n" "export LSCOLORS=$LSCOLORS_VAL" >> ~/.bash_profile
	printf "%s\n" "alias ls='ls -GFh'" >> ~/.bash_profile
fi


# Install applications
echo "-------------------------"
echo " Install applications  "
echo "-------------------------"

# Brew
if [ `brew --version | grep -c "$BREW_VER"` -gt 0 ]; then
  	echo "==> Brew already installed."
else
	echo "==> Install brew"
	ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# Brew Cask
if [ `brew cask --version | grep -c "$BREWCASK_VER"` -gt 0 ]; then
  	echo "==> Brew Cask already installed."
else
	echo "==> Install brew cask"
	brew tap caskroom/cask
	brew install caskroom/cask/brew-cask
fi

# Node.js
if [ `brew cask ls node | grep -c "node"` -gt 0 ]; then
  	echo "==> Node.js already installed."
else
	echo "==> Installing Node.js (npm)"
	brew cask install node 
	echo "==> Reset rights to npm directories for current user"
	sudo chown -R `whoami` ~/.npm
	sudo chown -R `whoami` /usr/local
fi

# Google Chrome
if [ `osascript -e 'version of app "google chrome"' | grep -c "$CHROME_VER"` -gt 0 ]; then
  	echo "==> Google Chrome already installed."
else
	echo "==> Installing Google Chrome (browser/debugger)"
	brew cask install google-chrome 
fi

# SourceTree
if [ `osascript -e 'version of app "sourcetree"' | grep -c "$SOURCETREE_VER"` -gt 0 ]; then
  	echo "==> Source Tree already installed."
else
	echo "==> Installing SourceTree (installs git and gui)"
	brew cask install sourcetree 
fi

# Sublime Text 2
if [ `osascript -e 'version of app "sublime text 2"' | grep -c "$SUBLIMETEXT_VER"` -gt 0 ]; then
  	echo "==> Sublime Text 2 already installed."
else
	echo "==> Installing SublimeText (text/IDE)"
	brew cask install sublime-text 
fi

# The Unarchiver
if [ `osascript -e 'version of app "the unarchiver"' | grep -c "$THEUNARCHIVER_VER"` -gt 0 ]; then
  	echo "==> The Unarchiver already installed."
else
	echo "==> Installing TheUnarchiver (compressed file utility)"
	brew cask install the-unarchiver
fi

# Cleanup installation cache (free up hard disk space)
echo "==> Cleaning up installation files..."
brew cask cleanup

# Install frameworks
echo "------------------------"
echo " Installing frameworks  "
echo "------------------------"

# Bower
if [ `bower --version | grep -c "$BOWER_VER"` -gt 0 ]; then
  	echo "==> Bower already installed."
else
	echo "==> Installing Bower"
	npm install -g bower@$BOWER_VER
fi

# Cordova
if [ `cordova --version | grep -c "$CORDOVA_VER"` -gt 0 ]; then
  	echo "==> Cordova already installed."
else
	echo "==> Installing Cordova"
	npm install -g cordova@$CORDOVA_VER
fi

# Grunt
if [ `grunt --version | grep -c "$GRUNT_VER"` -gt 0 ]; then
  	echo "==> Grunt already installed."
else
	echo "==> Installing Grunt"
	npm install -g grunt-cli@$GRUNT_VER
fi

# Gulp
if [ `gulp --version | grep -c "$GULP_VER"` -gt 0 ]; then
  	echo "==> Gulp already installed."
else
	echo "==> Installing Gulp"
	npm install -g gulp@$GULP_VER
fi

# Ionic
if [ `ionic --version | grep -c "$IONIC_VER"` -gt 0 ]; then
  	echo "==> Ionic already installed."
else
	echo "==> Installing Ionic"
	npm install -g ionic@$IONIC_VER
fi

# Yeoman
if [ `yo --version | grep -c "$YEOMAN_VER"` -gt 0 ]; then
  	echo "==> Yeoman already installed."
else
	echo "==> Installing Yeoman"
	npm install -g yo@$YEOMAN_VER
	npm install -g generator-angular
	#npm install -g generator-ionic
fi

# Install Utilities
echo "------------------------"
echo " Installing utilities  "
echo "------------------------"

# iOS simulator cli
echo "==> Installing Command Line iOS emulator"
if [ `ios-sim --version | grep -c "$IOSSIM_VER"` -gt 0 ]; then
  	echo "==> ios-sim already installed."
else
	echo "==> Installing ios-sim"
	npm install -g ios-sim@$IOSSIM_VER
fi

# iOS deploy cli
echo "==> Installing Command Line iOS deploy"
if [ `ios-deploy --version | grep -c "$IOSDEPLOY_VER"` -gt 0 ]; then
  	echo "==> ios-deploy already installed."
else
	echo "==> Installing ios-deploy"
	npm install -g ios-deploy@$IOSDEPLOY_VER
fi


# Android cli tools
echo "==> Installing Android cli tools"
brew install android-platform-tools


echo "************************"
echo " Setup Complete         "
echo "************************"

