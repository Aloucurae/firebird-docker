FROM jacobalberty/firebird:v3.0
RUN apt update
RUN apt install nano
ADD ./assets/tbudf.so /usr/local/firebird/UDF/tbudf.so
RUN chmod 755 /usr/local/firebird/UDF/tbudf.so