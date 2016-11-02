# R package germanpolls

`germanpolls` is an R package for scraping [Wahlrecht.de](http://www.wahlrecht.de), a German website with the most comprehensive collection of polling results. 

## Usage

`library(devtools)`

`install_github("cutterkom/germanpolls")`

`library(germanpolls)`

`polling_data <- germanpolls()`

## What you get

You get a dataframe with the following variables on the *federal level*: 

- institute
- date
- sample size
- period
- results for parties: `cdu.csu,spd,grüne,fdp,linke,afd,sonstige,nw_un,piraten,fw`
- type (phone, online, unknown)

Glimpse:

| institut                             | datum      | befragte | zeitraum      | cdu.csu | spd  | grüne | fdp | linke | afd  | sonstige | nw_un | piraten | fw | typ         | 
|--------------------------------------|------------|----------|---------------|---------|------|-------|-----|-------|------|----------|-------|---------|----|-------------| 
| Allensbach (Institut für Demoskopie) | 2016-10-21 | NA       | 01.10.–13.10. | 33      | 22   | 12    | 7.5 | 9     | 12.5 | 4        | NA    | NA      | NA | keineangabe | 
| Allensbach (Institut für Demoskopie) | 2016-09-22 | 1407     | 03.09.–15.09. | 33.5    | 24   | 11    | 7   | 7     | 12.5 | 5        | NA    | NA      | NA | keineangabe | 
| Allensbach (Institut für Demoskopie) | 2016-08-24 | 1496     | 03.08.–17.08. | 34.5    | 23   | 11.5  | 7.5 | 9     | 10   | 4.5      | NA    | NA      | NA | keineangabe | 
| Allensbach (Institut für Demoskopie) | 2016-07-21 | 1466     | 01.07.–14.07. | 35.5    | 22.5 | 12    | 7   | 9.5   | 9.5  | 4        | NA    | NA      | NA | keineangabe | 

...

## Better Polls

Germanpolls is a byproduct of [gen-better-polls](https://github.com/sueddeutsche/gen-better-polls). At the GEN Hackathon at [Süddeutsche Zeitung](http://www.sz.de) we were working on a better way to visualize polling data. 

