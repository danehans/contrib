#/bin/bash

set -e

cd

BOOTSTRAP_SCRIPT_DIR=${BOOTSTRAP_SCRIPT_DIR:-/opt/bin}

mkdir -p ${BOOTSTRAP_SCRIPT_DIR}

if [[ -e ${BOOTSTRAP_SCRIPT_DIR}/.netbootstrapped ]]; then
  exit 0
fi

function usage {
    cat <<EOF
Usage: $0 COMMAND [options]

Options:
    --interface, -i <interface_name> Name of interface to configure
    --ip_cidr, -c <ip_cir>           IP/cidr of interface. Ex> 10.10.10.10/24
    --gw, -g <gateway_ip>            Gateway IP address
    --dns, -d <dns_ip>               IP address of DNS server
    --help, -h                       Show this usage information
EOF
}


interface=eth0
ip_cidr=
gw=
dns=8.8.8.8

while [ "$#" -gt 0 ]; do
    case "$1" in

        (-i|--interface )      interface=$2
                               shift 2
                               ;;
        (-c | --ip_cidr )      ip_cidr=$2
                               shift 2
                               ;;
        (-g | --gw )           gw=$2
                               shift 2
                               ;;
        (-d | --dns )          dns=$2
                               shift 2
                               ;;
        (-h | --help )         usage
                               shift
                               exit 0
                               ;;
        (*)                    echo "error"
                               exit 3
                               ;;
esac
done

# Make systemd-networkd config directory
mkdir -p /etc/systemd/network

# Make .network file
cat > /etc/systemd/network/${interface}.network <<EOF
[Match]
Name=${interface}

[Network]
Address=${ip_cidr}
Gateway=${gw}
DNS=${dns}
EOF

# Restart the systemd-networkd service
systemctl restart systemd-networkd

# Restart the systemd-resolved service
systemctl restart systemd-resolved

touch ${BOOTSTRAP_SCRIPT_DIR}/.netbootstrapped
