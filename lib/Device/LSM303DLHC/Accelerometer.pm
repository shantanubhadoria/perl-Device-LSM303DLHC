package Device::LSM303DLHC::Accelerometer;

# PODNAME: Device::LSM303DLHC::Accelerometer
# ABSTRACT: I2C interface to Accelerometer on the LSM303DLHC 3 axis magnetometer(compass) and accelerometer using Device::SMBus
# COPYRIGHT
# VERSION

use 5.010;
use Moose;
use POSIX;

# Registers for the Accelerometer 
use constant {
    CTRL_REG1_A => 0x20,
    CTRL_REG4_A => 0x23,
};

# X, Y and Z Axis magnetic Field Data value in 2's complement
use constant {
    OUT_X_H_A => 0x29,
    OUT_X_L_A => 0x28,

    OUT_Y_H_A => 0x2b,
    OUT_Y_L_A => 0x2a,

    OUT_Z_H_A => 0x2d,
    OUT_Z_L_A => 0x2c,
};

use integer; # Use arithmetic right shift instead of unsigned binary right shift with >> 4

extends 'Device::SMBus';

has '+I2CDeviceAddress' => (
    is      => 'ro',
    default => 0x19,
);

has magnetometerMaxVector => (
    is      => 'rw',
    default => (
        x => 0,
        y => 0,
        z => 0,
    ),
);

has magnetometerMinVector => (
    is      => 'rw',
    default => (
        x => 0,
        y => 0,
        z => 0,
    ),
);


=method enable 

    $self->enable()

Initializes the device, Call this before you start using the device. This function sets up the appropriate default registers.
The Device will not work properly unless you call this function

=cut

sub enable {
    my ($self) = @_;
    $self->writeByteData(CTRL_REG1_A,0b01010111);
    $self->writeByteData(CTRL_REG4_A,0b00101000);
}

=method getRawReading

    $self->getRawReading()

Return raw readings from accelerometer registers

=cut

sub getRawReading {
    my ($self) = @_;

    return (
        x => ( $self->_typecast_int_to_int16( ($self->readByteData(OUT_X_H_A) << 8) | $self->readByteData(OUT_X_L_A) ) ) >> 4,
        y => ( $self->_typecast_int_to_int16( ($self->readByteData(OUT_Y_H_A) << 8) | $self->readByteData(OUT_Y_L_A) ) ) >> 4,
        z => ( $self->_typecast_int_to_int16( ($self->readByteData(OUT_Z_H_A) << 8) | $self->readByteData(OUT_Z_L_A) ) ) >> 4,
    );
}

sub _typecast_int_to_int16 {
    return  unpack 's' => pack 'S' => $_[1];
}

sub calibrate {
    my ($self) =@_;

}

1;
