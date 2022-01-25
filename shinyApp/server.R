library(shiny)
library(dplyr)
library(ggplot2)
library(plotly)
library(ggsci)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
    
    #add reactive data information. Dataset = Star Wars Data
    dataset <- reactive({
        
        data<-starwars%>%
            filter(species %in% input$species_input,
                   between(height,input$height_slide[1],input$height_slide[2]),
                   between(mass,input$mass_slide[1],input$mass_slide[2]))
        
        
    })
    
    model<-reactive({
        
        lm_mod<-lm(mass~height,data = dataset())
        
        })
    
    pred<-reactive({
        
        input<-input$height_input
        predict(model(),newdata=data.frame(height=input))
    
        
        
    })
    
    
    output$trendPlot <- renderPlotly({
        
        # build graph with ggplot syntax
        p <-ggplot(dataset(), aes_string("height","mass",color = input$colour,text="name"))+
            geom_point()+
            theme_light()+
            labs(x="Height",y="Mass")+
            scale_color_aaas()
        
        ggplotly(p,tooltip="text") %>% 
            layout(autosize=TRUE,
                   legend = list(orientation = "h",
                                 x = 0.35, y = -0.1))
        
    })
    
    output$pred <- renderText({
        pred()
        
    })
})



















