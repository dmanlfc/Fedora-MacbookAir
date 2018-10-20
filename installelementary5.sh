#!/bin/bash
# See Readme.md file for further information
# Tested with Elementary OS Juno
# Version 1.0.0

if [[ $EUID -ne 0 ]]; then
   	echo "This script must be run as root type: sudo ./installscript"
   	exit 1
else

# Get the Real Username
RUID=$(who | awk 'FNR == 1 {print $1}')
# Translate Real Username to Real User ID
RUSER_UID=$(id -u ${RUID})

#Update and Upgrade
echo "*****************************************"
echo "* Updating and upgrading your system... *"
echo "*****************************************"
apt update && apt upgrade

#Setup dialog for the menu
apt -y install dialog
cmd=(dialog --title "Elementary OS Juno Extra's Installer" --separate-output --checklist "Select the software you want to install:" 22 80 16)
options=(
    #A "<---Category: Software Repositories--->" on
        1_repos " Enable PPA's" on
        2_repos " Enable Flatpack & Flathub" on
        3_repos " Enable Snaps" on
	#B "<---Category: System--->" on
	    1_system " Install GDebi" off
    #C "<---Category: Social--->" on
		1_social " Slack Client" off
	    2_social " Zoom Meeting Client" off
	    3_social " Discord" off
	    4_social " Telegram CLient" off
	#D "<---Category: Tweaks--->" on
	    1_tweak " Elementary Tweak Tool" off
	#E "<---Category: Media--->" on
	    1_media " Google Desktop Player (Flatpak)" off
		2_media " VLC Player" off
		3_media " Additional Media Codecs" off
        4_media " Plex Media Server" off
        5_media " Spotify" off
    #F "<---Category: Internet--->" on
	    1_internet " Google Chrome" on
	#G "<---Category: Video, Audio & Pic Editing--->" on
	    1_edit " Kdenlive" off
	    2_edit " GIMP (Flatpak)" off
	    3_edit " OBS-Studio" off
	    4_edit " Audacity" off
	#H "<---Category: Utilities--->" on
	    1_utility " Virtualbox" off
		2_utility " TLP" off
		3_utility " qBitorrent" off
		4_utility " Neofetch" off
	#I "<---Category: Office--->" on
	    1_office "Libre Office" on
	#J "<---Category: Gaming & Fun--->" on
	    1_gaming " Steam (Flatpak)" off
	    2_gaming " Mesa - Stable (PPA)" off
	#K "<---Category: Curated Apps--->" on
	    1_curated " Eddy" off
	    2_curated " Image Burner" off
	    3_curated " Formatter" off
	    )
	    choices=$("${cmd[@]}" "${options[@]}" 2>&1 >/dev/tty)
		clear
		for choice in $choices
        do
		    case $choice in

# Section A ----------repos----------
        1_repos)
            #Enable PPA's
			echo "*******************"
			echo "* Enable PPA's... *"
			echo "*******************"
			apt -y install software-properties-common
			sleep 2.0
			;;

		2_repos)
		    #Install Flathub Repository
		    echo "******************************"
		    echo "* Install Flathub Repository *"
		    echo "******************************"
		    apt -y install software-properties-common --no-install-recommends
		    add-apt-repository -y ppa:alexlarsson/flatpak
		    apt update
		    apt -y install flatpak
		    flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
		    sleep 2.0
		    ;;
		3_repos)
		    #Enable Snaps
		    echo "****************"
		    echo "* Enable Snaps *"
		    echo "****************"
		    apt -y install snapd
		    sleep 2.0
		    ;;

# Section B ----------system----------
        1_system)
            #SMB
            echo "***********************"
            echo "* Installing GDEBI... *"
            echo "***********************"
            apt -y install gdebi
			sleep 2.0
			;;

# Section C ----------social----------

		1_social)
			#Slack Client
            echo "*************************************"
			echo "* Installing Slack Client (wget)... *"
            echo "*************************************"
			wget https://downloads.slack-edge.com/linux_releases/slack-desktop-3.3.3-amd64.deb
			dpkg -i slack-desktop-3.3.3-amd64.deb
			apt -y -f install
			rm -rf slack-desktop-3.3.3-amd64.deb
			sleep 2.0
			;;

		2_social)
			#Zoom
            echo "********************************************"
			echo "* Installing Zoom Meeting Client (wget)... *"
            echo "********************************************"
			wget https://zoom.us/client/latest/zoom_amd64.deb
			dpkg -i zoom_amd64.deb
			apt -y -f install
			rm -rf zoom_amd64.deb
			sleep 2.0
			;;

		3_social)
		    #Discord
		    echo "*************************"
		    echo "* Installing Discord... *"
		    echo "*************************"
		    apt -y install libgconf-2-4 libappindicator1
		    wget https://dl.discordapp.net/apps/linux/0.0.5/discord-0.0.5.deb
		    dpkg -i discord-0.0.5.deb
		    rm -rf discord*.deb
		    sleep 2.0
		    ;;

		4_social)
		    #Telgram
		    echo "**************************************"
		    echo "* Install Telegram Desktop (snap)... *"
		    echo "**************************************"
		    sudo snap -y install telegram-desktop
		    sleep 2.0
		    ;;

