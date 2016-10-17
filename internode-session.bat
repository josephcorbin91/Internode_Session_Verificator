goto comment
The DUAS v5 and v6 nodes must be declared on the same UVMS and the Exchanger compatibility 
option must be enabled in the node settings of the DUAS v6 node > advanced settings > Activate 
Exchanger compatibility with Dollar Universe v5.
Verify both machines are able to communicate with one another by running the command:
PING <hostname>
The v5 machine should be able to ping the v6 machine and vice-versa.


3.5.1.2 Configuration for v5 and v6 compatibility

On the command line, create a user (submission account) on the DUAS v6 node with the same author 
code as the user on the DUAS v5 node (refer to the Dollar Universe v6.0 Commands manual). If a 
user with the same name already exists on the DUAS v6 node but was created with UVC, the user 
must be recreated using the command line.
Create a network session on the DUAS v5 node and deploy it onto DUAS v6. For more information on 
deployment, refer to the Dollar Universe v6.0 Interface Manual for UniViewer v4.
Afin que votre session inter-noued functionner veuillez vous assurer que l'Uproc conditionnante, même si elle tourne sur une UG / un Noeud distant, soit également présente sur le Noeud de l'Uproc conditionnée. 

Afin de créer des dépendences entre des uprocs qui s'exécutent sur 2 noeuds distincts, les conditions suivantes doivent être satisfaites:

Au niveau du noeud hébergeant l'uproc conditionnée:
1. Le noeud distant doit être délclaré dans la table des noeuds (+ fichier UXMGR/uxsrsrv.sck si nécessaire)
2. L'UG d'exécution de l'uproc conditionnante (sur le noeud distant) doit être définie sur ce noeud
3. L'uproc condionnante doit être crée/distribuée vers ce noeud
4. Si l'uproc fait partie d'une session, toute la session doit exister sur ce noeud aussi, car une uproc est identifiée grâce à un numéro de de lancement de l'uproc et de la session
5. L'échangeur de l'espace d'exécution doit être actif

Au niveau du noeud hébergeant l'uproc condionnante:
1. Le noeud hébergeant l'uproc condionnée doit être délclaré dans la table des noeuds (+ fichier UXMGR/uxsrsrv.sck si nécessaire)
2. L'échangeur de l'espace d'exécution doit être actif

Si toutes ces conditions sont réunies, l'évenement correspondant à l'uproc condionnante apparait dans le fichier des évenement des 2 noeuds d'une manière synchrone.
:comment
@echo off
setlocal enabledelayedexpansion

call:checkEngineStatus
set session=%1

CD C:\Program Files\AUTOMIC\DUAS\INTER6_INTERNODE_SESSION\bin
uxshw SES SES=%session% output="C:\Development\Internode-Session\session.txt"
CD C:\Development\Internode-Session\




set MYVAR=session.txt

for /f "tokens=2,4" %%a in (%MYVAR%) do (
	
	if "%%a" == "upr" call:verifyUproc %%b
	)

:verifyUproc
CD C:\Program Files\AUTOMIC\DUAS\INTER6_INTERNODE_SESSION\bin
uxshw UPR UPR=%~1 output="C:\Development\Internode-Session\upr.txt"
echo %~1

:checkEngineStatus
CD C:\Program Files\AUTOMIC\DUAS\INTER6_INTERNODE_SESSION\bin
uxlst ATM EXP OUTPUT=c:\Development\Internode-Session\exchanger.txt"



