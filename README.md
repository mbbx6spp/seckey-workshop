# Working with your security key (hardware)

## Run PCSCD

Make sure PCSCD is running. In NixOS you would add this to your
`/etc/nixos/configuration.nix` file inside of your resulting
attrset:

```nix

  services.ncscd.enable = true;

```

To verify this is running appropriate and reading your card:

1. Put your security key into a USB slow.
2. Type `pcsc_scan -n`. (^C to exit.)
3. Output should show your card's information.

## Check version of Yubikey NEO

```bash
$ gpg-connect-agent --hex "scd apdu 00 f1 00 00" /bye
D[0000]  01 00 11 90 00                                     .....
OK
```

The above shows version is 1.0.11. This is above the 1.0.9 version
which as vulnerability for Yubikey NEO.

## Check Nitrokey

TODO: need to document this.


## Editing OpenPGP Card

```
$ gpg --card-edit
Reader ...........: <Vendor> <Product> <Capabilities> 00 00
Application ID ...: ??????????????????????????????
Version ..........: X.Y
Manufacturer .....: ????????
Serial number ....: ????????
Name of cardholder: [not set]
Language prefs ...: [not set]
Sex ..............: unspecified
URL of public key : [not set]
Login data .......: [not set]
Signature PIN ....: forced
Key attributes ...: rsa2048 rsa2048 rsa2048
Max. PIN lengths .: 127 127 127
PIN retry counter : 3 3 3
Signature counter : 0
Signature key ....: [none]
Encryption key....: [none]
Authentication key: [none]
General key info..: [none]
```
