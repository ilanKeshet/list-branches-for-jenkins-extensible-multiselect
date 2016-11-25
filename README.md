
installation in jenkins crontab  
-bash-4.1$ crontab -e
* * * * * /bin/bash /var/lib/jenkins/git-branch-list-populator/list-remote-branches.sh


by default 
    result is written to the file /var/lib/jenkins/git-branch-list-populator/branches.txt
    property name is MDLP


design to work with Jenkins Extensible Choice Parameter plugin
https://wiki.jenkins-ci.org/display/JENKINS/Extensible+Choice+Parameter+plugin

