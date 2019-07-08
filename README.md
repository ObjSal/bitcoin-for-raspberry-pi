# Bitcoin Core for Raspberry Pi

Bitcoin Core RPC client version v0.18.0.0-g2472733a24a9364e4c6233ccd04166a26a68cc65

If you're looking for the official Bitcoin Core for ARM download it directly from the [bitcoincore download site](https://bitcoincore.org/en/download/), make sure you download the 32-bit version, because as of this moment Raspbian runs as 32-bit.

This repository contains bitcoind, bitcoin-cli, bitcoin-tx, bitcoin-wallet and test_bitcoin compiled from source code in Raspberry Pi Model B from the [official source code](https://bitcoincore.org/en/download/).

Building the bitcoin core for Raspberry was very time consuming so I'm making these publicly available for my personal backup, please feel free to use them at your own risk, I highly recommand downloading these binaries from the official download site or build from source, I followed a great guide by Damian Mee titled [Bitcoin Full Node on RBP3 (revised)](https://medium.com/@meeDamian/bitcoin-full-node-on-rbp3-revised-88bb7c8ef1d1).

### Check binary integrity
After downloading the files, check integrity by running the following command from the terminal:
```
$ sha256sum --ignore-missing --check SHA256SUMS.asc
```
You should receive the following output:
```
bitcoin-cli: OK
bitcoind: OK
bitcoin-tx: OK
bitcoin-wallet: OK
test_bitcoin: OK
sha256sum: WARNING: 19 lines are improperly formatted
```

### Verify the creator
To verify the creator of the binaries, run the following commands:
```
# If you haven't already, obtain a copy of my personal signing key:
$ gpg --recv-key 9747978CEAC8ACDEAF2AC3773661EB54D8D413C8

# Verify that the checksums file is PGP signed by Salvador Guerrero:
$ gpg --verify SHA256SUMS.asc

# Check the output from the above command for the following text:
 1. A line that starts with: gpg: Good signature
 2. A complete line saying: Primary key fingerprint: 9747 978C EAC8 ACDE AF2A C377 3661 EB54 D8D4 13C8
```

### Trust the PGP key
If you haven't sign my personal PGP key, you will get a warning that the key is not certified with a trusted certificate, follow the below commands to fix it:
```
# If you haven't already created a personal key, create one now
$ gpg --get-key

# Sign the public key
$ gpg --sign-key 9747978CEAC8ACDEAF2AC3773661EB54D8D413C8
```

### Recommendations
Here are list a few recommendations before running `bitcoind` for the first time
* Use [Raspbian Lite](https://www.raspberrypi.org/downloads/raspbian/), at the time of this writing I was using version `June 2019`, I followed the instructions in [this guide](https://medium.com/@meeDamian/bitcoin-full-node-on-rbp3-revised-88bb7c8ef1d1) to install it; here's my information directly from the terminal:
  * `$ uname -a` > `Linux raspberrypi 4.19.50-v7+ #896 SMP Thu Jun 20 16:11:44 BST 2019 armv7l GNU/Linux`
  * `$ dpkg --print-architecture ` > `armhf`
* Use an Micro SDCard at least 512GB (when running without external HDs).
* Disable swap to [prolong the life of the Micro SDCard](https://raspberrypi.stackexchange.com/a/186).
  * `$ sudo swapoff --all` disabled swap, will revert after reboot
  * `$ sudo apt-get remove dphys-swapfile` permanently disables swap
* Download the entire blockchain on a personal computer and then copy everything except the wallet dir.
* Encrypt and backup the wallet.
* Enable RPC only for local networks.
* If SSH is enabled, change the defauls password for `pi` and `root`.
* Install a Firewall like the `uwf` (Uncomplicated Firewall).
* Install something like `Fail2Ban` to scan logs and ban IP addresses conducting too many failed login attempts.
* Run the bitcoind service as a non-root user.
* Create a service to autostart bitcoind on reboot.
  * For convenience, download the `bitcoind.service` file in this repository and copy this file to `/etc/systemd/system/`
  * Run `$ sudo systemctl enable bitcoind` to enable it.
  * Run `$ sudo systemctl start bitcoind` to start it.
* Install dependencies (hint: below)

### Dependencies
To build from source code I had to install the following packages, if you don't have these installed on your system, run will fail and you will need to install them by running the below command:
```
$ sudo apt install libssl-dev libevent-dev bsdmainutils libboost-system-dev libboost-filesystem-dev libboost-chrono-dev libboost-program-options-dev libboost-test-dev libboost-thread-dev libminiupnpc-dev libzmq3-dev jq
```
I removed `git build-essential libtool autotools-dev automake pkg-config` from the above command because I think these are build only specific requirements, please let me know if any of these are required to run as well.
