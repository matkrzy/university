FROM node:10.8.0
COPY . ./
ADD load.sh /load.sh


ADD https://github.com/ufoscout/docker-compose-wait/releases/download/2.4.0/wait /wait
RUN chmod +x /wait

CMD /wait && /load.sh


