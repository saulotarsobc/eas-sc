# Usar a imagem base do Node.js 20 com Debian Bullseye
FROM node:20-bullseye

# Atualizar e instalar dependências
RUN apt update && \
    apt upgrade -y && \
    apt install -y \
    curl \
    git \
    unzip \
    openjdk-17-jdk \
    python3 \
    python3-pip \
    build-essential \
    wget \
    ca-certificates \
    && apt clean

# Pacotes globais necessários
RUN npm install -g npm@latest;
RUN npm install -g yarn pnpm bun node-gyp expo-cli eas-cli --force;

# Instalar o Android SDK
RUN mkdir -p /root/Android/Sdk/cmdline-tools && \
    cd /root/Android/Sdk/cmdline-tools && \
    wget https://dl.google.com/android/repository/commandlinetools-linux-10406996_latest.zip -O latest.zip && \
    unzip latest.zip && \
    mv cmdline-tools latest && \
    rm latest.zip

# Set Android environment variables
ENV ANDROID_HOME="/root/Android/Sdk" \
    ANDROID_SDK_ROOT="/root/Android/Sdk" \
    ANDROID_NDK_HOME="/root/Android/Sdk/ndk/26.1.10909125" \
    PATH="/root/Android/Sdk/platform-tools:/root/Android/Sdk/cmdline-tools/latest/bin:/root/Android/Sdk/build-tools/34.0.0:$PATH"

# Travar o terminal em desenvolvimento
# CMD tail -f /dev/null