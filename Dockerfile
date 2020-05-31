FROM rocker/shiny-verse

COPY /srv/shinyapps /srv/shiny-server

RUN R -e "install.packages('plotly')"

EXPOSE 3838

COPY index.html /srv/shiny-server/index.html

#RUN rm /srv/shiny-server/index.html
#RUN rm -rf /srv/shiny-server/sample-apps
