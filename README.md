Kerasaurs
=========

Using [keras](https://keras.rstudio.com/index.html) deep learning
package in R to generate new prehistoric animal names from a list of
existing genera.

Heavily adapted from functions written by [Jonathan
Nolis](https://github.com/jnolis/banned-license-plates) and [JJ
Allaire](https://github.com/rstudio/keras/blob/master/vignettes/examples/lstm_text_generation.R)

Ouput
-----

Proposed genus names from 50 iterations of modeling. From 500 samples,
312 unique names were generated, 120 were not previously named
dinosaurs, pterosaurs, mosasaurs, ichthyosaurs, or plesiosaurs.

<table>
<thead>
<tr class="header">
<th align="left">kerasaur</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td align="left">Acrosaurus</td>
</tr>
<tr class="even">
<td align="left">Agadirichuanus</td>
</tr>
<tr class="odd">
<td align="left">Agudisaurus</td>
</tr>
<tr class="even">
<td align="left">Ahselosaurus</td>
</tr>
<tr class="odd">
<td align="left">Aigayosaurus</td>
</tr>
<tr class="even">
<td align="left">Aleonosaurus</td>
</tr>
<tr class="odd">
<td align="left">Aleosaurus</td>
</tr>
<tr class="even">
<td align="left">Alioraptor</td>
</tr>
<tr class="odd">
<td align="left">Almotyneus</td>
</tr>
<tr class="even">
<td align="left">Ampesaurus</td>
</tr>
<tr class="odd">
<td align="left">Amphicoeliason</td>
</tr>
<tr class="even">
<td align="left">Amphicoeliasuchus</td>
</tr>
<tr class="odd">
<td align="left">Amposaurus</td>
</tr>
<tr class="even">
<td align="left">Ampylodon</td>
</tr>
<tr class="odd">
<td align="left">Andarognathus</td>
</tr>
<tr class="even">
<td align="left">Angustinaasaurus</td>
</tr>
<tr class="odd">
<td align="left">Angustinadactylus</td>
</tr>
<tr class="even">
<td align="left">Angustinalopelta</td>
</tr>
<tr class="odd">
<td align="left">Angustinaraptor</td>
</tr>
<tr class="even">
<td align="left">Angustinaurusaurus</td>
</tr>
<tr class="odd">
<td align="left">Angustrodon</td>
</tr>
<tr class="even">
<td align="left">Angutsurrasaurus</td>
</tr>
<tr class="odd">
<td align="left">Ankelopus</td>
</tr>
<tr class="even">
<td align="left">Anthrovenator</td>
</tr>
<tr class="odd">
<td align="left">Appalachia</td>
</tr>
<tr class="even">
<td align="left">Aprosaurus</td>
</tr>
<tr class="odd">
<td align="left">Brasileodon</td>
</tr>
<tr class="even">
<td align="left">Brovisaurus</td>
</tr>
<tr class="odd">
<td align="left">Caenyonychus</td>
</tr>
<tr class="even">
<td align="left">Chalarasaurus</td>
</tr>
<tr class="odd">
<td align="left">Changyhasaurus</td>
</tr>
<tr class="even">
<td align="left">Changyhuanosaurus</td>
</tr>
<tr class="odd">
<td align="left">Chinlongiansaurus</td>
</tr>
<tr class="even">
<td align="left">Chissaurus</td>
</tr>
<tr class="odd">
<td align="left">Chuanxingosaurus</td>
</tr>
<tr class="even">
<td align="left">Cryosaurus</td>
</tr>
<tr class="odd">
<td align="left">Cryptodracon</td>
</tr>
<tr class="even">
<td align="left">Danjangaxipon</td>
</tr>
<tr class="odd">
<td align="left">Datongloni</td>
</tr>
<tr class="even">
<td align="left">Deinorhyrosaurus</td>
</tr>
<tr class="odd">
<td align="left">Dongyuansaurus</td>
</tr>
<tr class="even">
<td align="left">Doreinosaurus</td>
</tr>
<tr class="odd">
<td align="left">Edetresaurus</td>
</tr>
<tr class="even">
<td align="left">Egliusaurus</td>
</tr>
<tr class="odd">
<td align="left">Elambosaurus</td>
</tr>
<tr class="even">
<td align="left">Elpiniachar</td>
</tr>
<tr class="odd">
<td align="left">Eochrosaurus</td>
</tr>
<tr class="even">
<td align="left">Eohramnosaurus</td>
</tr>
<tr class="odd">
<td align="left">Eoplophosaurus</td>
</tr>
<tr class="even">
<td align="left">Eoplophososaurus</td>
</tr>
<tr class="odd">
<td align="left">Eoplophososuchus</td>
</tr>
<tr class="even">
<td align="left">Eosikmosaurus</td>
</tr>
<tr class="odd">
<td align="left">Eotrachodontoveiatr</td>
</tr>
<tr class="even">
<td align="left">Eotrachodontoveiaur</td>
</tr>
<tr class="odd">
<td align="left">Erectophus</td>
</tr>
<tr class="even">
<td align="left">Eretmodoniscus</td>
</tr>
<tr class="odd">
<td align="left">Frenguelasaurus</td>
</tr>
<tr class="even">
<td align="left">Gigantospenator</td>
</tr>
<tr class="odd">
<td align="left">Hualengia</td>
</tr>
<tr class="even">
<td align="left">Huanghestes</td>
</tr>
<tr class="odd">
<td align="left">Huanghetiumes</td>
</tr>
<tr class="even">
<td align="left">Indasaurus</td>
</tr>
<tr class="odd">
<td align="left">Ischiroceratops</td>
</tr>
<tr class="even">
<td align="left">Lamelasaurus</td>
</tr>
<tr class="odd">
<td align="left">Leopellosaurus</td>
</tr>
<tr class="even">
<td align="left">Leptocreosaurus</td>
</tr>
<tr class="odd">
<td align="left">Leptoctes</td>
</tr>
<tr class="even">
<td align="left">Leptonodracom</td>
</tr>
<tr class="odd">
<td align="left">Leptorhynchus</td>
</tr>
<tr class="even">
<td align="left">Liraonosaurus</td>
</tr>
<tr class="odd">
<td align="left">Lonagnia</td>
</tr>
<tr class="even">
<td align="left">Machigosaurus</td>
</tr>
<tr class="odd">
<td align="left">Macrotrachelophus</td>
</tr>
<tr class="even">
<td align="left">Macrotrachelos</td>
</tr>
<tr class="odd">
<td align="left">Macrotrauros</td>
</tr>
<tr class="even">
<td align="left">Matrydosaurus</td>
</tr>
<tr class="odd">
<td align="left">Mawpawia</td>
</tr>
<tr class="even">
<td align="left">Metroteracops</td>
</tr>
<tr class="odd">
<td align="left">Microtaraus</td>
</tr>
<tr class="even">
<td align="left">Minotauraptor</td>
</tr>
<tr class="odd">
<td align="left">Modocephalosaurus</td>
</tr>
<tr class="even">
<td align="left">Mollesosaurus</td>
</tr>
<tr class="odd">
<td align="left">Mortosaurus</td>
</tr>
<tr class="even">
<td align="left">Neomosaurus</td>
</tr>
<tr class="odd">
<td align="left">Neosauroides</td>
</tr>
<tr class="even">
<td align="left">Olodontophus</td>
</tr>
<tr class="odd">
<td align="left">Ornithocheirosaurus</td>
</tr>
<tr class="even">
<td align="left">Orognathus</td>
</tr>
<tr class="odd">
<td align="left">Orthomia</td>
</tr>
<tr class="even">
<td align="left">Palaeorus</td>
</tr>
<tr class="odd">
<td align="left">Paralotitan</td>
</tr>
<tr class="even">
<td align="left">Pararhaboceratops</td>
</tr>
<tr class="odd">
<td align="left">Piatnirzkyhalosauru</td>
</tr>
<tr class="even">
<td align="left">Piteyullosaurus</td>
</tr>
<tr class="odd">
<td align="left">Procerophohyous</td>
</tr>
<tr class="even">
<td align="left">Prochenectesuc</td>
</tr>
<tr class="odd">
<td align="left">Protachianosaurus</td>
</tr>
<tr class="even">
<td align="left">Protobosaurus</td>
</tr>
<tr class="odd">
<td align="left">Ramaleosaurus</td>
</tr>
<tr class="even">
<td align="left">Saeriavisaurus</td>
</tr>
<tr class="odd">
<td align="left">Sanjianggia</td>
</tr>
<tr class="even">
<td align="left">Santanius</td>
</tr>
<tr class="odd">
<td align="left">Sanusaurus</td>
</tr>
<tr class="even">
<td align="left">Secelnosaurus</td>
</tr>
<tr class="odd">
<td align="left">Segiraceratops</td>
</tr>
<tr class="even">
<td align="left">Selessachus</td>
</tr>
<tr class="odd">
<td align="left">Siamodontoleusis</td>
</tr>
<tr class="even">
<td align="left">Silisaurus</td>
</tr>
<tr class="odd">
<td align="left">Spiaodontosaurus</td>
</tr>
<tr class="even">
<td align="left">Struthiomimosaurus</td>
</tr>
<tr class="odd">
<td align="left">Tanyctorhynomus</td>
</tr>
<tr class="even">
<td align="left">Tarasaurus</td>
</tr>
<tr class="odd">
<td align="left">Teintaisaurus</td>
</tr>
<tr class="even">
<td align="left">Teratophosaurus</td>
</tr>
<tr class="odd">
<td align="left">Thalassodracom</td>
</tr>
<tr class="even">
<td align="left">Trimalasaurus</td>
</tr>
<tr class="odd">
<td align="left">Ugrunaalassaurus</td>
</tr>
<tr class="even">
<td align="left">Yixianonsaurus</td>
</tr>
<tr class="odd">
<td align="left">Yixianosuchus</td>
</tr>
<tr class="even">
<td align="left">Zhuchengopterus</td>
</tr>
</tbody>
</table>

Input data
----------

-   Lists of
    [dinosaur](https://en.wikipedia.org/wiki/List_of_dinosaur_genera)
    genera,
    [pterosaur](https://en.wikipedia.org/wiki/List_of_pterosaur_genera)
    genera,
    [mosasaur](https://en.wikipedia.org/wiki/List_of_mosasaur_genera)
    genera,
    [ichthyosaur](https://en.wikipedia.org/wiki/List_of_ichthyosaur_genera)
    genera, and
    [plesiosaur](https://en.wikipedia.org/wiki/List_of_plesiosaur_genera)
    genera from Wikipedia.

-   Images from [PhyloPic.org](http://phylopic.org/image/browse/)
