library(stringr)
##November Democratic Transcript
url <- "http://www.cbsnews.com/news/democratic-debate-transcript-clinton-sanders-omalley-in-iowa/"
text2 <- readLines(url)
DemNov <- unlist(str_extract_all (string =  text2,pattern = '[A-Z]{2,}:.+?(?=[A-Z]{2,}:)'))
DemNov <- as.data.frame(DemNov,stringsAsFactors = F)
names(DemNov) <- "Text"
DemNov <- as.data.frame(gsub("DICKERSON:","Mods:",DemNov$Text))
names(DemNov) <- "Text"

##October Democratic Transcript
url <- "http://www.cbsnews.com/news/the-first-democratic-debate-full-rush-transcript/"
text2 <- readLines(url)
DemOct <- unlist(str_extract_all (string =  text2,pattern = '[A-Z]{2,}:.+?(?=[A-Z]{2,}:)'))
DemOct <- as.data.frame(DemOct,stringsAsFactors = F)
names(DemOct) <- "Text"
DemOct <- as.data.frame(gsub("DICKERSON:","Mods:",DemOct$Text))
names(DemOct) <- "Text"

DemMods <- as.data.frame(rbind(DemNov,DemOct))
names(DemMods) <- "Text"
DemMods <- as.data.frame(DemMods[grep("Mods:",DemMods$Text),],stringsAsFactors = F)
names(DemMods) <- "Text"

DemMods$Text <- gsub("</p><p>"," ",DemMods$Text)
DemMods$Text <- gsub("\\(.+\\)"," ",DemMods$Text)
DemMods$Text <- gsub("Mods:"," ",DemMods$Text)
write.csv(DemMods,"DemMods.csv")
DemsFull <- as.data.frame(rbind(DemNov,DemOct))
write.csv(DemsFull,"DemsFull.csv")
