package Device::LSM303DLHC;

# PODNAME: Device::LSM303DLHC 
# ABSTRACT: I2C interface to LSM303DLHC 3 axis magnetometer(compass) and accelerometer using Device::SMBus
# COPYRIGHT
# VERSION

use 5.010;
use Moose;
use POSIX

# Dependencies
use Device::LSM303DLHC::Compass;
use Device::LSM303DLHC::Accelerometer;

has 'I2CBusDevicePath' => (
    is => 'ro',
);

has Compass => (
    is => 'ro',
    isa => 'Device::LSM303DLHC::Compass',
    lazy_build => 1,
);

sub _build_Compass {
    my ($self) = @_;
    my $obj = Device::LSM303DLHC::Compass->new(
        I2CBusDevicePath => $self->I2CBusDevicePath;
    );
    return $obj;
}

has Accelerometer => (
    is => 'ro',
    isa => 'Device::LSM303DLHC::Accelerometer',
    lazy_build => 1,
);

sub _build_Accelerometer {
    my ($self) = @_;
    my $obj = Device::LSM303DLHC::Accelerometer->new(
        I2CBusDevicePath => $self->I2CBusDevicePath;
    );
    return $obj;
}

1;
