# Use minideb base
FROM bitnami/minideb

# Set Environment Variables
ENV WORKDIR /app
ENV DEVKITPRO /opt/devkitpro
ENV DEVKITA64 ${DEVKITPRO}/devkitA64
ENV DEVKITARM ${DEVKITPRO}/devkitARM
ENV PATH=${PATH}:${DEVKITA64}/bin:${DEVKITARM}/bin

# Setup workdir
WORKDIR ${WORKDIR}

# Install dependencies
RUN apt-get update \
  && apt install git curl xz-utils bzip2 make libxml2 -y

# Install devkitA64
RUN mkdir -p ${DEVKITA64} ${DEVKITARM} \
  && curl -L https://downloads.devkitpro.org/devkitA64_a7-x86_64-linux.tar.xz -o ${WORKDIR}/devkitA64.tar.xz \
  && tar xC ${DEVKITPRO} -f ${WORKDIR}/devkitA64.tar.xz \
# Install devkitARM
  && curl -L https://downloads.devkitpro.org/devkitARM_r47-x86_64-linux.tar.bz2 -o ${WORKDIR}/devkitARM.tar.bz2 \
  && tar xjC ${DEVKITPRO} -f ${WORKDIR}/devkitARM.tar.bz2 \
# Cleanup
  && rm -rf ${WORKDIR}/* ${DEVKITPRO}/examples

# Install libnx
RUN git clone https://github.com/switchbrew/libnx.git ${WORKDIR}/libnx \
  && cd ${WORKDIR}/libnx \
  && make \
  && make install \
  && rm -rf ${WORKDIR}/libnx

# Install devkitpro-pacman
RUN curl -L https://github.com/devkitPro/pacman/releases/download/v1.0.0/devkitpro-pacman.deb -o ${WORKDIR}/devkitpro-pacman.deb \
  && dpkg -i ${WORKDIR}/devkitpro-pacman.deb \
  && rm ${WORKDIR}/devkitpro-pacman.deb \
# Install sdl2
  && dkp-pacman -S --noconfirm switch-sdl2 \
# Install sdl2-image
  switch-sdl2_image \
# Install sdl2-mixer
  switch-sdl2_mixer \
# Install sdl2-ttf
  switch-sdl2_ttf \
# Install libjpeg-turbo
  switch-libjpeg-turbo \
# Install libvorbixidec
  switch-libvorbisidec \
# Install libogg
  switch-libogg \
# Install mpeg123
  switch-mpg123 \
# Install libmodplug
  switch-libmodplug \
# Install libpng
  switch-libpng \
# Install freetype
  switch-freetype \
# Install bzip2
  switch-bzip2