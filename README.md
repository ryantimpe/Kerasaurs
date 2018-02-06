# Kerasaurs

Using [keras](https://keras.rstudio.com/index.html) deep learning package in R to generate new prehistoric animal names from a list of existing genera.

Heavily adapted from functions written by [Jonathan Nolis](https://github.com/jnolis/banned-license-plates) and [JJ Allaire](https://github.com/rstudio/keras/blob/master/vignettes/examples/lstm_text_generation.R)


## Ouput

Proposed genus names from 40 iterations of modeling. From 250 samples, 180 unique names were generated, 71 were not previously named dinosaurs, mosasaurs, ichthyosaurs, or plesiosaurs.


|kerasaur          |
|:-----------------|
|aarelosaurus      |
|alatotitan        |
|amphicoeliasaura  |
|andorasaurus      |
|andylolosaurus    |
|angalcaraus       |
|angalxasaurus     |
|anglonosaurus     |
|angulodraco       |
|ankallesie        |
|antetonitrum      |
|arahsteyia        |
|arantarptosaurus  |
|aratosaurus       |
|atriunascaidio    |
|barigosaurus      |
|barilius          |
|brachycoelus      |
|brasilea          |
|changanosaurus    |
|chingkinglun      |
|cryolophouw       |
|denversaura       |
|edolophus         |
|elamptosaurus     |
|elatitan          |
|eocursodon        |
|eohadrosaurus     |
|epapptsosteus     |
|galcovosaurus     |
|gilakosaurus      |
|huaxialodon       |
|iguannasaurus     |
|jahuiasaurus      |
|kentrurus         |
|leinkania         |
|leoneraeosaurus   |
|luanchalodon      |
|macroplatasaurus  |
|mimanosaurus      |
|mindosaurus       |
|miratasaurus      |
|morontosaurus     |
|odoceratops       |
|ornithomeius      |
|ornithotersus     |
|pachycosta        |
|pakiscus          |
|panasaurus        |
|parahasaurus      |
|parandhteratotan  |
|pararasaurus      |
|pararusaura       |
|parasauroides     |
|parasaurolophohus |
|parasiosaurus     |
|phatyceratops     |
|polycocalus       |
|prochenasauroides |
|protigantosaurus  |
|protosaurolophus  |
|prototithosaurus  |
|raichaedon        |
|sarcoenia         |
|sedidonycus       |
|tariniasaurus     |
|teinurosaura      |
|tengnisaurus      |
|trindosaurus      |
|xiannansaurus     |
|xuanhualong       |


## Input data

* Lists of [dinosaur](https://en.wikipedia.org/wiki/List_of_dinosaur_genera) genera, [mosasaur genera](https://en.wikipedia.org/wiki/List_of_mosasaur_genera), [ichthyosaur](https://en.wikipedia.org/wiki/List_of_ichthyosaur_genera) genera, and [plesiosaur](https://en.wikipedia.org/wiki/List_of_plesiosaur_genera) genera from Wikipedia.

