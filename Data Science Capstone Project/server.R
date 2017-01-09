library(shiny)

library(dplyr)
library(stringr)
library(tm)

library(Rlinkedin)
library(httr)
library(RCurl) 
library(base64enc)

require(twitteR)

library(SnowballC)


textData <- read.csv("allData.csv", sep = ',',
                     stringsAsFactors = F)

predictNextWord <- function(inputText, dtm){
       flg <- F
       predictWord <- c()
       exitLoop <- 0
       
       for(itr in 1:3){
              if(flg == T){
                     # print('flg is T')
              }
              
              else{
                     
                     # print(paste('itr number:', itr))
                     
                     cmpWord <- findCmpWords(inputText ,itr)
                     # print(cmpWord)
                     
                     m <- str_match_all(cmpWord, "\\S+" )
                     idx <- length(m[[1]]) + 1
                     
                     colNam <- paste0('x',idx)
                     # print(colNam)      
                     
                     
                     for( b in dtm[[colNam]]){
                            #               print(b)
                            #               print(cmpWord)
                            if(exitLoop >15){
                                   # print(exitLoop)
                                   break
                            }
                            
                            if(grepl(paste0('^',cmpWord), b) == TRUE){
                                   predictWord <- c(predictWord, word(b,-1))         
                                   # print(b)
                                   
                                   exitLoop <- exitLoop +1
                                   flg <- T
                            }
                            
                     }
              }
       }
       if(length(predictWord)==0){
              x4 <- sample(1:100, 15, replace=T)
              predictWord <- textData$x1[x4]
       }
       unique(predictWord)
}


findCmpWords <- function(inputText, itr = 1){
       # inputText <- "named"
       if(itr >3){}
       else{
              m <- str_match_all(inputText, "\\S+" )  # Sequences of non-spaces
              
              nStart <- -1
              if(length(m[[1]]) >= 4){
                     nStart <- -3 
              }
              if(length(m[[1]]) >= 2 & length(m[[1]]) < 4 ){
                     nStart <- -length(m[[1]]) + 1
              }
              
              if(itr != 1){
                     nStart <- nStart + (itr-1)
              }
              
              val <- Corpus(VectorSource(word(inputText,start =nStart, end = -1)),
                            readerControl = list(language = "en"))
              
              if(length(m[[1]]) > 0  & length(m[[1]]) < 3){
                     val <- tm_map(val, removeWords, stopwords("english"))
                     val <- tm_map(val, stemDocument) 
              }
              
              val <- tm_map(val, removePunctuation)
              val <- tm_map(val, stripWhitespace)
              val <- tm_map(val, removeNumbers)
              val <- tm_map(val, tolower)
              
              val <-  tm_map(val, PlainTextDocument)
              val <- lapply(val, as.character)
              val[[1]]
              
       }
}

linkedInTimline <- function(){
       consumer_key <- "75aisimucwb9k0"
       consumer_secret <- "g86UZ5uxKTUp1bu6"
       
       options(RCurlOptions = list(cainfo = system.file("CurlSSL", "cacert.pem", package = "RCurl")))
       
       linkedin <- oauth_endpoint("requestToken", "authorize", "accessToken", 
                                  base_url = "https://api.linkedin.com/uas/oauth/")
       myapp <- oauth_app("linkedin", key = consumer_key, secret = consumer_secret)
       
       token <- oauth1.0_token(linkedin, myapp)
       
       
       req <- GET("https://api.linkedin.com/v1/people/~", config(token = token))
       stop_for_status(req)
       content(req)
       
}

twiterTimeLine <- function(user = 'medriscoll', n = 100){
       api_key <- "SigxKj38CEfoiBhEz3T2ob0xp"
       
       api_secret <- "33xEyLCmwXqPTzXmLwDKKdqINdyccbf2tPOFxDwpH7GdDAhO2Z"
       
       access_token <- "2281113985-8861zG0l3lsYfQqHn0PSSenvMXp9qDXKAuGIME2"
       
       access_token_secret <- "xfmBdgmk3G83nopp272yMHeH94cXDby6vB0FhMzmmGbGc"
       
       setup_twitter_oauth(api_key,api_secret,access_token,access_token_secret)
       
       
       mht <- userTimeline(user, n)
       tw.df=twListToDF(mht)
}


shinyServer(function(input, output) {
       
       output$table <- renderPrint(
              predictNextWord(input$txtKyBrd, dtm = textData)
       )
       
#        df <- eventReactive(input$button, {
#               # head(cars, input$x)
#               linkedInTimline()
#        })
# #        output$table <- renderTable({
# #               df()
# #        })
#        
#        df <- eventReactive(input$btnGetTwit, {
#               # head(cars, input$x)
#               twiterTimeLine()
#        })
       
       
})