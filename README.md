# Kerasaurs

Using [keras](https://keras.rstudio.com/index.html) deep learning package in R to generate new prehistoric animal names from a list of existing genera.

Heavily adapted from functions written by [Jonathan Nolis](https://github.com/jnolis/banned-license-plates) and [JJ Allaire](https://github.com/rstudio/keras/blob/master/vignettes/examples/lstm_text_generation.R)


## Ouput

Proposed genus names from 40 iterations of modeling. From 250 samples, 180 unique names were generated, 71 were not previously named dinosaurs, mosasaurs, ichthyosaurs, or plesiosaurs.


|kerasaur          |
|:-----------------|
|Aarelosaurus      |
|Alatotitan        |
|Amphicoeliasaura  |
|Andorasaurus      |
|Andylolosaurus    |
|Angalcaraus       |
|Angalxasaurus     |
|Anglonosaurus     |
|Angulodraco       |
|Ankallesie        |
|Antetonitrum      |
|Arahsteyia        |
|Arantarptosaurus  |
|Aratosaurus       |
|Atriunascaidio    |
|Barigosaurus      |
|Barilius          |
|Brachycoelus      |
|Brasilea          |
|Changanosaurus    |
|Chingkinglun      |
|Cryolophouw       |
|Denversaura       |
|Edolophus         |
|Elamptosaurus     |
|Elatitan          |
|Eocursodon        |
|Eohadrosaurus     |
|Epapptsosteus     |
|Galcovosaurus     |
|Gilakosaurus      |
|Huaxialodon       |
|Iguannasaurus     |
|Jahuiasaurus      |
|Kentrurus         |
|Leinkania         |
|Leoneraeosaurus   |
|Luanchalodon      |
|Macroplatasaurus  |
|Mimanosaurus      |
|Mindosaurus       |
|Miratasaurus      |
|Morontosaurus     |
|Odoceratops       |
|Ornithomeius      |
|Ornithotersus     |
|Pachycosta        |
|Pakiscus          |
|Panasaurus        |
|Parahasaurus      |
|Parandhteratotan  |
|Pararasaurus      |
|Pararusaura       |
|Parasauroides     |
|Parasaurolophohus |
|Parasiosaurus     |
|Phatyceratops     |
|Polycocalus       |
|Prochenasauroides |
|Protigantosaurus  |
|Protosaurolophus  |
|Prototithosaurus  |
|Raichaedon        |
|Sarcoenia         |
|Sedidonycus       |
|Tariniasaurus     |
|Teinurosaura      |
|Tengnisaurus      |
|Trindosaurus      |
|Xiannansaurus     |
|Xuanhualong       |


## Input data

* Lists of [dinosaur](https://en.wikipedia.org/wiki/List_of_dinosaur_genera) genera, [mosasaur genera](https://en.wikipedia.org/wiki/List_of_mosasaur_genera), [ichthyosaur](https://en.wikipedia.org/wiki/List_of_ichthyosaur_genera) genera, and [plesiosaur](https://en.wikipedia.org/wiki/List_of_plesiosaur_genera) genera from Wikipedia.

