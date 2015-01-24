library(shiny)

MASSIST<-read.csv("MASSIST_app.csv")
colors <-c("firebrick", "red", "grey", "green", "forestgreen")

# Define a server for the Shiny app
shinyServer(function(input, output) {
        
        # Fill in the spot we created for a plot
        
        output$plot <- renderPlot({
                
                title<-switch(input$Question,
                              "Q1" = "Q1: I organize my study time carefully to make the best use of it.",
                              "Q2" = "Q2: I go over the work I've done carefully to check the reasoning and that it makes sense.",
                              "Q3" = "Q3: Often I feel I'm drowning in the sheer amount of material we're having to cope with.", 
                              "Q4" = "Q4: I think I'm quite systematic and organized when it comes to studying for exams.",
                              "Q5" = "Q5: I look carefully at instructors' comments on course work to see how to get higher grades next time.",
                              "Q6" = "Q6: There’s not much of the work in this course that I find interesting or relevant.",
                              "Q7" = "Q7: When I read an article or book, I try to find out for myself exactly what the author means.",
                              "Q8" = "Q8: I’m pretty good at getting down to work whenever I need to.",
                              "Q9" = "Q9: Much of what I’m studying in this course makes little sense: it's like unrelated bits and pieces.", 
                              "Q10"="Q10: When I’m working on a new topic, I try to see in my own mind how all the ideas fit together.", 
                              "Q11"="Q11: I often worry about whether I'll ever be able to cope with the work properly.", 
                              "Q12"= "Q12: Often I find myself questioning things I hear in lectures or read in books.", 
                              "Q13"="Q13: I concentrate on learning just those bits of information I have to know to pass.", 
                              "Q14"="Q14: I keep in mind who is going to grade an assignment and what they're likely to be looking for.", 
                              "Q15"="Q15: I work steadily through the semester, rather than leave it all until the last minute.", 
                              "Q16"="Q16: I'm not really sure what's important in lectures so I try to get down all I can.", 
                              "Q17"="Q17: Ideas in course books or articles often set me off on long chains of thought of my own.",
                              "Q18"="Q18: Before starting work on an assignment or exam question, I think first how best to tackle it.", 
                              "Q19"="Q19: When I read, I examine the details carefully to see how they fit in with what’s being said.", 
                              "Q20"="Q20: I put a lot of effort into studying because I'm determined to do well.", 
                              "Q21"="Q21: I gear my studying closely to just what seems to be required for assignments and exams.",
                              "Q22"="Q22: I keep an eye open for what my instructor seems to think is important and concentrate on that.", 
                              "Q23"="Q23: Before tackling a problem or assignment, I first try to work out what lies behind it.",
                              "Q24"="Q24: I often have trouble in making sense of the things I have to remember.", 
                              "Q25"="Q25: I don't find it at all difficult to motivate myself.",
                              "Q26"="Q26: I like to be told precisely what to do in lab reports or other assignments.")
                                      
                # Render a barplot
                barplot(table(MASSIST[,input$Question], MASSIST$Final.grade), beside=T, col = colors, 
                        main = title, ylim=c(0,175), ylab ="Count", xlab="Final Course Grade")
                legend("topright", c("Disgree","Disagree Somewhat","Unsure", "Agree Somewhat","Agree"), 
                       cex=1.3, bty="n", fill=colors)
                
        })
        
        output$table <- renderTable({ 
                T<-as.data.frame.matrix(t(table(MASSIST[,input$Question], MASSIST$Final.grade)))
                colnames(T)<-c("Disgree","Disagree Somewhat","Unsure", "Agree Somewhat","Agree")
                T["Total" ,] <-as.integer(colSums(T))
                if (input$table)  T              
               
        })

        output$grade <- renderPlot({
                if (input$Grade)
                        G <- barplot(table(MASSIST$Final.grade), ylim=c(0,300), ylab ="Count")
                
                if (input$Grade)
                        text(x=G, y = 15, label=c("159", "291", "225", "89", "10", "2"))
        })
        
        output$downloadData <- downloadHandler(
                filename = function() { 
                        paste(input$Question, '.csv', sep='') 
                },
                content = function(file) {T<-as.data.frame.matrix(t(table(MASSIST[,input$Question], MASSIST$Final.grade)))
                                          colnames(T)<-c("Disgree","Disagree Somewhat","Unsure", "Agree Somewhat","Agree")
                                          T["Total" ,] <-as.integer(colSums(T))
                        write.csv(T, file)
                })
})