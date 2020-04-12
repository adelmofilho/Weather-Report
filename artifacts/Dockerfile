FROM adelmofilho/r-base:3.6.2

RUN R -e "install.packages('remotes', repos = c(CRAN = 'https://cloud.r-project.org'))"
RUN R -e "remotes::install_github('adelmofilho/Weather-Report')"

WORKDIR /home/artifacts

COPY settings.json /home/artifacts/settings.json
COPY keys_tokens.json /home/artifacts/keys_tokens.json

RUN apt-get update && apt-get install -y cron

RUN touch /var/log/cron.log


ADD .crontab /etc/cron.d/hello-cron
RUN chmod 0644 /etc/cron.d/hello-cron
RUN crontab /etc/cron.d/hello-cron
RUN ln -sf /dev/stdout /var/log/cron.log
WORKDIR /home

RUN /usr/local/bin/R -e "weatherReport::generate_token('/home/artifacts/settings.json')"

ENTRYPOINT echo $( date '+%F_%H:%M:%S' ) && cat /etc/cron.d/hello-cron && cron && tail -f /var/log/cron.log
