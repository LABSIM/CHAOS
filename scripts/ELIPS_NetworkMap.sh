#!/bin/bash
#
# ELIPS Network Map
#
# On place ici l'ensemble des machines présentes sur le réseau LIPS
# On prendra soin de verifier que la correspondance des noms sera bien faites
# dans le fichier /etc/hosts
#
# (Valentines's Day)
# 14/02/2012 - Kinani Nawfel
#
#################################################

###
# On declare notre Network
declare -a ELIPSNTWK

###
# Ensuite on ajoute chacun des membres du réseau
# > L'ordre de déclarations des machines n'influe en rien sur le comportement du script
#

### Salle "bulle"
ELIPSNTWK[0]="kilan"
ELIPSNTWK[1]="klaus"
ELIPSNTWK[2]="gaston"
ELIPSNTWK[3]="gedeon"
ELIPSNTWK[4]="gustave"

### Salle LIPS
ELIPSNTWK[5]="kad"
ELIPSNTWK[6]="ignace"
ELIPSNTWK[7]="kimmy"
ELIPSNTWK[8]="isidore"
ELIPSNTWK[9]="kelvin"
ELIPSNTWK[10]="jules"
ELIPSNTWK[11]="jean"

