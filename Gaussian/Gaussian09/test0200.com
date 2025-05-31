#p rhf/3-21g test geom=modela pop=mk

Gaussian Test Job 200 (Part 1):
Methanol charges via electrostatic potential fit

0,1
o h me

--Link1--
#p rhf/3-21g pop=(mk,dipole) test geom=modela

Gaussian Test Job 200 (Part 2):
Methanol charges via electrostatic potential fit with dipole constraint

0,1
o h me

--Link1--
#p rhf/3-21g pop=(mk,atomdipole) test geom=modela

Gaussian Test Job 200 (Part 3):
Methanol charges via electrostatic potential fit with dipole constraint

0,1
o h me

--Link1--
#p rhf/3-21g test geom=modela pop=chelp

Gaussian Test Job 200 (Part 4):
Methanol charges via electrostatic potential fit with Chirlian-Francl grid

0,1
o h me

--Link1--
#p rhf/3-21g test geom=modela pop=chelpg

Gaussian Test Job 200 (Part 5):
Methanol charges via electrostatic potential fit with Brenneman grid

0,1
o h me

--Link1--
#p rhf/3-21g test geom=modela pop=(chelpg,readrad)

Gaussian Test Job 200 (Part 6):
Methanol charges via electrostatic potential fit with Brenneman grid

0,1
o h me

h 1.1

--Link1--
#p rhf/3-21g test geom=modela pop=(chelpg,readatrad)

Gaussian Test Job 200 (Part 7):
Methanol charges via electrostatic potential fit with Brenneman grid

0,1
o h me

2 1.1

