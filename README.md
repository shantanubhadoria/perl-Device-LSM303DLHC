# NAME

Device::LSM303DLHC - I2C interface to LSM303DLHC 3 axis magnetometer(compass) and accelerometer using Device::SMBus

<div>
    <p>
    <img src="https://img.shields.io/badge/perl-5.10+-brightgreen.svg" alt="Requires Perl 5.10+" />
    <a href="https://travis-ci.org/shantanubhadoria/perl-Device-LSM303DLHC"><img src="https://api.travis-ci.org/shantanubhadoria/perl-Device-LSM303DLHC.svg?branch=build/master" alt="Travis status" /></a>
    <a href="http://matrix.cpantesters.org/?dist=Device-LSM303DLHC%200.014"><img src="https://badgedepot.code301.com/badge/cpantesters/Device-LSM303DLHC/0.014" alt="CPAN Testers result" /></a>
    <a href="http://cpants.cpanauthors.org/dist/Device-LSM303DLHC-0.014"><img src="https://badgedepot.code301.com/badge/kwalitee/Device-LSM303DLHC/0.014" alt="Distribution kwalitee" /></a>
    <a href="https://gratipay.com/shantanubhadoria"><img src="https://img.shields.io/gratipay/shantanubhadoria.svg" alt="Gratipay" /></a>
    </p>
</div>

# VERSION

version 0.014

# ATTRIBUTES

## I2CBusDevicePath

this is the device file path for your I2CBus that the LSM303DLHC is connected on e.g. /dev/i2c-1
This must be provided during object creation.

## Magnetometer

    $self->Magnetometer->enable();
    $self->Magnetometer->getReading();

This is a object of [Device::Magnetometer::LSM303DLHC](https://metacpan.org/pod/Device::Magnetometer::LSM303DLHC)

## Accelerometer 

    $self->Accelerometer->enable();
    $self->Accelerometer->getReading();

This is a object of [Device::Accelerometer::LSM303DLHC](https://metacpan.org/pod/Device::Accelerometer::LSM303DLHC)

# SUPPORT

## Bugs / Feature Requests

Please report any bugs or feature requests through github at 
[https://github.com/shantanubhadoria/perl-device-lsm303dlhc/issues](https://github.com/shantanubhadoria/perl-device-lsm303dlhc/issues).
You will be notified automatically of any progress on your issue.

## Source Code

This is open source software.  The code repository is available for
public review and contribution under the terms of the license.

[https://github.com/shantanubhadoria/perl-device-lsm303dlhc](https://github.com/shantanubhadoria/perl-device-lsm303dlhc)

    git clone git://github.com/shantanubhadoria/perl-device-lsm303dlhc.git

# AUTHOR

Shantanu Bhadoria &lt;shantanu at cpan dott org>

# CONTRIBUTOR

Shantanu <shantanu@cpan.org>

# COPYRIGHT AND LICENSE

This software is copyright (c) 2016 by Shantanu Bhadoria.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.