# Section D ----------tweak----------
        1_tweak)
            #Elementary OS tweak tool
            echo "*********************************************"
			echo "* Installing Elementary Tweak Tool (PPA)... *"
            echo "*********************************************"
			sudo add-apt-repository -y ppa:philip.scott/elementary-tweaks
            sudo apt update
            sudo apt -y install elementary-tweaks
            sleep 2.0
			;;

# Section E ----------media----------
		1_media)
            #Google Desktop Player
            echo "**********************************************"
			echo "* Installing Google Desktop Player (wget)... *"
            echo "**********************************************"
            wget https://github-production-release-asset-2e65be.s3.amazonaws.com/40008106/bef75f86-87ab-11e8-8a57-ed66e54d9a62?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAIWNJYAX4CSVEH53A%2F20181020%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20181020T112804Z&X-Amz-Expires=300&X-Amz-Signature=4be3cdbf9a5d62ab5dac975ef61afa765c92749a9fdf01723e7321822442cd1b&X-Amz-SignedHeaders=host&actor_id=0&response-content-disposition=attachment%3B%20filename%3Dgoogle-play-music-desktop-player_4.6.1_amd64.deb&response-content-type=application%2Foctet-stream
			dpkg -i google-play-music*.deb
			#apt -y -f install
			rm -rf google-play-music*.deb
			#flatpak -y install flathub com.googleplaymusicdesktopplayer.GPMDP
			sleep 2.0
			;;

		2_media)
			#VLC Media Player
            echo "**********************************"
		    echo "* Installing VLC Media Player... *"
            echo "**********************************"
            apt -y install vlc
			sleep 2.0
			;;

		3_media)
			#Install Media Codecs
            echo "******************************"
			echo "* Installing Media Codecs... *"
            echo "******************************"
            apt -y install ubuntu-restricted-extras
            apt -y install libavcodec-extra
            apt -y install libdvd-pkg
			sleep 2.0
			;;

        4_media)
            #Plex Media Server
            echo "***********************************"
            echo "* Installing Plex Media Server... *"
            echo "***********************************"
            #wget https://downloads.plex.tv/plex-media-server/1.13.8.5395-10d48da0d/plexmediaserver_1.13.8.5395-10d48da0d_amd64.deb
            echo deb https://downloads.plex.tv/repo/deb public main | sudo tee /etc/apt/sources.list.d/plexmediaserver.list
            curl https://downloads.plex.tv/plex-keys/PlexSign.key | sudo apt-key add -
            apt update
            apt -y install plexmediaserver
            #To allow access to the USB without modifying the fstab file do the following...
            #echo "Configuring Plex Server to run under this user profile..."
            #Set the config file location
            #CONFIG="/lib/systemd/system/plexmediaserver.service"
            #Use sed to set the new config values...
            #function set_config(){
            #    sed -i.bak "s/^\($1\s*=\s*\).*\$/\1$2/" $CONFIG
            #}
            #source $CONFIG
            #User=$RUID
            #set_config User $User
            #Group=$RUID
            #set_config Group $Group
            #Change the ownership of Plex to the current user...
            #chown -R $RUID:$RUID /var/lib/plexmediaserver
            echo "Starting Plex Server Service..."
            systemctl enable plexmediaserver.service
            systemctl start plexmediaserver
            echo "-------------------------------------------------------------------------"
            echo "- Go to: http://127.0.0.1:32400/web in your Web Browser to configure... -"
            echo "-------------------------------------------------------------------------"
            echo
            sleep 2.0
            ;;

        5_media)
            #Spotify
            echo "*************************"
            echo "* Installing Spotify... *"
            echo "*************************"
            # 1. Add the Spotify repository signing keys to be able to verify downloaded packages
            apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 931FF8E79F0876134EDDBDCCA87FF9DF48BF1C90
            # 2. Add the Spotify repository
            echo deb http://repository.spotify.com stable non-free | sudo tee /etc/apt/sources.list.d/spotify.list
            # 3. Update list of available packages
            apt update
            # 4. Install Spotify
            apt -y install spotify-client
            ;;

# Section F ----------internet----------
        1_internet)
			#Google Chrome Stable
            echo "************************"
			echo "* Installing Chrome... *"
            echo "************************"
            wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
            echo 'deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main' | sudo tee /etc/apt/sources.list.d/google-chrome.list
            apt update
            apt -y install google-chrome-stable
            echo "Removing Epiphany..."
			apt -y remove epiphany-browser
            sleep 2.0
			;;

