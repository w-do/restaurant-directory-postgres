# Christina's restaurant directory
An excel sheet my sister was using to keep track of restaurants in the metro Detroit area, which I decided to turn into a web app. This is a dockerfile for building an image which can be used to serve a PostgreSQL database out of a container.

To build the image, run the following:

`docker build -t [IMAGE NAME] .`

To create and run a container from the image, run the following:

`docker run --name [CONTAINER NAME] -d -p 5432:5432 [IMAGE NAME]`
