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
  && apt install git curl xz-utils bzip2 make -y

# Install devkitA64
RUN mkdir -p ${DEVKITA64} ${DEVKITARM} \
  && curl -L https://downloads.devkitpro.org/devkitA64_a7-x86_64-linux.tar.xz -o ${WORKDIR}/devkitA64.tar.xz \
  && tar xC ${DEVKITPRO} -f ${WORKDIR}/devkitA64.tar.xz \
# Install devkitARM
  && curl -L https://downloads.devkitpro.org/devkitARM_r47-x86_64-linux.tar.bz2 -o ${WORKDIR}/devkitARM.tar.bz2 \
  && tar xjC ${DEVKITPRO} -f ${WORKDIR}/devkitARM.tar.bz2 \
# Cleanup
  && rm -rf ${WORKDIR}/* ${DEVKITPRO}/examples

# Install latest libnx
RUN git clone https://github.com/switchbrew/libnx.git ${WORKDIR}/libnx \
  && cd ${WORKDIR}/libnx \
  && make \
  && make install \
# Cleanup
  && rm -rf ${WORKDIR}/libnx