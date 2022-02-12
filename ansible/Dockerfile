FROM nginx:latest
RUN apt-get update && apt-get install -y openssh-server
RUN echo 'root:myuser' | chpasswd
EXPOSE 22
EXPOSE 80
EXPOSE 80:80
CMD ["nginx", "-g", "daemon off;"]