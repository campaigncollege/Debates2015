library(stringr)
##August Republican Transcript
url <- "http://www.cbsnews.com/news/transcript-of-the-2015-gop-debate-9-pm/"
text2 <- readLines(url)
str <- unlist(str_extract_all (string =  text2,pattern = '[A-Z]{2,}:.+?(?=[A-Z]{2,}:)'))
str <- as.data.frame(str,stringsAsFactors = F)
names(str) <- "Text"
str <- as.data.frame(gsub("KELLY:|BAIER:","Mods:",str$Text))
names(str) <- "Text"

##September Republican Transcript
url <- "http://www.cbsnews.com/news/transcript-top-tier-primetime-cnn-gop-republican-debate-2015/"
text2 <- readLines(url)
str2 <- unlist(str_extract_all (string =  text2,pattern = '[A-Z]{2,}:.+?(?=[A-Z]{2,}:)'))
str2<- as.data.frame(str2,stringsAsFactors = F)
names(str2) <- "Text"
str2 <- as.data.frame(gsub("TAPPER:","Mods:",str2$Text))
names(str2) <- "Text"

##November Republican Transcript
url <- "http://www.cbsnews.com/news/republican-debate-transcript-primetime-debate-on-economy/"
text2 <- readLines(url)
Nov <- unlist(str_extract_all (string =  text2,pattern = '[A-Z]{2,}:.+?(?=[A-Z]{2,}:)'))
Nov<- as.data.frame(Nov,stringsAsFactors = F)
names(Nov) <- "Text"
Nov <- as.data.frame(gsub("BAKER:|CAVUTO:|BARTIROMO:","Mods:",Nov$Text))
names(Nov) <- "Text"

# Combine the three data sets
Repub <- as.data.frame(rbind(str,str2,Nov))
write.csv(Repub,"RepubFull.csv")
#Get only moderators
RepubMods <- as.data.frame(Repub[grep("Mods:",Repub$Text),],stringsAsFactors = F)
#Get only questions
# RepubModQ <- as.data.frame(RepubMods[grep([?],RepubMods$Text,fixed = T),],stringsAsFactors = F)
#Do some cleaning.
rm(Nov,Repub,str,str2,url,text2)
names(RepubMods) <- "Text"
RepubMods$Text <- gsub("</p><p>"," ",RepubMods$Text)
# RepubMods$Text <- gsub("\\(APPLAUSE\\)"," ",RepubMods$Text)
# RepubMods$Text <- gsub("\\(UNKNOWN\\)"," ",RepubMods$Text)
# RepubMods$Text <- gsub("\\(BOOING\\)"," ",RepubMods$Text)
# RepubMods$Text <- gsub("\\(LAUGHTER\\)"," ",RepubMods$Text)
# RepubMods$Text <- gsub("\\(LAUGHTER\\, BOOING\\)"," ",RepubMods$Text)
# RepubMods$Text <- gsub("\\(OFF MIKE\\)"," ",RepubMods$Text)
RepubMods$Text <- gsub("\\(.+\\)"," ",RepubMods$Text)
RepubMods$Text <- gsub("Mods:"," ",RepubMods$Text)
write.csv(RepubMods,"RepubMods.csv")



