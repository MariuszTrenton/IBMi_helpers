# IBMi_helpers
This function has been delivered before IBM prvided qsys2.IFS_OBJECT_STATISTICS, however qsys2.IFS_OBJECT_STATISTICS doesnt read disks/directories mounted via NFS protocol. 



# Installing OSSILE on your IBM i
#### Method 1: download the .zip file and compile
1. Download https://github.com/OSSILE/OSSILE/archive/master.zip and place it in IFS
2. From a PASE-capable shell (ssh client, QP2term, etc), run:
  * ``jar xvf OSSILE-master.zip``
  * ``cd OSSILE-master/main && chmod +x ./setup && ./setup``

    To exclude an item from building, remove it from buildlist.txt or comment it out with a preceding '#'

#### Method 2: Download *SAVF
1. Create a save file object on IBM i.
2. Download https://github.com/OSSILE/OSSILE/blob/master/ossile.savfsrc and upload it to the IBM i, replacing the contents of the save file you've created
2. Use the RSTLIB command to restore the OSSILE library from the save file. For example:
  * ``RSTLIB SAVLIB(OSSILE) DEV(*SAVF) SAVF(MYLIB/MYSAVF)``

#### Method 3: Installing via Relic Package Manager
Each directory in `/main/` is a seperate item, each are installable seperatly with Relic. The base command is `RELICGET PLOC('https://github.com/OSSILE/OSSILE/archive/master.zip') PDIR('OSSILE-master/main/<ITEM>') PNAME(OSSILE)`, where `<ITEM>` is one of those directories. For example:

* `PDIR('OSSILE-master/main/crtfrmstmf')`
* `PDIR('OSSILE-master/main/udtf_image_catalog_details')`

# OSSILE directory structure
These are the main directories within OSSILE:
## ``main/``
 This directory houses complete, buildable code. In other words, it contains all the tools and utilities we list above as "included in OSSILE".
 Each subdirectory represents a separate buildable item.
## ``code_examples/``
