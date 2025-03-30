docker login;
$imageName = "saulotarsobc/eas-sc:latest";
docker build -t $imageName .;
docker push $imageName;