library(shiny)

shinyUI(fluidPage(
       
       headerPanel(img(src='logoKeyboard.png', align = "left")),
       
       navlistPanel(
              
              "Predictive Text",
              tabPanel("Key board",
                       h3('Predicted Words:'),
                       
                       textOutput("table"),
                                
                       # textInput('txtKyBrd','', width = '1200px'),
                       # actionButton('btnSubmit','Submit'),
                       
                       fluidRow(
                              column(8, align="center", offset = 2,
                                     textInput('txtKyBrd', label="",value = "", width = "100%"),
                                     tags$style(type="text/css", "#string { height: 100px; width: 100%; text-align:center; font-size: 30px; display: block;}")
                              )
                       ),
                       
                       p("At start Apllication will load possible words and also predict the
                          next word when pressing space button"),
                       p("Model performs good when entered atleast three words in the text box."),
                       
                       h3("Technical Details:"),
                       p("The Predictive Model is made as follows:"),
                       tags$li("The first 10000 lines of each data set is selected as sample for
                               model"),
                       tags$li("4-gram tokenization are made for each of the sample data set"),
                       tags$li("White spaces, stop wors and punctuation are removed from the corpus"),
                       tags$li("For compuational performace, the frequency of each 4-1 gram tokens
                               is calculated and stored in a csv file."),
                       tags$li("The Stuid back off model is implemented"),
                       tags$li("Instead of saving all data in a row, the different tokens are stored
                               in different columns and search is performed by n-1 input words with
                               the specific column."),
                       tags$li("The length of input text was maximum of 3.")
                       
                       ),
              "Social Media",
              tabPanel("Twitter",
                       p("Althoug I was sucessfully downloaded the data from local machine but
                         won't able to fetch on shiny server."),
                       actionButton('btnGetTwit','Get Data')
                       ),
              tabPanel("LinkedIn",
                       p("Althoug I was sucessfully downloaded the data from local machine but
                         won't able to fetch on shiny server."),
                       actionButton("btnGetLined", "Get Data")
                       ),
              tabPanel("Facebook",
                       p("oAuth Aunthication to be implement for Facebook.")
                       ),
              "-----",
              tabPanel("Documentation",
                       h3("Documentation:"),
                       h4('"Hum log URDU aise likthy hen"'),
                       
                       p("The Predictive Keyboardme, as name suggests is an application that predicts
                            the excepted next word while user is typing in the Textbox. But no good 
                            model would be able to predict the next word for the sentence mentioned 
                            at the top of page."
                       ),
                       
                       p("The best and simple answer for the above question found, not to fine tune 
                         the model, but build model on POPULATION not Sampling. "
                       ),
                       
                       p("The proposed solution of the Predictive Keyboard, is to take input of each
                            individual from his/her own writing pattern. So, the  Applicatoin will 
                            be fetching data from Social Media such as Facebook, LinkedIn, Twitter
                            and even whatsApp and will be creating individuals corpus. Since, most
                            of invidiuals typing pattern at each platform is different so user will
                            be provided option to use specific corpus for each media. 
                            The big picture of application is shown below:"
                       ),
                       
                       img(src='bigPicture.png', align = "centre"),
                       
                       h3("Future Work:"),
                       
                       p("Since, there is a short time to build a working model, the following points
                            are to be considered in the future, If some investor find this 
                            application worthwhile."
                       ),
                       
                       tags$li("The Application will be build for mobile platform."),
                       tags$li("We can also make keyboard extension for Social Media website"),
                       tags$li("The corpus data sampling and target platform selection."),
                       tags$li("The Further NLP/Text Mining algorithms will be used in 
                               the model to have better word prediction."),
                       tags$li("There are other points in mind, which can be discussed in detail."),
                       
                       p("Please navigate to contact tab and get connected.")
                       ),
                     
              tabPanel("Contact",
                       
                       p("You are very special for us. And we will be happy
                         to hear from you some good remarks for the demo application. "),
                       p("Please contact:"),
                       tags$li("hamzafar_89@yahoo.com"),
                       tags$li("+92-345-3044799"),
                       # tags$li("https://pk.linkedin.com/in/hamza-zafar-89696851"),
                       tags$li(
                              tags$a(href="https://pk.linkedin.com/in/hamza-zafar-89696851",
                                     "linkedIn Profile"))
                       )
                            
              
                       
       )
       
       
))