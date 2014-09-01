# 
#

FROM     centos:centos6

RUN yum update -y

RUN yum -y install openssh openssh-server openssh-clients
RUN service sshd start; service sshd stop
RUN sed -i '/pam_loginuid\.so/s/required/optional/' /etc/pam.d/sshd

RUN yum -y install xorg-x11-server-Xvfb xorg-x11-fonts-Type1 xorg-x11-fonts-misc dejavu-lgc-sans-fonts xorg-x11-fonts-75dpi xorg-x11-fonts-100dpi
RUN yum -y install xorg-x11-fonts-ISO8859-1-75dpi.noarch xorg-x11-fonts-ISO8859-1-100dpi.noarch
RUN yum -y install xterm xorg-x11-utils
RUN yum -y install gnome-panel gnome-terminal gnome-applets nautilus
RUN yum -y install firefox libreoffice thunderbird
RUN yum -y install tigervnc-server xinetd xorg-x11-xdm
RUN yum -y install vlgothic-fonts vlgothic-p-fonts ipa-gothic-fonts ipa-mincho-fonts ipa-pgothic-fonts ipa-pmincho-fonts
RUN yum -y install system-config-users
#RUN yum -y install ibus-anthy

RUN echo "vnc1 5901/tcp" >> /etc/services
ADD vnc /etc/xinetd.d/vnc
RUN sed -i 's$:0 local /usr/bin/X :0$:0 local /usr/bin/Xvnc :0 -SecurityTypes None$' /etc/X11/xdm/Xservers  
RUN sed -i "s/DisplayManager.requestPort:\t0/DisplayManager.requestPort:   177/" /etc/X11/xdm/xdm-config
RUN echo '*' >> /etc/X11/xdm/Xaccess


ADD startup.sh /src/startup.sh

EXPOSE 22
CMD ["/src/startup.sh"]
