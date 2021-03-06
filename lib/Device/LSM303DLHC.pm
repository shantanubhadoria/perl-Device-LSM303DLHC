use strict;
use warnings;
package Device::LSM303DLHC;

# PODNAME: Device::LSM303DLHC 
# ABSTRACT: I2C interface to LSM303DLHC 3 axis magnetometer(compass) and accelerometer using Device::SMBus
# COPYRIGHT
# VERSION

# Dependencies
use 5.010;
use Moose;
use POSIX;

use Device::SMBus;
use Device::Magnetometer::LSM303DLHC;
use Device::Accelerometer::LSM303DLHC;

=attr I2CBusDevicePath

this is the device file path for your I2CBus that the LSM303DLHC is connected on e.g. /dev/i2c-1
This must be provided during object creation.

=cut

has 'I2CBusDevicePath' => (
    is       => 'ro',
    required => 1,
);

=attr Magnetometer

    $self->Magnetometer->enable();
    $self->Magnetometer->getReading();

This is a object of L<Device::Magnetometer::LSM303DLHC>

=cut

has Magnetometer => (
    is => 'ro',
    isa => 'Device::Magnetometer::LSM303DLHC',
    lazy_build => 1,
);

sub _build_Magnetometer {
    my ($self) = @_;
    my $obj = Device::Magnetometer::LSM303DLHC->new(
        I2CBusDevicePath => $self->I2CBusDevicePath
    );
    return $obj;
}

=attr Accelerometer 

    $self->Accelerometer->enable();
    $self->Accelerometer->getReading();

This is a object of L<Device::Accelerometer::LSM303DLHC>

=cut

has Accelerometer => (
    is => 'ro',
    isa => 'Device::Accelerometer::LSM303DLHC',
    lazy_build => 1,
);

sub _build_Accelerometer {
    my ($self) = @_;
    my $obj = Device::Accelerometer::LSM303DLHC->new(
        I2CBusDevicePath => $self->I2CBusDevicePath
    );
    return $obj;
}

1;
