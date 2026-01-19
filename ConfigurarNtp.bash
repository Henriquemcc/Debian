#!/bin/bash

# Importing functions run_as_root and install_rpm_package
source RunAsRoot.bash
source RpmPackageManager.bash

# Running as root
run_as_root

# Installing chrony
apt install --assumeyes chrony

# Backing up configuration file
cp "/etc/chrony/chrony.conf" "/etc/chrony/chrony.conf.backup.$(date "+%d-%m-%Y_%H:%M:%S")"
cp "/etc/chrony.conf" "/etc/chrony.conf.backup.$(date "+%d-%m-%Y_%H:%M:%S")"

# Generating new configuration file
{
	# servidores publicos do NTP.br com NTS disponível
	echo "server a.st1.ntp.br iburst nts"
	echo "server b.st1.ntp.br iburst nts"
	echo "server c.st1.ntp.br iburst nts"
	echo "server d.st1.ntp.br iburst nts"
	echo "server gps.ntp.br iburst nts"

	# caso deseje pode configurar servidores adicionais com NTS, como os da cloudflare e netnod
	# nesse caso basta descomentar as linhas a seguir
	echo "#server time.cloudflare.com iburst nts"
	echo "#server nts.netnod.se iburst nts"

	# arquivo usado para manter a informação do atraso do seu relógio local
	echo "driftfile /var/lib/chrony/chrony.drift"

	# local para as chaves e cookies NTS
	echo "ntsdumpdir /var/lib/chrony"

	# se quiser um log detalhado descomente as linhas a seguir
	#echo "log tracking measurements statistics"
	#echo "logdir /var/log/chrony"

	# erro máximo tolerado em ppm em relação aos servidores
	echo "maxupdateskew 100.0"

	# habilita a sincronização via kernel do real-time clock a cada 11 minutos
	echo "rtcsync"

	# ajusta a hora do sistema com um "salto", de uma só vez, ao invés de
	# ajustá-la aos poucos corrigindo a frequência, mas isso apenas se o erro
	# for maior do que 1 segundo e somente para os 3 primeiros ajustes
	echo "makestep 1 3"

	# diretiva que indica que o offset UTC e leapseconds devem ser lidos
	# da base tz (de time zone) do sistema
	echo "leapsectz right/UTC"
} | tee "/etc/chrony.conf" "/etc/chrony/chrony.conf" > /dev/null

# Enabling and restarting chrony
systemctl enable --now chronyd.service
systemctl restart chronyd.service
