// Calculate Game Favorite Returns 

use "C:\Users\jhigh\OneDrive\Desktop\Princeton\Thesis\Characteristic\Updated Lines\myNBAUpdatedLinesNoVig.dta", clear
ssc install estout
ssc install outreg2

drop if awayscore == .


generate spreadopenwin = 1 if (homescore - awayscore) > (-1 * homespreadopen) & (homespreadopen < 0)
replace spreadopenwin = 1 if (awayscore - homescore) > (-1 * awayspreadopen) & (awayspreadopen < 0)
replace spreadopenwin = 0 if spreadopenwin != 1
generate spreadopenpush = (homescore - awayscore) == (-1 * homespreadopen)

// generate spreadclosewin = 1 if (homescore - awayscore) > (-1 * homespreadclose) & (homespreadclose < 0)
// replace spreadclosewin = 1 if (awayscore - homescore) > (-1 * awayspreadclose) & (awayspreadclose < 0)
// replace spreadclosewin = 0 if spreadclosewin != 1
// generate spreadclosepush = (homescore - awayscore) == (-1 * homespreadclose)

generate overopenwin = (homescore + awayscore) > (overopen)
generate overopenpush = (homescore + awayscore) == overopen

generate overclosewin = (homescore + awayscore) > (overclose)
generate overclosepush = (homescore + awayscore) == overclose

generate spreadopenpayout = (100/(-1*homespreadopenodds)) * 100 + 100 if (homespreadopenodds <0) & (homespreadopen < 0) & (spreadopenwin == 1) 
replace spreadopenpayout = (homespreadopenodds/100) * 100 + 100 if (homespreadopenodds>0) & (homespreadopen < 0) &(spreadopenwin == 1)
replace spreadopenpayout = (100/(-1*awayspreadopenodds)) * 100 + 100 if (awayspreadopenodds <0) & (awayspreadopen < 0) & (spreadopenwin == 1) 
replace spreadopenpayout = (awayspreadopenodds/100) * 100 + 100 if (awayspreadopenodds>0) & (awayspreadopen < 0) &(spreadopenwin == 1)
replace spreadopenpayout = 0 if spreadopenwin == 0 
replace spreadopenpayout = 100 if spreadopenpush == 1

generate spreadclosepayout = (100/(-1*homespreadcloseodds)) * 100 + 100 if (homespreadcloseodds <0) & (homespreadopen < 0) & (spreadopenwin == 1)
replace spreadclosepayout = (homespreadcloseodds/100) * 100 + 100 if (homespreadcloseodds>0) & (spreadopenwin == 1) & (homespreadopen < 0)
replace spreadclosepayout = (100/(-1*awayspreadcloseodds)) * 100 + 100 if (awayspreadcloseodds <0) & (awayspreadopen < 0) & (spreadopenwin == 1)
replace spreadclosepayout = (awayspreadcloseodds/100) * 100 + 100 if (awayspreadcloseodds>0) & (spreadopenwin == 1) & (awayspreadopen < 0)
replace spreadclosepayout = 0 if spreadopenwin == 0 
replace spreadclosepayout = 100 if spreadopenpush == 1

generate overopenpayout = (100/(-1*overopenodds)) * 100 + 100 if (overopenodds <0) & (overopenwin == 1)
replace overopenpayout = (overopenodds/100) * 100 + 100 if (overopenodds>0) * (overopenwin == 1)
replace overopenpayout = 0 if overopenwin == 0 
replace overopenpayout = 100 if overopenpush == 1

generate overclosepayout = (100/(-1*overcloseodds)) * 100 + 100 if (overcloseodds <0) & (overclosewin == 1)
replace overclosepayout = (overcloseodds/100) * 100 + 100 if (overcloseodds>0) * (overclosewin == 1)
replace overclosepayout = 0 if overclosewin == 0 
replace overclosepayout = 100 if overclosepush == 1

generate spreadopenreturn = (spreadopenpayout -100) / 100
generate spreadclosereturn = (spreadclosepayout - 100) / 100

generate spreadocreturn = spreadopenreturn - spreadclosereturn

generate overopenreturn = (overopenpayout -100) / 100
generate overclosereturn = (overclosepayout -100) / 100

generate overocreturn = overopenreturn - overclosereturn

//keep gameid date spreadopenreturn spreadocreturn spreadclosereturn overopenreturn overocreturn overclosereturn 

summarize

save NBAFavReturnsUpdatedLinesNV, replace