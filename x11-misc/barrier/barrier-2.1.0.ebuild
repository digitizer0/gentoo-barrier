# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Lets you easily share a single mouse and keyboard between multiple computers"
HOMEPAGE="https://github.com/debauchee/barrier"
SRC_URI="https://github.com/debauchee/barrier/archive/v${PV}.tar.gz"
LICENSE="GPL-2.0"
SLOT="0"
KEYWORDS="~amd64"
IUSE="qt5"

S=${WORKDIR}/${PN}-${PV}

COMMON_DEPEND="
	net-misc/curl
	x11-libs/libICE
	x11-libs/libSM
	x11-libs/libX11
	x11-libs/libXext
	x11-libs/libXi
	x11-libs/libXinerama
	x11-libs/libXrandr
	x11-libs/libXtst
	dev-qt/qtcore:5
	dev-qt/qtgui:5
	dev-qt/qtnetwork:5
	dev-qt/qtwidgets:5
	net-dns/avahi[mdnsresponder-compat]
"
DEPEND="
	${COMMON_DEPEND}
	x11-base/xorg-proto
"

DOCS=( ChangeLog doc/barrier.conf.example{,-advanced,-basic} )


#src_configure() {

	#cmake-utils_src_configure
#	clean-build.sh
#}


src_install () {
	${S}/clean_build.sh
	dobin "${S}"/build/bin/barrier{c,s}

	newbin "${S}"/build/bin/${PN} barrier 
	#newicon -s 256 "${DISTDIR}"/${PN}.png q${PN}.png
	#make_desktop_entry q${PN} ${PN/s/S} q${PN} Utility;

	insinto /etc
	newins doc/barrier.conf.example barrier.conf

	newman ${S}/doc/${PN}c.1 ${PN}c.1
	newman ${S}/doc/${PN}s.1 ${PN}s.1

	einstalldocs
}

pkg_preinst() {
	use qt5 && gnome2_icon_savelist
}

pkg_postinst() {
	use qt5 && gnome2_icon_cache_update
}

pkg_postrm() {
	use qt5 && gnome2_icon_cache_update
}

