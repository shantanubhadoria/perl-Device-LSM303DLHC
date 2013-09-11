package Device::LSM303DLHC;

# PODNAME: Device::LSM303DLHC 
# ABSTRACT: I2C interface to LSM303DLHC 3 axis magnetometer(compass) and accelerometer using Device::SMBus
# COPYRIGHT
# VERSION

use 5.010;
use Moose;
use POSIX;

# Dependencies
use Device::LSM303DLHC::Compass;
use Device::LSM303DLHC::Accelerometer;

=attr I2CBusDevicePath

this is the device file path for your I2CBus that the LSM303DLHC is connected on e.g. /dev/i2c-1
This must be provided during object creation.

=cut

has 'I2CBusDevicePath' => (
    is       => 'ro',
    required => 1,
);

=attr Compass

    $self->Compass->enable();
    $self->Compass->getReading();

This is a object of [[Device::LSM303DLHC::Compass]]

=cut

has Compass => (
    is => 'ro',
    isa => 'Device::LSM303DLHC::Compass',
    lazy_build => 1,
);

sub _build_Compass {
    my ($self) = @_;
    my $obj = Device::LSM303DLHC::Compass->new(
        I2CBusDevicePath => $self->I2CBusDevicePath
    );
    return $obj;
}

=attr Accelerometer 

    $self->Accelerometer->enable();
    $self->Accelerometer->getReading();

This is a object of [[Device::LSM303DLHC::Accelerometer]]

=cut

has Accelerometer => (
    is => 'ro',
    isa => 'Device::LSM303DLHC::Accelerometer',
    lazy_build => 1,
);

sub _build_Accelerometer {
    my ($self) = @_;
    my $obj = Device::LSM303DLHC::Accelerometer->new(
        I2CBusDevicePath => $self->I2CBusDevicePath
    );
    return $obj;
}

1;
