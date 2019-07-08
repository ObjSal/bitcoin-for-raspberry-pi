# Bitcoin Core for Raspberry Pi

Bitcoin Core RPC client version v0.18.0.0-g2472733a24a9364e4c6233ccd04166a26a68cc65

This repository contains bitcoind, bitcoin-cli, bitcoin-tx, bitcoin-wallet and test_bitcoin compiled in Raspberry Pi Model B.

Building the bitcoin core for Raspberry was very time consuming so I'm making these publicly available for my personal backup, please feel free to use them at your own risk, I highly recommand you building these from source, I followed a great tutorial by Damian Mee - [Bitcoin Full Node on RBP3 (revised)](https://medium.com/@meeDamian/bitcoin-full-node-on-rbp3-revised-88bb7c8ef1d1).

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

