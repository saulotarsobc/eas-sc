# Usar a imagem base do Ubuntu 22.04
FROM ubuntu:22.04

# Definir o diretório de trabalho
WORKDIR /root

# Atualizar e instalar dependências
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y \
    curl \
    git \
    unzip \
    openjdk-17-jdk \
    python3 \
    python3-pip \
    build-essential \
    wget \
    && apt-get clean

# Instalar o NVM (Node Version Manager)
RUN curl -fsSL https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.4/install.sh | bash

# Carregar o NVM diretamente e instalar o Node.js 20
RUN /bin/bash -c "source $HOME/.nvm/nvm.sh && nvm install 20 && nvm use 20 && nvm alias default 20"

# Instalar pacotes globais necessários
RUN /bin/bash -c "source $HOME/.nvm/nvm.sh && npm install -g yarn pnpm bun node-gyp expo-cli eas-cli"

# Baixar e instalar o Android SDK
RUN mkdir -p $HOME/Android/Sdk && \
    cd $HOME/Android/Sdk && \
    wget https://dl.google.com/android/repository/commandlinetools-linux-10406996_latest.zip -O latest.zip && \
    unzip latest.zip && \
    rm latest.zip && \
    mv cmdline-tools $HOME/Android/Sdk/cmdline-tools

# Definir as variáveis de ambiente para o SDK e NDK
ENV ANDROID_HOME=$HOME/Android/Sdk
ENV ANDROID_SDK_ROOT=$ANDROID_HOME
ENV ANDROID_NDK_HOME=$ANDROID_HOME/ndk/26.1.10909125

# Adicionar os diretórios ao PATH
ENV PATH=$ANDROID_HOME/platform-tools:$PATH
ENV PATH=$ANDROID_HOME/cmdline-tools/latest/bin:$PATH
ENV PATH=$ANDROID_HOME/build-tools/34.0.0:$PATH

# Verificar a existência do sdkmanager e, em seguida, executar o comando
RUN echo "Verificando sdkmanager em $ANDROID_HOME/cmdline-tools/latest/bin" && \
    ls -l $ANDROID_HOME/cmdline-tools/latest/bin && \
    yes | $ANDROID_HOME/cmdline-tools/latest/bin/sdkmanager --update && \
    $ANDROID_HOME/cmdline-tools/latest/bin/sdkmanager --install "platform-tools" "platforms;android-34" "build-tools;34.0.0" "cmdline-tools;latest" "ndk;26.1.10909125"

# Comando final para manter o container em execução
CMD ["tail", "-f", "/dev/null"]