# Section G ----------edit(Video/Audio/Pic)----------
		1_edit)
			#Kdenlive
            echo "************************************"
			echo "* Installing Kdenlive (Flatpak)... *"
            echo "************************************"
            #apt -y install kdenlive #Older version
            flatpak -y install https://flathub.org/repo/appstream/org.kde.kdenlive.flatpakref
            sleep 2.0
			;;

		2_edit)
			#GIMP
            echo "********************************"
			echo "* Installing GIMP (Flatpak)... *"
            echo "********************************"
            flatpak -y install https://flathub.org/repo/appstream/org.gimp.GIMP.flatpakref
			#apt -y install gimp #Older version
			sleep 2.0
			;;

		3_edit)
			#OBS Studio
            echo "****************************"
			echo "* Installing OBS Studio... *"
            echo "****************************"
			#apt -y install obs-studio #Older version
			#We need ffmpeg
			apt -y install ffmpeg
            #After installing FFmpeg, install OBS Studio using:
            add-apt-repository ppa:obsproject/obs-studio
            apt update
            apt -y install obs-studio
            sleep 2.0
			;;

		4_edit)
			#Audacity
            echo "********************************"
			echo "* Installing Audacity (PPA)... *"
            echo "********************************"
            add-apt-repository -y ppa:ubuntuhandbook1/audacity #Provides a more up-to-date version
            apt update
			apt -y install audacity
            sleep 2.0
			;;

# Section H ----------utilities----------
        1_utility)
            #Virtualbox
            echo "****************************"
			echo "* Installing Virtualbox... *"
            echo "****************************"
            wget -q https://www.virtualbox.org/download/oracle_vbox_2016.asc -O- | sudo apt-key add -
            wget -q https://www.virtualbox.org/download/oracle_vbox.asc -O- | sudo apt-key add -
			add-apt-repository "deb [arch=amd64] http://download.virtualbox.org/virtualbox/debian $(lsb_release -cs) contrib"
			apt update
			apt -y install virtualbox-5.2
			sleep 2.0
			;;

		2_utility)
			#TLP
            echo "**************************************"
			echo "* Installing TLP power management... *"
            echo "**************************************"
			apt -y install tlp tlp-rdw
			tlp start
			systemctl enable tlp
            sleep 2.0
			;;

		3_utility)
			#qBitorrent
            echo "**********************************"
			echo "* Installing qBitorrent (PPA)... *"
            echo "**********************************"
            # qBittorrent Stable
            add-apt-repository -y ppa:qbittorrent-team/qbittorrent-stable
			apt update
			apt -y install qbittorrent
            sleep 2.0
			;;

		4_utility)
			#Neofetch
            echo "**************************"
			echo "* Installing Neofetch... *"
            echo "**************************"
			apt -y install neofetch
			neofetch
			echo
            sleep 2.0
			;;

# Section I ----------office----------
        1_office)
            #Libre Office
            echo "************************************"
            echo "* Installing Libre Office (PPA)... *"
            echo "************************************"
            add-apt-repository -y ppa:libreoffice/ppa
            apt update
            apt -y install libreoffice
            sleep 2.0
            ;;

# Section J ----------game----------
        1_gaming)
			#Steam
            echo "******************************"
			echo "* Installing Steam (wget)... *"
            echo "******************************"
            #flatpak -y install flathub com.valvesoftware.Steam
            wget https://steamcdn-a.akamaihd.net/client/installer/steam.deb
            dpkg -i steam.deb
			apt -y -f install
			rm -rf steam.deb
            sleep 2.0
			;;

		2_gaming)
			#Mesa Stable (Updated drivers for Steam Play)
            echo "**********************************"
			echo "* Install Mesa - Stable (PPA)... *"
            echo "**********************************"
            add-apt-repository -y ppa:paulo-miguel-dias/pkppa
            apt update
            apt -y upgrade
            sleep 2.0
            ;;

# Section K ----------curated----------
        1_curated)
            #Eddy
            echo "*******************"
            echo "* Install Eddy... *"
            echo "*******************"
            apt -y install com.github.donadigo.eddy
            sleep 2.0
            ;;

        2_curated)
            #Image Burner
            echo "***************************"
            echo "* Install Image Burner... *"
            echo "***************************"
            apt -y install com.github.artemanufrij.imageburner
            sleep 2.0
            ;;

        3_curated)
            #Formatter
            echo "************************"
            echo "* Install Formatter... *"
            echo "************************"
            apt -y install com.github.djaler.formatter
	        sleep 2.0
	        esac
        done
fi
echo "****************************"
echo "* Removing old packages... *"
echo "****************************"
apt -y autoremove
echo "********************************"
echo "* DONE! Ideally reboot your PC *"
echo "********************************"
echo
