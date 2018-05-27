############################################
#  Objetivo: Backup Moodle File            #
#  Autor: Vagner Carvalho                  #
#  Data Criacao: 23/05/2018                #
#  Ultima Alteração: 25/05/2018            #
############################################

#!/bin/bash

echo "Inciando Backup Moodle File"
time=`date +%d-%m-%Y_%H-%M-%S`

nomebackup=BackupMoodleFile-$time.tar.gz
moodlefile="/var/moodledata /var/www/moodle/"

mount -t cifs -o username=usuario,password=senha //192.168.0.4/pasta /mnt/storage/

destinofile=/mnt/storage/BackupMoodleFile

tar -cpzf $destinofile/$nomebackup $moodlefile

########## Cria Pasta #####################
d_destinofile=$destinofile/$nomebackup
if [ ! -d $d_destinofile ]
then
mkdir -m 755 -p $d_destinofile
else
echo "Diretorio ja exite"
fi
######### Excluir Backup Apos 5 Dias ######                            

find $destinofile -ctime +5 -exec rm -rf {} \;

########  Desmontando Unidade #############
cd
umount /mnt/storage
echo "Finalizado Backup Moodle File"
###########################################
