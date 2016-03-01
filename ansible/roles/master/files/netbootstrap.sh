#/bin/bash

set -e

cd

KUBE_SCRIPT_DIR=${KUBE_SCRIPT_DIR:-/usr/libexec/kubernetes}

mkdir -p ${KUBE_SCRIPT_DIR}

if [[ -e ${KUBE_SCRIPT_DIR}/.netbootstrapped ]]; then
  exit 0
fi

function usage {
    cat <<EOF
Usage: $0 COMMAND [options]

Options:
    --interface, -int <interface_name> Name of interface to configure
    --ip, -i <ip_address>              IP address of interface. Ex> 10.10.10.10
    --cidr, -c <ip_cidr>               CIDR of IP address. Ex> /24
    --help, -h                         Show this usage information
EOF
}


interface=eth0
ip=
cidr=

while [ "$#" -gt 0 ]; do
    case "$1" in

        (-int | --interface )  interface=$2
                               shift 2
                               ;;
        (-i | --ip )           ip=$2
                               shift 2
                               ;;
        (-c | --cidr )         cidr=$2
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
Address=${ip}${cidr}
EOF

# Restart the systemd-networkd service
systemctl restart systemd-networkd

# Restart the systemd-resolved service
systemctl restart systemd-resolved

touch ${KUBE_SCRIPT_DIR}/.netbootstrapped
