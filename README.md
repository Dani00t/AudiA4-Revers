Reverse box configuration.
Si vogliono fare 5 MESH diverse per studiare la convergenza dei residui, del cd e l'indipendenza del cd dal numero di celle.
Si modifica solo il blockMeshDict, diminuendo la grandezza del livello 0 della cella iniziale.
snappyHexMesh rimane invariato. 

MESH1:
blockMeshDict (45 8 9) --> Lv0 = 1m;
log.snappyHexMeshDict  OK
log.checkMesh          OK

MESH4:
blockMeshDict (90 16 18) --> Lv0 = 0.5m;
log.snappyHexMeshDict  
log.checkMesh          

