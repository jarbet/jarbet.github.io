# calculate % matched from matchit() output
matchit.pct.matched <- function(matchit.object) {
    tab.counts <-  as.table(summary(matchit.object)$nn[c('Matched', 'Unmatched'),])
    tab.pct <- round(prop.table(tab.counts, 2) * 100, 1);
    tab <- addmargins(tab.counts, 1);
    tab[1,] <- paste0(tab[1,], ' (',tab.pct[1,],'%)');
    tab[2,] <- paste0(tab[2,], ' (',tab.pct[2,],'%)');
    rownames(tab)[3] <- 'Total';
    tab <- tab[c('Total', 'Matched', 'Unmatched'),];

    return(list(
        tab.counts = tab.counts,
        tab.pct = tab.pct,
        tab.counts.pct = tab
    ))
}
