FROM adelmofilho/r-base:3.6.2

# Definição de variáveis de ambiente

ARG AWS_ACCESS_KEY_ID
ENV AWS_ACCESS_KEY_ID ${AWS_ACCESS_KEY_ID}

ARG AWS_DEFAULT_REGION
ENV AWS_DEFAULT_REGION ${AWS_DEFAULT_REGION}

ARG AWS_SECRET_ACCESS_KEY
ENV AWS_SECRET_ACCESS_KEY ${AWS_SECRET_ACCESS_KEY}

# Updates e Instalação de softwares adicionais

RUN apt-get update && apt-get install -y cron awscli

# Instalação do pacote

RUN R -e "install.packages('remotes', repos = c(CRAN = 'https://cloud.r-project.org'))"
RUN R -e "remotes::install_github('adelmofilho/Weather-Report')"

# Download de credenciais e configurações

WORKDIR /home/artifacts

RUN aws s3 cp s3://hco-jenkins-bucket/keys_tokens.json /home/artifacts/keys_tokens.json
RUN aws s3 cp s3://hco-jenkins-bucket/settings.json /home/artifacts/settings.json

# Criação do cron job

RUN touch /var/log/cron.log

ADD crontab /etc/cron.d/hello-cron
RUN chmod 0644 /etc/cron.d/hello-cron
RUN crontab /etc/cron.d/hello-cron
RUN ln -sf /dev/stdout /var/log/cron.log

# Execução do bot

WORKDIR /home

RUN /usr/local/bin/R -e "weatherReport::generate_token('/home/artifacts/settings.json')"

ENTRYPOINT echo $( date '+%F_%H:%M:%S' ) && cat /etc/cron.d/hello-cron && cron && tail -f /var/log/cron.log