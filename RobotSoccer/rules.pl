//500644178 Eric Jaskierski
//500681845 Rudi Zhou
//500748954 Maxim Tolkatchev

canScore(R) :- hasBall(R), pathClear(R,goal).
canScore(R) :- hasBall(R2), canAssist(R2,R), pathClear(R,goal).
canAssist(R1,R2) :- pathClear(R1,R2).
canAssist(R1,R2) :- pathClear(R1,R3), canAssist(R3,R2).

hasBall(r3).
pathClear(r1,goal).
pathClear(r2,r1).
pathClear(r3,r2).
pathClear(r3,goal).
pathClear(r3,r1).