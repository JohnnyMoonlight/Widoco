# ----
FROM maven:3.8.3-openjdk-17-slim AS BUILD_IMAGE

WORKDIR /var/build/widoco

COPY . .

RUN mvn package && \
    mv ./jar/widoco*.jar ./jar/widoco.jar

# ----
FROM openjdk:17-slim

WORKDIR /usr/local/widoco

COPY --from=BUILD_IMAGE /var/build/widoco/jar/widoco.jar .

ENTRYPOINT ["sh", "-c", "java ${JAVA_OPTS} -jar widoco.jar ${0} ${@}"]