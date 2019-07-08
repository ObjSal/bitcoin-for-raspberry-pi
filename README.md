# Bitcoin Core for Raspberry Pi

Bitcoin Core RPC client version v0.18.0.0-g2472733a24a9364e4c6233ccd04166a26a68cc65

This repository contains bitcoind, bitcoin-cli, bitcoin-tx, bitcoin-wallet and test_bitcoin compiled in Raspberry Pi Model B from the [official source code](https://bitcoincore.org/en/download/).

Building the bitcoin core for Raspberry was very time consuming so I'm making these publicly available for my personal backup, please feel free to use them at your own risk, I highly recommand you building these from source, I followed a great guide by Damian Mee titled [Bitcoin Full Node on RBP3 (revised)](https://medium.com/@meeDamian/bitcoin-full-node-on-rbp3-revised-88bb7c8ef1d1).

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
Here I list a few recommendations before running `bitcoind` for the first time
* Use [Raspbian Lite](https://www.raspberrypi.org/downloads/raspbian/), at the time of this writing I was using version `June 2019`, I followed the instructions in [this guide](https://medium.com/@meeDamian/bitcoin-full-node-on-rbp3-revised-88bb7c8ef1d1) to install it.
* Use an Micro SDCard at least 512GB (when running without external HDs).
* Disable swap to [prolong the life of the Micro SDCard](https://raspberrypi.stackexchange.com/a/186).
  * `$ sudo swapoff --all` disabled swap, will revert after reboot
  * `$ sudo apt-get remove dphys-swapfile` permanently disabled swap
* Download the entire blockchain on a personal computer and then copy everything except the wallet dir.
* Encrypt and backup the wallet.
* Enable RPC only for local networks.
* If SSH is enabled, change the defauls password for `pi` and `root`.
* Install a Firewall like the `uwf` (Uncomplicated Firewall).
* Install something like `Fail2Ban` to scan logs and ban IP addresses conducting too many failed login attempts.
* Run the bitcoind service as a non-root user.
* Create a service to autostart bitcoind on reboot.
