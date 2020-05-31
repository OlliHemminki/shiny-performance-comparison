# shiny-performance-comparison

To create an image you may use a simple command:

    docker build -t shiny-performance-comparison .

The application runs on port 3838, so you may launch it using the following command:

    docker run -p 3838:3838 shiny-performance-comparison

Make sure you have all of the following files and paths in place!

.
├── commands.txt
├── Dockerfile
├── index.html
└── srv
    ├── shinyapps
    │   └── performance-comparison
    │       └── app.R
    └── shinylog
        └── testi-shiny-20200531-090251-35373.log

You can find all of the necessary files from https://github.com/OlliHemminki/shiny-performance-comparison.
