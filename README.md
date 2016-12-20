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


## Inspect OpenPGP Card

When you first inspect your OpenPGP card it will likely look something
like the following:

```
$ gpg2 --card-status
Reader ...........: ????
Application ID ...: ????
Version ..........: ????
Manufacturer .....: ????
Serial number ....: ????
Name of cardholder: [not set]
Language prefs ...: [not set]
Sex ..............: unspecified
URL of public key : [not set]
Login data .......: [not set]
Signature PIN ....: not forced
Key attributes ...: rsa2048 rsa2048 rsa2048
Max. PIN lengths .: 127 127 127
PIN retry counter : 3 0 3
Signature counter : 0
Signature key ....: [none]
Encryption key....: [none]
Authentication key: [none]
General key info..: [none]
```

## Editing OpenPGP Card

To start customizing your OpenPGP card you will want to enter
edit mode in `gpg`.

```
$ gpg2 --card-edit
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

gpg/card>
```

You will be taken to the `gpg/card` prompt. Here you will want
to enter the `admin` area:

```
gpg/card> admin
Admin commands are allowed

```

You have a few subcommand choices available (see below):

```
gpg/card> help
quit           quit this menu
admin          show admin commands
help           show this help
list           list all available data
name           change card holder's name
url            change URL to retrieve key
fetch          fetch the key specified in the card URL
login          change the login name
lang           change the language preferences
sex            change card holder's sex
cafpr          change a CA fingerprint
forcesig       toggle the signature force PIN flag
generate       generate new keys
passwd         menu to change or unblock the PIN
verify         verify the PIN and list all data
unblock        unblock the PIN using a Reset Code
factory-reset  destroy all keys and data
```

## Change Card's PINs

To start out with a brand new OpenPGP card you will want to change
the card's PINs. To do this we enter the `passwd` menu:

```
gpg/card> passwd
gpg: OpenPGP card no. ?????????????????????????? detected

1 - change PIN
2 - unblock PIN
3 - change Admin PIN
4 - set the Reset Code
Q - quit

Your selection?
```

You will want to choose `1`. Check your OpenPGP card's manual for
the default PIN. Follow the prompts (it asks for the existing PIN
first before you can change it).

Repeat for the Admin PIN by next selecting 3 after successfully
changing the PIN above. Again follow the prompts and note that it
will first ask you for the existing Admin PIN (manufacturer's default)
before asking for your new Admin PIN and a confirmation (repeat new
Admin PIN a second time).

Now just pay attention to which kind of PIN is requested when prompted
during the generation of keys. Go brew some coffee, tea or beer. It will
take some time. :)

Now you can quit (`Q`) the `passwd` submenu in the `admin` area.

### Generate key

Still in the `admin` menu you will want to `generate` a new card.

```
gpg/card> generate
Make off-card backup of encryption key? (Y/n)
...
```

Here you will want to follow the prompts. Pay attention to which PIN it is
prompting for. You can choose to make an off-card backup if you choose.
If you do I recommend using a zero knowledge backup solution to store
a strong passphrase protected off-card backup and revocation cert.


