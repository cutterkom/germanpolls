# germanpolls - an R package for German polling data

`germanpolls` is an R package for scraping [Wahlrecht.de](http://www.wahlrecht.de), a German website with the most comprehensive collection of polling results.

## Install 

`devtools::install_github("cutterkom/germanpolls")`

## Usage 

`library(germanpolls)`

`polling_data <- germanpolls(region = "de")`

## Result

You get all elements from `XML` files in a dataframe.

## Available data

Call data for regions with `germanpolls(region = "de")` for Germany or `region = "by"` for Bavaria.

You **can** get polling data for:

- de,Deutschland
- by,Bayern
- he,Hessen
- hb,Bremen
- ni,Niedersachsen
- sn,Sachsen
- th,Thüringen

You **can't** get polling data for:

- eu, European Union
- be,Berlin
- bb,Brandenburg
- bw,Baden-Württemberg
- hh,Hamburg
- mv,Mecklenburg-Vorpommern
- nw,Nordrhein-Westfalen
- rp,Rheinland-Pfalz
- sh,Schleswig-Holstein
- sl,Saarland
- st,Sachsen-Anhalt

## What you get

** Caution! old version**

You get a dataframe with the following variables on the *federal level*: 

- institute
- date
- sample size
- period
- results for parties: `cdu.csu,spd,grüne,fdp,linke,afd,sonstige,nw_un,piraten,fw`
- type (phone, online, unknown)

...

## Better Polls

Germanpolls is a byproduct of [gen-better-polls](https://github.com/sueddeutsche/gen-better-polls). At the GEN Hackathon at [Süddeutsche Zeitung](http://www.sz.de) we were working on a better way to visualize polling data.

## To Do

* Rename variables (parties etc)
* Document all Variables
* `germanpolls_latest()`: get only the last poll
* Submit to CRAN