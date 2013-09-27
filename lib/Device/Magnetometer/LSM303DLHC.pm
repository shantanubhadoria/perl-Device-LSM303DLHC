use strict;
use warnings;
package Device::Magnetometer::LSM303DLHC;

# PODNAME: Device::Magnetometer::LSM303DLHC
# ABSTRACT: I2C interface to Magnetometer on the LSM303DLHC 3 axis magnetometer(compass) and accelerometer using Device::SMBus
# COPYRIGHT
# VERSION

# Dependencies
use 5.010;
use Moose;
use POSIX;

extends 'Device::SMBus';

=attr I2CDeviceAddress

Contains the I2CDevice Address for the bus on which your Magnetometer is connected. It would look like 0x6b. Default is 0x1e.

=cut

has '+I2CDeviceAddress' => (
    is      => 'ro',
    default => 0x1e,
);

=register MR_REG_M

=cut

# Registers for the Magnetometer
use constant {
    MR_REG_M    => 0x02,
};

=register OUT_X_H_M

=register OUT_X_L_M

=register OUT_Y_H_M

=register OUT_Y_L_M

=register OUT_Z_H_M

=register OUT_Z_L_M

=cut

# X, Y and Z Axis magnetic Field Data value in 2's complement
use constant {
    OUT_X_H_M => 0x03,
    OUT_X_L_M => 0x04,

    OUT_Y_H_M => 0x07,
    OUT_Y_L_M => 0x08,

    OUT_Z_H_M => 0x05,
    OUT_Z_L_M => 0x06,
};

has magnetometerMaxVector => (
    is      => 'rw',
    default => sub {
        return (
            x => 0,
            y => 0,
            z => 0,);
    },
);

has magnetometerMinVector => (
    is      => 'rw',
    default => sub {
        return (
            x => 0,
            y => 0,
            z => 0,);
    },
);


=method enable 

    $self->enable()

Initializes the device, Call this before you start using the device. This function sets up the appropriate default registers.
The Device will not work properly unless you call this function

=cut

sub enable {
    my ($self) = @_;
    $self->writeByteData(MR_REG_M,0x00);
}

=method getRawReading

    $self->getRawReading()

Return raw readings from accelerometer registers

=cut

sub getRawReading {
    my ($self) = @_;

    return {
        x => $self->_typecast_int_to_int16( ($self->readByteData(OUT_X_H_M) << 8) | $self->readByteData(OUT_X_L_M) ),
        y => $self->_typecast_int_to_int16( ($self->readByteData(OUT_Y_H_M) << 8) | $self->readByteData(OUT_Y_L_M) ),
        z => $self->_typecast_int_to_int16( ($self->readByteData(OUT_Z_H_M) << 8) | $self->readByteData(OUT_Z_L_M) ),
    };
}

=method getReading

    $self->getReading()

Return proper calculated readings from the magnetometer

=cut

sub getReading {
    my ($self) = @_;
}

sub _typecast_int_to_int16 {
    return  unpack 's' => pack 'S' => $_[1];
}

1;
