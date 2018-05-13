# Use Ubuntu
FROM ubuntu:18.04

# Setup workdir
ENV WORKDIR /app
WORKDIR ${WORKDIR}

# Install dependencies
RUN apt-get update
RUN apt-get install sudo git curl wget xz-utils build-essential -y

# Set Environment Variables
ENV DEVKITPRO /opt/devkitpro
ENV DEVKITA64 /opt/devkitpro/devkitA64
ENV DEVKITARM /opt/devkitpro/devkitARM

# Install devkitA64
RUN curl -L https://raw.githubusercontent.com/devkitPro/installer/master/perl/devkitA64update.pl -o devkitA64update.pl
RUN chmod +x ./devkitA64update.pl
RUN ./devkitA64update.pl

# Install devkitARM
RUN curl -L https://raw.githubusercontent.com/devkitPro/installer/master/perl/devkitARMupdate.pl -o devkitARMupdate.pl
RUN chmod +x ./devkitARMupdate.pl
RUN ./devkitARMupdate.pl

# Install latest libnx
RUN rm -rf /opt/devkitpro/libnx
RUN git clone https://github.com/switchbrew/libnx.git ${WORKDIR}/libnx
RUN cd ${WORKDIR}/libnx && make && make install

# Cleanup
RUN rm -rf ${WORKDIR}/*

# Add non-root user
RUN useradd switchci && echo "switchci:switchci" | chpasswd && adduser switchci sudo

# Give workdir and devkitpro permissions to user
RUN chown -R switchci:switchci ${WORKDIR}
RUN chown -R switchci:switchci /opt/devkitpro

# Switch to user
USER switchci