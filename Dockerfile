FROM opensuse:leap

RUN zypper --non-interactive ref \
	&& zypper --non-interactive install --type pattern devel_basis devel_C_C++ devel_kernel \
	&& zypper --non-interactive install libxtables-devel libnetfilter_conntrack-devel xtables-addons libjson-c-devel \
	&& zypper --non-interactive install kernel-default kernel-default-devel kmod \
	&& zypper --non-interactive install libpcap-devel git \
	&& zypper --non-interactive clean

RUN mkdir /build
VOLUME /build
CMD ["/build/build.sh"]
